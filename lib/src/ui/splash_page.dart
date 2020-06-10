import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
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