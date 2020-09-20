import 'package:apos/src/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];

}

class AuthenticationStarted extends AuthenticationEvent {}

class AuthenticationLoggedIn extends AuthenticationEvent {
  final String token;
  final User user;

  const AuthenticationLoggedIn({@required this.token, this.user});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'LoggedIn { token: $token }';
}

class AuthenticationLoggedOut extends AuthenticationEvent {}

class AuthenticationFailed extends AuthenticationEvent {}