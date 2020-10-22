import 'package:flutter/material.dart';
import "package:flutterbidapp/Screens/Login/login_screen.dart";
import 'package:flutterbidapp/constants.dart';
import 'package:flutterbidapp/Screens/Signup/signup_intro_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bid App',

      home: SignUpIntroScreen(),
    );
  }
}
