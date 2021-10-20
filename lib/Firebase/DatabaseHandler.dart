import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class DatabaseHandler {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  //This is bool function which returns whether user uid is in database or not
  Future<bool> userHasDatabase() async {
    bool _flag = false;
    User? currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      await _fireStore
          .collection('Users')
          .doc(currentUser.uid.toString())
          .get()
          .then((value) {
        if (value.exists) {
          _flag = true;
        }
      }).catchError((error) => throw (error));
    }

    return _flag;
  }

  //This function add user input to database;
  Future<void> addUserToDatabase(String displayName, String instituteName,
      String enrollmentNumber, String contactNumber) async {
    User? currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      _fireStore.collection('Users').doc(currentUser.uid).set({
        'uid': currentUser.uid,
        'displayName': displayName,
        'enrollmentNumber': enrollmentNumber,
        'instituteName': instituteName,
        'contactNumber': contactNumber,
        'emailId': currentUser.email,
        'photoURL': currentUser.photoURL,
      });
    } else
      throw 'Current user is null';
  }

  //This function is used in profile to fetch data from Users collection
  Future<DocumentSnapshot<Map<String, dynamic>>> getAllUserData() async {
    User? currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      return await _fireStore
          .collection('Users')
          .doc(currentUser.uid.toString())
          .get();
    } else
      throw 'Current user is null';
  }

  //This function is used to create a class in Classes collection
  Future<void> createClass(String title, String description) async {
    User? currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      _fireStore.collection('Classes').add({
        'uid': currentUser.uid,
        'title': title,
        'description': description,
        'classCode': DateTime.now().millisecondsSinceEpoch.toString(),
        'students': []
      });
    }
  }

  Future<void> joinClass(String classCode) async {
    User? currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      var snapshot = _fireStore
          .collection('Classes')
          .where('classCode', isEqualTo: classCode)
          .get()
          .catchError((e) {
        throw 'Error finding the class code';
      });

      String docId;
      await snapshot.then((value) {
        docId = value.docs[0].id;
        if (docId.isNotEmpty) {
          _fireStore.collection('Classes').doc(docId).update({
            'students': FieldValue.arrayUnion([currentUser.uid.toString()])
          });
        }
      });
    } else
      throw 'Error in joinedClass() function';
  }

  //Streaming data from Classes;
  Stream<QuerySnapshot> streamCreateClasses() {
    User? currentUser = _firebaseAuth.currentUser;
    return _fireStore
        .collection('Classes')
        .where('uid', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  Stream<QuerySnapshot> streamJoinedClasses() {
    User? currentUser = _firebaseAuth.currentUser;
    return _fireStore
        .collection('Classes')
        .where('students', arrayContains: currentUser!.uid.toString())
        .snapshots();
  }


}

