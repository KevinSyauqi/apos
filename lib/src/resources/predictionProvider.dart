import 'dart:convert';

import 'package:apos/src/constant.dart';
import 'package:apos/src/models/predictionModels.dart';
import 'package:http/http.dart';

class PredictionProvider {
  Client client =  Client();
  final _baseUrl = AppUrl.url;

  Future<List<Prediction>> fetchAllPredictionOutletMenu(String id_outlet) async{
    final url = "$_baseUrl/predict/allPredictionSales?id_outlet=$id_outlet";

    final response = await client.get(url);


    if (response.statusCode != 200) {
      throw new Exception('Error getting employee');
    }
    return parsedListResponse(response);
  }

  List<Prediction> parsedListResponse(final response){
    final responseString = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return ListPrediction.fromJson(responseString).listPredictions;
    } else {
      throw Exception('Failed to load menu');
    }
  }

}