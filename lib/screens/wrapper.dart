import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/models/user.dart';
import 'package:flutter_firebase_test/screens/home/home.dart';
import 'package:flutter_firebase_test/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User>(context);

    if (_user == null)
      return Authenticate();
    else
      return Home();
  }
}
