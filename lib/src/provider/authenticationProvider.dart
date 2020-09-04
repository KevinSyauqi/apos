import 'dart:convert';

import 'package:apos/src/constant.dart';
import 'package:apos/src/models/models.dart';
import 'package:http/http.dart';

class AuthenticationProvider {
  Client client = Client();
  final _baseUrl = AppUrl.url;

  Future login(String username, String password) async {
    final _url = "$_baseUrl/auth/loginUser";

    final Map jsonData = {
      "username": username,
      "password_user": password
    };

    final response = await client.post("$_url",
        headers: {"Content-Type": "application/json"},
        body: json.encode(jsonData));
    final responseString = jsonDecode(response.body);
    if (response.statusCode == 201 || response.statusCode == 401) {
      return responseString;
    } else{
      final message = responseString['message'];
      throw Exception('$message');
    }
  }
}
