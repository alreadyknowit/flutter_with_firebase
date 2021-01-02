import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/screens/services/auth.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';
import 'screens/wrapper.dart';
//import 'test.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value:AuthService().userr ,
          child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Test(),
    );
  }
}*/
