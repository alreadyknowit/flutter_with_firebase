import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/screens/services/auth.dart';
import 'package:flutter_firebase_test/shared/loading.dart';

class Settings extends StatefulWidget {
  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {
  AuthService _auth = new AuthService();
  Color randomColor() {
    int index = 0;
    List colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.amber,
      Colors.deepPurple
    ];
    Random rnd = new Random();
    index = rnd.nextInt(6);
    return colors[index];
  }

  dynamic data;
  Future<dynamic> getData() async {
    final DocumentReference document =
        Firestore.instance.collection("users").document('ac1');

    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      data = snapshot.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          } else {
            return Scaffold(
              body: Container(
                padding: EdgeInsets.fromLTRB(30, 80, 30, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: randomColor(),
                            //backgroundImage: AssetImage('assets/avatars/male1.jpg'),
                            radius: 60,
                            child: Text(
                              "Ali"[0].toUpperCase(),
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text("dasdas"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Wrap(children: [
                      Text(
                        "Name:",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ]),
                    SizedBox(
                      height: 40,
                    ),
                    Wrap(children: [
                      Text(
                        "Username:",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "User fullname will display here",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            );
          }
        });
  }
}
