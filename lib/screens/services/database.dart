import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  String uid;
  Database({this.uid});
  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  Stream<DocumentSnapshot> get userData {
    return userCollection.document(uid).snapshots();
  }
}
