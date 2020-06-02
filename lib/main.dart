import 'package:apos/src/ui/splash_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(Apos());

class Apos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashPage(),
    );
  }
}