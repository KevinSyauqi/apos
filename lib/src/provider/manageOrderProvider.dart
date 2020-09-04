import 'dart:convert';

import 'package:apos/src/constant.dart';
import 'package:apos/src/models/models.dart';
import 'package:http/http.dart';

class manageOrderProvider {
  Client client = Client();
  final _baseUrl = AppUrl.url;
  final _prefix = AppUrl.urlOrder;

  Future<List<Menu>> fetchAllMenu() async {
    final _url = "$_baseUrl/manageMenu/allMenu";

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

  List<Menu> parsedListResponse(final response) {
    final responseString = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return ListMenu.fromJson(responseString).menus;
    } else {
      throw Exception('Failed to load menu');
    }
  }
}
