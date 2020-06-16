import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/models/models.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegisterEvent {}

class RegisterButtonPressed extends RegisterEvent{
  final String name;
  final String email;
  final String username;
  final String password;
  final String phone;
  final String photo;


  RegisterButtonPressed({this.name, this.email, this.username, this.password,
    this.phone, this.photo});
}
