import 'dart:convert';

import 'package:apos/src/models/models.dart';
import 'package:http/http.dart';

class TransactionMenuProvider {
  Client client = Client();
  final _baseUrl = "https://apos-server.herokuapp.com";

  Future<List<Menu>> fetchAllMenuOutlet(String outlet) async {
    final _url = "$_baseUrl/manageMenu/allMenuOutlet?id_outlet=$outlet";

    final response = await client.get(_url);

    if (response.statusCode != 200) {
      throw new Exception('Error getting menu');
    }
    return parsedListResponse(response);
  }

  Future createOrder(ListOrder listOrder, Sales sales) async {
    final _url = "$_baseUrl/manageTransaction/createOrder";

    final Map jsonData = sales.toJson();
    jsonData["listOrder"] = listOrder.toJson();

    final response = await client.post("$_url",
        headers: {"Content-Type": "application/json"},
        body: json.encode(jsonData));
    final responseString = jsonDecode(response.body);
    if (response.statusCode == 201) {
      return responseString;
    } else {
      final message = responseString['message'];
      throw Exception('$message');
    }
  }

//  Menu parsedJson(final response){
//    final jsonDecode = json.decode(response);
//
//    final jsonMenu = jsonDecode["data"];
//
//    return Menu.fromJson(jsonMenu);
//  }

  List<Menu> parsedListResponse(final response) {
    final responseString = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return ListMenu.fromJson(responseString).menus;
    } else {
      throw Exception('Failed to load menu');
    }
  }
}
