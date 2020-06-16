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
  bool _status;


  User(this._name_user, this._email_user, this._username, this._password_user,
      this._phone_user, this._photo_user);

  bool get status => _status;

  set status(bool value) {
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

  String get name_user => _name_user;

  set name_user(String value) {
    _name_user = value;
  }

  String get id_user => _id_user;


  User.fromJson(Map<String, dynamic> json) {
    _id_user = json["id_user"];
    _name_user = json['name_user'];
    _email_user = json['email_user'];
    _username = json['username'];
    _password_user = json['password'];
    _phone_user = json['phone_user'];
    _photo_user = json['photo_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_user'] = this._id_user;
    data['name_user'] = this._name_user;
    data['email_user'] = this._email_user;
    data['username'] = this._username;
    data['password_user'] = this._password_user;
    data['phone_user'] = this._phone_user;
    data['photo_user'] = this._photo_user;
  }

}