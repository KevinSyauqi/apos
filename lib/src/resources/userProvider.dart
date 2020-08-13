import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:apos/src/models/userModels.dart';

import '../constant.dart';

class UserProvider {
  Client client =  Client();
  final _url = AppUrl.url;

  Future registerUser(User user) async {
    final response = await client.post("$_url/auth/register", body: {
      'name_user' : user.name_user,
      'email_user' : user.email_user,
      'username' : user.username,
      'password_user' : user.password_user,
      'phone_user' : user.phone_user,
//      'photo_user' : user.photo_user;
    });
    print(response.body);
    final responseString = jsonDecode(response.body);
    if(response.statusCode == 201){
      return responseString;
    } else {
      throw Exception('Failed to register user');
    }
  }

  Future loginUser({String email, String password}) async {
    final response = await client.post("$_url/auth/login", body: {
      'email_user' : email,
      'password_user' : password
    });

    if(response.statusCode == 404){
      return response;
    } else {
      throw Exception('Login Failed');
    }
  }
}