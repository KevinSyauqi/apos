import 'dart:convert';

import 'package:apos/src/constant.dart';
import 'package:apos/src/models/models.dart';
import 'package:http/http.dart';

class HistoryProvider {
  Client client =  Client();
  final _baseUrl = AppUrl.url;
  final _prefix = AppUrl.urlSales;

  Future getSalesHistory() async{
    final url = "$_baseUrl/$_prefix/allSales";

    final response = await client.get(url);
    final responseString = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return responseString;
    }else{
      final message = responseString['message'];
      throw new Exception('$message');
    }
  }

  Future getDetailSalesHistory(String id_sale) async{
    final url = "$_baseUrl/$_prefix/detailSales?id_sale=$id_sale";

    final response = await client.get(url);
    final responseString = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return responseString;
    }else{
      final message = responseString['message'];
      throw new Exception('$message');
    }
  }

  List<Sales> parsedListResponse(final response){
    final responseString = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return ListSales.fromJson(responseString).listSales;
    } else {
      throw Exception('Failed to load menu');
    }
  }

}