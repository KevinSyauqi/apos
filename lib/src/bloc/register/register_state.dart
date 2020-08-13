import 'package:apos/src/models/models.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterInProcess extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFailed extends RegisterState {
  final String message;
  RegisterFailed({this.message});
}
