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


  Future addPegawai(Pegawai pegawai, User user) async {
    final _url = "$_baseUrl/manageEmployee/newEmployee";
    final Map jsonData = {
      "id_outlet": pegawai.id_outlet,
      "name_user": user.name_user,
      "username": user.username,
      "email_user": user.email_user,
      "password_user": user.password_user,
      "phone_user": user.phone_user,
      "role": pegawai.role
    };
    print(pegawai);
    print(user);
    final response = await client.post("$_url",
        headers: {"Content-Type": "application/json"},
        body: json.encode(jsonData));
    final responseString = jsonDecode(response.body);
    print(response.body);
    if (response.statusCode == 200) {
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