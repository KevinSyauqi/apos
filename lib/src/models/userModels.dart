import 'package:equatable/equatable.dart';
import 'dart:convert';

class User {

  String _id_user;
  String _name_user;
  String _username;
  String _password_user;
  String _role;
  bool _status;

  User(this._name_user, this._username, this._password_user);

  String get id_user => _id_user;

  String get name_user => _name_user;

  String get username => _username;

  String get password_user => _password_user;

  String get role => _role;

  bool get status => _status;


  set name_user(String value) {
    _name_user = value;
  }

  set username(String value) {
    _username = value;
  }

  set password_user(String value) {
    _password_user = value;
  }

  set status(bool value) {
    _status = value;
  }

  User.fromJson(Map<String, dynamic> json) {
    _id_user = json["id_user"];
    _name_user = json['name_user'];
    _username = json['username'];
    _role = json['role_name'];
    _password_user = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_user'] = this._id_user;
    data['name_user'] = this._name_user;
    data['username'] = this._username;
    data['password_user'] = this._password_user;
    return data;
  }
}