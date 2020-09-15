import 'dart:convert';

import 'package:apos/src/constant.dart';
import 'package:apos/src/models/models.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

class ManageMenuProvider {
  Client client = Client();
  final _baseUrl = AppUrl.url;
  final _prefix = AppUrl.urlManageMenu;

  Future<List<Menu>> fetchAllMenu() async {
    final _url = "$_baseUrl/manageMenu/allMenu";

    final response = await client.get(_url);

    print(response.body.toString());
    if (response.statusCode != 200) {
      throw new Exception('Error getting menu');
    }
    return parsedListResponse(response);
  }

  Future addMenu(Menu menu) async {
    final _url = "$_baseUrl/$_prefix/addMenu";

    final Map jsonData = {
      "name_menu": menu.name_menu,
      "photo_menu": null,
      "category": menu.category,
      "cost": menu.cost,
      "price": menu.price
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

  Future updateMenu(Menu menu) async {
    final _url = "$_baseUrl/$_prefix/menuUpdate";
    final Map jsonData = menu.toJson();

    // print(jsonData);

    final response = await client.post("$_url",
        headers: {"Content-Type": "application/json"},
        body: json.encode(jsonData));
    final responseString = jsonDecode(response.body);
    print(response.body);
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
