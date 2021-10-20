import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ListOfStudents {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  String sName="", sEnrollmentNumber="", sUid ="";

  ListOfStudents(String uid) {
     _fireStore.collection('Users').doc(uid).get().then((value) {
       sName = value['displayName'];
       sEnrollmentNumber = value['enrollmentNumber'];
     });
  }

}