import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/screens/services/auth.dart';
import 'package:flutter_firebase_test/shared/loading.dart';
import 'package:flutter_firebase_test/shared/validation.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final validate = Validation();
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text('Register'),
              elevation: 0,
              backgroundColor: Colors.grey[850],
              centerTitle: true,
              actions: [
                FlatButton.icon(
                    onPressed: () {
                      setState(() {
                        setState(() => widget.toggleView());
                      });
                    },
                    icon: Icon(
                      Icons.person,
                      color: Colors.grey[100],
                    ),
                    label: Text(
                      'Sign in',
                      style: TextStyle(color: Colors.grey[100]),
                    ))
              ],
            ),
            body: SafeArea(
              child: Container(
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      end: Alignment.topLeft,
                      begin: Alignment.bottomRight,
                      colors: [Colors.grey[900], Colors.grey[900]]),
                ),
                child: ListView(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                      child: Stack(
                        children: [
                          Form(
                            key: _formKey,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  error.isNotEmpty
                                      ? Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 30),
                                          color: Colors.red[50],
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                error,
                                                style: TextStyle(
                                                    color: Colors.red[900]),
                                              ),
                                              /*   CloseButton(
                                            color: Colors.red[900],
                                            onPressed: () => error.isEmpty), */
                                            ],
                                          ),
                                        )
                                      : SizedBox(),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text('EMAIL',
                                      style:
                                          TextStyle(color: Colors.grey[100])),
                                  TextFormField(
                                    style: TextStyle(color: Colors.grey[100]),
                                    validator: (val) => !validate.isEmail(val)
                                        ? 'Invalid email!'
                                        : null,
                                    onChanged: (val) => email = val,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text('PASSWORD',
                                      style:
                                          TextStyle(color: Colors.grey[100])),
                                  TextFormField(
                                    obscureText: true,
                                    style: TextStyle(color: Colors.grey[100]),
                                    validator: (value) => value.length < 8
                                        ? "Password must be at least 8 characters"
                                        : null,
                                    onChanged: (value) => password = value,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      RaisedButton(
                                        color: Colors.grey[100],
                                        onPressed: () async {
                                          if (_formKey.currentState
                                              .validate()) {
                                            loading = true;
                                            dynamic result =
                                                await _auth.registerWithEmail(
                                                    email, password);
                                            if (result == null)
                                              setState(() {
                                                error =
                                                    "This account is already registered";
                                                loading = false;
                                              });
                                          }
                                        },
                                        child: Text(
                                          'Register',
                                          style: TextStyle(
                                              color: Colors.grey[900]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
