import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'package:apos/src/models/userModels.dart';

class UserProvider {
  Client client =  Client();
  final _url = "https://apos-server.herokuapp.com";

//  Future<List<User>> fetchUserList() async{
//    final response = await client.get(_url);
//    if(response.statusCode == 200){
//      return compute(userFromJson, response.body);
//    } else {
//      throw Exception('Failed to load');
//    }
//  }

  Future registerUser(User user) async {
    final response = await client.post("$_url/auth/register", body: {
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