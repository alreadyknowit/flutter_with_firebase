import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/screens/home/settings.dart';
import 'package:flutter_firebase_test/screens/services/auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, snapshot) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          backgroundColor: Colors.grey[900],
          elevation: 0,
          actions: [
            FlatButton.icon(
                onPressed: () async {
                  await _authService.logout();
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.grey[100],
                ),
                label: Text(
                  'Logout',
                  style: TextStyle(color: Colors.grey[100]),
                )),
          ],
        ),
        body: FlatButton.icon(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Settings()));
            },
            icon: Icon(Icons.settings),
            label: Text('User Profile')),
      );
    });
  }
}
