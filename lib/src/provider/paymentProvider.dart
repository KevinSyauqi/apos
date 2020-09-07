import 'dart:convert';

import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/constant.dart';
import 'package:apos/src/models/models.dart';
import 'package:http/http.dart';

class PaymentProvider {
  Client client = Client();
  final _baseUrl = AppUrl.url;
  final _prefix = AppUrl.urlSales;

  Future createPayment(Order order) async {
    final _url = "$_baseUrl/$_prefix/orderPayment";

    final Map jsonData = order.toJson();

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
}
