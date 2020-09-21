import 'dart:convert';

import 'package:apos/src/constant.dart';
import 'package:apos/src/models/models.dart';
import 'package:apos/src/models/photoModels.dart';
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

    Future<List<Photo>> fetchAllPhoto() async {
    final _url = "$_baseUrl/manageMenu/allPhoto";

    final response = await client.get(_url);

    print(response.body.toString());
    if (response.statusCode != 200) {
      throw new Exception('Error getting menu');
    }
    return parsedListPhotoResponse(response);
  }

  Future addMenu(Menu menu, Photo photo) async {
    final _url = "$_baseUrl/$_prefix/addMenu";

    final Map jsonData = {
      "name_menu": menu.name_menu,
      "base64_photo": photo.base64_photo,
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

  Future updateMenu(Menu menu, Photo photo) async {
    final _url = "$_baseUrl/$_prefix/menuUpdate";
    final Map jsonData = {
      "name_menu": menu.name_menu,
      "base64_photo": photo.base64_photo,
      "category": menu.category,
      "cost": menu.cost,
      "price": menu.price
    };

    // print(jsonData);

    final response = await client.put("$_url",
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

  Future deactiveMenu(String id_menu) async {
    final _url = "$_baseUrl/$_prefix/deactiveMenu";
    final Map jsonData = {
      "id_menu": id_menu
    };

    final response = await client.put("$_url",
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

  Future activeMenu(String id_menu) async {
    final _url = "$_baseUrl/$_prefix/activeMenu";
    final Map jsonData = {
      "id_menu": id_menu
    };

    final response = await client.put("$_url",
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

  Future fetchMenu(String id_menu) async{
    final _url = "$_baseUrl/$_prefix/menu?id_menu=$id_menu";

    final response = await client.get(_url);
    final responseString = jsonDecode(response.body);

    print(response.body);
    if (response.statusCode == 200) {
      return responseString;
    }else{
      final message = responseString['message'];
      throw new Exception('$message');
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

    List<Photo> parsedListPhotoResponse(final response) {
    final responseString = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return ListPhoto.fromJson(responseString).photos;
    } else {
      throw Exception('Failed to load photo');
    }
  }
}
