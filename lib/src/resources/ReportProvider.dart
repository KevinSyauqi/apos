import 'dart:convert';
import 'package:apos/src/constant.dart';
import 'package:apos/src/models/models.dart';
import 'package:http/http.dart';

class ReportProvider{

  Client client =  Client();
  final _baseUrl = AppUrl.url;

  Future<List<SalesLineItem>> getReportSales(String id_outlet_menu, String start_date, String end_date) async{
    final url = "$_baseUrl/report/reportSales?id_outlet_menu=$id_outlet_menu&start_date=$start_date&end_date=$end_date";

    final response = await client.get(url);

    if (response.statusCode != 200) {
      throw new Exception('Error getting employee');
    }
    return parsedListResponse(response);
  }

  List<SalesLineItem> parsedListResponse(final response){
    final responseString = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return ListOrder.fromJson(responseString).listOrder;
    } else {
      throw Exception('Failed to load menu');
    }
  }

}