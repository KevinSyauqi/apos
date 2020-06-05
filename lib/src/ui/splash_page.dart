import 'package:apos/src/bloc/authentication/authenticationBloc.dart';
import 'package:apos/src/bloc/authentication/authenticationState.dart';
import 'package:apos/src/ui/transaksi_menu.dart';
import 'package:flutter/material.dart';
import 'package:apos/src/ui/login_page.dart';
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) {
          return BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticationAuthenticated) {
                // show home page
                return TransaksiMenu();
              }
              // otherwise show login page
              return LoginPage();
            },
          );
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(54, 58, 155, 1),
      body: Container(
        padding: EdgeInsets.all(60.0),
        child: Center(
          child: Image(image: AssetImage('images/splash.png')),
        ),
      ),
    );
  }
}
