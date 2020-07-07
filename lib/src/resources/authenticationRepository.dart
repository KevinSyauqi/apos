import 'package:flutter/cupertino.dart';

class AuthenticationRepository {

  Future<String> authenticate(
      {@required String email, @required String password}) async {
    await Future.delayed(Duration(seconds: 1));
    return 'token';
  }

  Future<void> deactiveToken() async {
    await Future.delayed(Duration(seconds: 1));
  }

  Future<bool> isTokenActive() async{
    await Future.delayed(Duration(seconds: 1));
    return false;
  }
}
