import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'package:apos/src/models/userModels.dart';

class UserProvider {
  Client client =  Client();
  final String _url = "https://apos-server.herokuapp.com";
  final Dio _dio = Dio();

  // GET user data
  Future<User> getUser() async {
    try{
      Response response = await _dio.get("$_url/user/");
      return User.fromJason(response.data);
    } catch (error, stackrace) {
      print("Exception occured: $error stackrace: $stackrace");
      throw Exception("Failed to get user. [$error]");
    }
  }

  // POST to add user
  Future registerUser(User user) async {
    final response = await _dio.post("$_url/auth/register", data: {
      'name_user' : user.name_user,
      'email_user' : user.email_user,
      'username' : user.username,
      'password_user' : user.password_user,
      'phone_user' : user.phone_user,
//      'photo_user' : user.photo_user;
    });

    if(response.statusCode == 201){
      return response;
    } else {
      throw Exception('Failed to register user');
    }
  }

}