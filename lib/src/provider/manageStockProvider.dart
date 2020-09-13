import 'dart:convert';

import 'package:apos/src/constant.dart';
import 'package:apos/src/models/models.dart';
import 'package:http/http.dart';

class ManageStockProvider {
  Client client = Client();
  final _baseUrl = AppUrl.url;
  final _prefix = AppUrl.urlManageStock;

  Future<List<Menu>> fetchAllStock() async {
    final _url = "$_baseUrl/manageStock/allStock";

    final response = await client.get(_url);

    print(response.body.toString());
    if (response.statusCode != 200) {
      throw new Exception('Error getting Stock menu');
    }
    return parsedListResponse(response);
  }

  Future fetchOrderDetail(String id_order) async {
    final _url = "$_baseUrl/$_prefix/orderDetail?id_order=$id_order";

    final response = await client.get(_url);
    final responseString = jsonDecode(response.body);

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
      throw Exception('Failed to load stock menu');
    }
  }
}
