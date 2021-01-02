import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_test/models/user.dart';

class AuthService {
  /*
  aa
   ////////////   SIGN IN ANON  ////////////
  Sign in anon. There is a button in the sign in page that let's you sign in anon. 
  When you click on that button. There is a async method onpressed. In that method,
  we call for AuthService class signInAnonymously. How we do that when first create an 
  AuthService object. 'final AuthService _auth = AuthService();' then, call for
  _auth.signInAnonymously. in that method we return a FirebaseUser at first. But,
  we want to create our own user object.  To do that, first creat your own user object.
  In that method, take a FirebaseUser as a parameter and convert it to your own user object
  and return it.
  */

  // creating user object
  User _firebaseUserToUser(FirebaseUser firebaseUser) {
    return firebaseUser != null ? User(uid: firebaseUser.uid) : null;
  }

  Future<User> signInAnonymously() async {
    try {
      AuthResult result = await FirebaseAuth.instance.signInAnonymously();
      FirebaseUser user = result.user;
      print(user.uid + " Anon signed in");
      return _firebaseUserToUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

/*
/////////////////// STREAMS /////////////////
We use streams in order to get data from firebase constantly. Think about instagram,
when you refresh the page all the posts come out. You don't need to close the app
and rerun it. Another example is whatsapp. When the mesagge come, we see it instantly.
That where we use streams. 
Implementation of stream.
First create a FirebaseAuth instance
then a method for 'Stream<FirebaseUSer> get user {}'
to return firebase user just return _auth.onAuthStateChanged;

Recomended that return own user type object, more secure.
// TO DO that
change Stream<Firebase> to Stream<User> because now you are returning a user object
no a FirebaseUser object. Then, map onAuthStateChanged. Convert FirebaseUser to
user object via _firebaseUserToUser that you created earlier.

User that builded stream. Go and implement provider package in pubspec.yaml
While the stream covers the whole app. You must implement it in main.dart
Go there and cover MaterialApp with StreamProvider<User>.value, 
then implement a value inside that widget and assigened it to AuthService().userr

Thus, you can access the User object in the whole MaterialApp. That means in the 
whole app.

To access the user you just need to implement the following.
final user =Provider.of<User>(context);

*/
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Stream<User> get userr {
    return _firebaseAuth.onAuthStateChanged.map(_firebaseUserToUser);

    //Or you can do it like that in the long way.
    // .map((FirebaseUser firebaseUser) => _firebaseUserToUser(firebaseUser));
  }

  //Sing in with email and password
  Future<User> signInWithEmail(String email, String password) async {
    try {
      AuthResult result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      return _firebaseUserToUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //update user data
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  Future updateUserData(String username, String name, String surname) async {
    return await usersCollection.document().setData({
      'username': username,
      'name': name,
      'surname': surname,
    });
  }

  //register a user with email and password
  Future<User> registerWithEmail(String email, String password) async {
    try {
      AuthResult result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser _user = result.user;
      await updateUserData('username', 'name', 'surname');
      return _firebaseUserToUser(_user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //To logout just convert the user to null value.

  Future logout() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
