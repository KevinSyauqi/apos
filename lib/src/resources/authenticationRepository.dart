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

  Future<void> persistToken(String token) async{
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<bool> hasToken() async{
    await Future.delayed(Duration(seconds: 1));
    return false;
  }
}
