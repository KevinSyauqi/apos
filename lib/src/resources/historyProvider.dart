import 'dart:convert';

import 'package:apos/src/models/models.dart';
import 'package:http/http.dart';

class HistoryProvider {
  Client client =  Client();
  final _baseUrl = "https://apos-server.herokuapp.com";

  Future<List<Sales>> getAllOutletSales(String id_outlet) async{
    final url = "$_baseUrl/trsc/outletSales?id_outlet=$id_outlet";

    final response = await client.get(url);


    if (response.statusCode != 200) {
      throw new Exception('Error getting outlet');
    }
    return parsedListResponse(response);
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