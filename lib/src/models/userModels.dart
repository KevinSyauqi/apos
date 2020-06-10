import 'package:equatable/equatable.dart';
import 'dart:convert';

class User {

  String _id_user;
  String _name_user;
  String _email_user;
  String _username;
  String _password_user;
  String _phone_user;
  String _photo_user;
  String _status;


  User(this._name_user, this._email_user, this._username, this._password_user,
      this._phone_user, this._photo_user);

  String get id_user => _id_user;

  set id_user(String value) {
    _id_user = value;
  }

  String get name_user => _name_user;

  set name_user(String value) {
    _name_user = value;
  }

  String get status => _status;

  set status(String value) {
    _status = value;
  }

  String get photo_user => _photo_user;

  set photo_user(String value) {
    _photo_user = value;
  }

  String get phone_user => _phone_user;

  set phone_user(String value) {
    _phone_user = value;
  }

  String get password_user => _password_user;

  set password_user(String value) {
    _password_user = value;
  }

  String get username => _username;

  set username(String value) {
    _username = value;
  }

  String get email_user => _email_user;

  set email_user(String value) {
    _email_user = value;
  }


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
