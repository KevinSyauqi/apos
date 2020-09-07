import 'dart:convert';

import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/constant.dart';
import 'package:apos/src/models/models.dart';
import 'package:http/http.dart';

class PaymentProvider {
  Client client = Client();
  final _baseUrl = AppUrl.url;
  final _prefix = AppUrl.urlSales;

  Future createPayment(Order order, int cash, int change_amount) async {
    final _url = "$_baseUrl/$_prefix/orderPayment";

    final Map jsonData = {
      "cash": cash,
      "change_amount": change_amount
    };
    jsonData.addAll(order.toJson());

    final response = await client.post("$_url",
        headers: {"Content-Type": "application/json"},
        body: json.encode(jsonData));
    final responseString = jsonDecode(response.body);
    if (response.statusCode == 201) {
      return responseString;
    } else {
      print(response.body.toString());
      final message = responseString['message'];
      throw Exception('$message');
    }
  }

  Future getListOrderItem(String id_order) async {
    final _url = "$_baseUrl/order/orderDetail?id_order=$id_order";

    final response = await client.get(_url);
    final responseString = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return responseString;
    }else{
      final message = responseString['message'];
      throw new Exception('$message');
    }
  }
}
