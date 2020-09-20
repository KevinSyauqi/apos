import 'dart:convert';

import 'package:apos/src/constant.dart';
import 'package:apos/src/models/models.dart';
import 'package:http/http.dart';

class ManageOrderProvider {
  Client client = Client();
  final _baseUrl = AppUrl.url;
  final _prefix = AppUrl.urlOrder;

  Future<List<Menu>> fetchAllMenu() async {
    final _url = "$_baseUrl/manageMenu/allActiveMenu";

    final response = await client.get(_url);

    if (response.statusCode != 200) {
      throw new Exception('Error getting menu');
    }
    return parsedListResponse(response);
  }

  Future fetchListOrder() async {
    final _url = "$_baseUrl/$_prefix/noPaidOrder";

    final response = await client.get(_url);
    final responseString = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return responseString;
    }else{
      final message = responseString['message'];
      throw new Exception('$message');
    }
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

  Future createOrder(Order order, ListOrderItem listOrderItem) async {
    final _url = "$_baseUrl/$_prefix/orderCreate";

    final Map jsonData = order.toJson();
    jsonData.addAll(listOrderItem.toJson());

    print(jsonData);

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

  Future addToOrder(Order order, ListOrderItem listOrderItem) async {
    final _url = "$_baseUrl/$_prefix/orderAddition";

    final Map jsonData = order.toJson();
    jsonData.addAll(listOrderItem.toJson());

    print(jsonData);

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
