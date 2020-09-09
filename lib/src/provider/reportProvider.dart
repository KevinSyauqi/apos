import 'dart:convert';
import 'package:apos/src/constant.dart';
import 'package:apos/src/models/models.dart';
import 'package:http/http.dart';

class ReportProvider{

  Client client =  Client();
  final _baseUrl = AppUrl.url;
  final _prefix = AppUrl.urlReport;

  Future getReportSummary(String start_date, String end_date) async{
    final _url = "$_baseUrl/$_prefix/reportSummary?start_date=$start_date&end_date=$end_date";

    final response = await client.get(_url);
    final responseString = jsonDecode(response.body);

    print(response.body);
    if (response.statusCode == 200) {
      return responseString;
    }else{
      final message = responseString['message'];
      throw new Exception('$message');
    }
  }

}