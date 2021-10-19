import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseHandler {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  //This is bool function which returns whether user uid is in database or not
  Future<bool> userHasDatabase() async {
    bool _flag = false;
    if (_firebaseAuth.currentUser != null) {
      await _fireStore
          .collection('Users')
          .where('uid', isEqualTo: _firebaseAuth.currentUser!.uid)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
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
      _fireStore.collection('Users').add({
        'uid': currentUser.uid,
        'displayName': displayName,
        'enrollmentNumber': enrollmentNumber,
        'instituteName': instituteName,
        'contactNumber': contactNumber,
        'emailId': currentUser.email,
        'photoURL': currentUser.photoURL,
        'joinedClasses' : []
      });
    } else
      throw 'Current user is null';
  }

  //This function is used in profile to fetch data from Users collection
  Future<QuerySnapshot<Map<String, dynamic>>> getAllUserData() async {
    if (_firebaseAuth.currentUser != null) {
     return await _fireStore
          .collection('Users')
          .where('uid', isEqualTo: _firebaseAuth.currentUser!.uid)
          .get();
    } else
      throw 'Current user is null';
  }

  //This function is used to create a class in Classes collection
  Future<void> createClass(String title, String description) async {
    User? currentUser = _firebaseAuth.currentUser;
    if(currentUser != null) {
      _fireStore.collection('Classes').add({
        'uid' : currentUser.uid,
        'title' : title,
        'description' : description,
        'classCode' : DateTime.now().millisecondsSinceEpoch.toString(),
        });
    }
  }

  // Future<void> joinClass(List<String> l) async {
  //   User? currentUser = _firebaseAuth.currentUser;
  //   if(currentUser != null) {
  //     _fireStore.collection('Users')
  //         .where('uid', isEqualTo: _firebaseAuth.currentUser!.uid)
  //   }
  // }

  //Streaming data from Classes;
  Stream<QuerySnapshot> streamCreateClasses() {
    User? currentUser = _firebaseAuth.currentUser;
    return _fireStore.collection('Classes').where('uid', isEqualTo: currentUser!.uid).snapshots();
  }
}

