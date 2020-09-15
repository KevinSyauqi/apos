import 'dart:convert';

import 'package:apos/src/constant.dart';
import 'package:apos/src/models/models.dart';
import 'package:http/http.dart';

class ManageStockProvider {
  Client client = Client();
  final _baseUrl = AppUrl.url;
  final _prefix = AppUrl.urlManageStock;

  Future<List<Menu>> fetchAllStock() async {
    final _url = "$_baseUrl/$_prefix/allStock";

    final response = await client.get(_url);

    print(response.body.toString());
    if (response.statusCode != 200) {
      throw new Exception('Error getting Stock menu');
    }
    return parsedListResponse(response);
  }

  Future updateStock(String id_menu, int quantity_stock) async {
    final _url = "$_baseUrl/$_prefix/stockUpdate";

    final Map jsonData = {
      "id_menu": id_menu,
      "quantity_stock": quantity_stock
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

  List<Menu> parsedListResponse(final response) {
    final responseString = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return ListMenu.fromJson(responseString).menus;
    } else {
      throw Exception('Failed to load stock menu');
    }
  }
}
