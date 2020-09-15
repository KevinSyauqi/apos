import 'dart:convert';

import 'package:apos/src/constant.dart';
import 'package:apos/src/models/predictionModels.dart';
import 'package:http/http.dart';

class PredictionProvider {
  Client client = Client();
  final _baseUrl = AppUrl.url;
  final _prefix = AppUrl.urlPrediction;

  Future getPredictionSummary() async {
    final _url = "$_baseUrl/$_prefix/predictionSummary";

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

  Future getDetailPrediction() async {
    final _url = "$_baseUrl/$_prefix/detailPrediction";

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
