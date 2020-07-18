import 'dart:convert';

import 'package:apos/src/constant.dart';
import 'package:apos/src/models/models.dart';
import 'package:http/http.dart';

class CheckoutProvider {
  Client client = Client();
  final _baseUrl = AppUrl.url;

  Future createOrder(Sales sales, ListOrder listOrder) async {
    final _url = "$_baseUrl/trsc/createSales";

    final Map jsonData = sales.toJson();
    jsonData.addAll(listOrder.toJson());
    print(jsonData.toString());

    final response = await client.post("$_url",
        headers: {"Content-Type": "application/json"},
        body: json.encode(jsonData));
    final responseString = jsonDecode(response.body);
    print(responseString);
    if (response.statusCode == 201) {
      return responseString;
    } else {
      final message = responseString['message'];
      throw Exception('$message');
    }
  }
}
