import 'package:apos/src/provider/authenticationProvider.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationRepository {

  AuthenticationProvider _authenticationProvider = AuthenticationProvider();

  Future authenticate(
      {@required String username, @required String password}) async {
    final response = await _authenticationProvider.login(username, password);
    return response;
  }

  Future<void> deactiveToken() async {
    await Future.delayed(Duration(seconds: 1));
  }

  Future<bool> isTokenActive() async{
    await Future.delayed(Duration(seconds: 1));
    return false;
  }
}
