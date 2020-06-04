import 'package:equatable/equatable.dart';
import 'dart:convert';

class User {

  String id_user;
  String name_user;
  String email_user;
  String username;
  String password_user;
  String phone_user;
  String photo_user;
  String status;

  User(this.name_user, this.email_user, this.username, this.password_user,
      this.phone_user, this.photo_user);


//  static User fromJson(dynamic json) {
//    return User(
//      id_user: json['id_user'],
//      name_user: json['name_user'],
//      email_user: json['email_user'],
//      username: json['username'],
//      password_user: json['password_user'],
//      phone_user: json['password_user'],
//      photo_user: json['photo_user']
//    );
//  }
//
//  @override
//  String toString() => 'User { id_user: $id_user }';
}
//
//List<User> userFromJson(String str){
//  final jsonData = json.decode(str);
//  return new List<User>.from(jsonData.map((x) => User.fromJson(x)));
//}
//
//String userToJson(List<User> data){
//  final dyn = new List<dynamic>.from(data.map((x) => x.userToJson()));
//  return json.encode(dyn);
//}
