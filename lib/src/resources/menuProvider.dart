import 'dart:convert';

import 'package:apos/src/constant.dart';
import 'package:apos/src/models/models.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

class MenuProvider {
  Client client = Client();
  final _baseUrl = AppUrl.url;

//  Future<Menu> fetchMenu() async{
//    final url = "$_baseUrl/manageMenu/addMenu";
//    final response = await this.client.get(url);
//
//    if (response.statusCode != 200) {
//      throw new Exception('Error getting menu');
//    }
//
//    final json = jsonDecode(response.body);
//    return Menu.fromJson(json);
//  }

  Future<List<Menu>> fetchAllMenuOutlet(String outlet) async {
    final _url = "$_baseUrl/manageMenu/allMenuOutlet?id_outlet=$outlet";

    final response = await client.get(_url);

    if (response.statusCode != 200) {
      throw new Exception('Error getting menu');
    }
    return parsedListResponse(response);
  }

  Future addMenu(Menu menu, String store) async {
    final _url = "$_baseUrl/manageMenu/addMenu";

    final Map jsonData = {
      "id_store": store,
      "id_outlet": "OS2000201",
      "name_menu": menu.name_menu,
      "description": menu.description,
      "category": menu.category,
      "photo_menu": menu.photo_menu,
      "cog": menu.cog,
      "price": menu.price,
      "is_stock": menu.is_stock,
      "stock": menu.stock
    };
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
