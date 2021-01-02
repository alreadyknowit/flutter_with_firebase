import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/screens/services/auth.dart';
import 'package:flutter_firebase_test/shared/loading.dart';
import 'package:flutter_firebase_test/shared/validation.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  // create a form key for validation
  final _formKey = GlobalKey<FormState>();
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final validate = Validation();
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String error = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text('Sign in'),
              elevation: 0,
              backgroundColor: Colors.grey[850],
              centerTitle: true,
              actions: [
                FlatButton.icon(
                  onPressed: () {
                    setState(() => widget.toggleView());
                  },
                  icon: Icon(
                    Icons.person,
                    color: Colors.grey[100],
                  ),
                  label: Text(
                    'Register',
                    style: TextStyle(color: Colors.grey[100]),
                  ),
                ),
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
                                  validate.chekErr(error)
                                      ? Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          color: Colors.red[50],
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                error,
                                                style: TextStyle(
                                                    color: Colors.red[900]),
                                              ),
                                              CloseButton(
                                                  color: Colors.red[900],
                                                  onPressed: () =>
                                                      validate.chekErr("")),
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
                                        ? 'Enter a valid email'
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
                                            setState(() => loading = true);
                                            dynamic result =
                                                await _auth.signInWithEmail(
                                                    email, password);
                                            if (result == null)
                                              setState(() {
                                                error =
                                                    "Email or password is incorrect";
                                                loading = false;
                                              });
                                          }
                                        },
                                        child: Text(
                                          'Sign in',
                                          style: TextStyle(
                                              color: Colors.grey[900]),
                                        ),
                                      ),
                                      FlatButton.icon(
                                          onPressed: () async {
                                            dynamic result =
                                                await _auth.signInAnonymously();
                                            if (result == null) {
                                              setState(() => error =
                                                  'Invalid information');
                                            }
                                          },
                                          icon: Icon(
                                            Icons.login,
                                            color: Colors.grey[100],
                                          ),
                                          label: Text(
                                            "Sign in anon",
                                            style: TextStyle(
                                                color: Colors.grey[100]),
                                          )),
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
