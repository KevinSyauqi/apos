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


    if (response.statusCode != 200) {
      throw new Exception('Error getting employee');
    }
    return parsedListResponse(response);
  }


  Future addPegawai(Pegawai pegawai, String id_outlet, String username, String email_user, String password_user, String phone_user, String role, String name_user) async {
    final _url = "$_baseUrl/managePegawai/addPegawai";

    final Map jsonData = {
      "id_outlet": "4069798d529343d59da680b1336d7dd6",
      "name_user": pegawai.name_user,
      "username": username,
      "email_user": email_user,
      "password_user": password_user,
      "phone_user": phone_user,
      "role": pegawai.role
    };
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

  List<Pegawai> parsedListResponse(final response){
    final responseString = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return ListPegawai.fromJson(responseString).listPegawai;
    } else {
      throw Exception('Failed to load menu');
    }
  }

}