import 'dart:convert';

import 'package:apos/src/models/models.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

class MenuProvider {
  Client client =  Client();
  final _baseUrl = "http://localhost:8000";

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

  Future<List<Menu>> fetchAllMenuOutlet(String outlet) async{
    final url = "$_baseUrl/manageMenu/allMenuOutlet?id_outlet=$outlet";

    final response = await client.get(url);


    if (response.statusCode != 200) {
      throw new Exception('Error getting menu');
    }
    return parsedListResponse(response);
  }

//  Menu parsedJson(final response){
//    final jsonDecode = json.decode(response);
//
//    final jsonMenu = jsonDecode["data"];
//
//    return Menu.fromJson(jsonMenu);
//  }

  List<Menu> parsedListResponse(final response){
    final responseString = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return ListMenu.fromJson(responseString).menus;
    } else {
      throw Exception('Failed to load menu');
    }
  }

}