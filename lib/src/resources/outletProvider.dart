import 'dart:convert';

import 'package:apos/src/models/models.dart';
import 'package:apos/src/models/outletModels.dart';
import 'package:http/http.dart';

class OutletProvider {
  Client client =  Client();
  final _baseUrl = "https://apos-server.herokuapp.com";

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

  Future<List<Outlet>> fetchAllOutletStore(String store) async{
    final url = "$_baseUrl/manageOutlet/allOutletByStore?id_store=$store";

    final response = await client.get(url);


    if (response.statusCode != 200) {
      throw new Exception('Error getting outlet');
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

  List<Outlet> parsedListResponse(final response){
    final responseString = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return ListOutlet.fromJson(responseString).outlets;
    } else {
      throw Exception('Failed to load menu');
    }
  }

}