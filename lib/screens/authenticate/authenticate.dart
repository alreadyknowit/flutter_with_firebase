import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/screens/authenticate/register.dart';
import 'package:flutter_firebase_test/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showRegister = false;

  void toggleBetweenRegisterAndSignIn() {
    setState(() {
      showRegister = !showRegister;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showRegister)
      return Register(toggleView: toggleBetweenRegisterAndSignIn);
    else
      return SignIn(toggleView: toggleBetweenRegisterAndSignIn);
  }
}
