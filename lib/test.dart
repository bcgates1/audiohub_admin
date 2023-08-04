import 'package:cloud_firestore/cloud_firestore.dart';

test() async {
  FirebaseFirestore firebase = FirebaseFirestore.instance;

  await firebase.collection('new').doc().set({'name': 'test', 'password': 'test'});
}
