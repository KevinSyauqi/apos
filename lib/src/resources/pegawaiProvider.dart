import 'dart:convert';

import 'package:apos/src/models/models.dart';
import 'package:apos/src/models/pegawaiModels.dart';
import 'package:http/http.dart';

class PegawaiProvider {
  Client client =  Client();
  final _baseUrl = "https://apos-server.herokuapp.com";


  Future<List<Pegawai>> fetchAllPegawaiOutlet(String outlet) async{
    final url = "$_baseUrl/manageEmployee/allEmployeeByOutlet?id_outlet=$outlet";

    final response = await client.get(url);


    if (response.statusCode != 201) {
      throw new Exception('Error getting outlet');
    }
    return parsedListResponse(response);
  }


  List<Pegawai> parsedListResponse(final response){
    final responseString = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return ListPegawai.fromJson(responseString).listPegawai;
    } else {
      throw Exception('Failed to load menu');
    }
  }

}