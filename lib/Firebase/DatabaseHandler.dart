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
        'photoURL': currentUser.photoURL
      });
    } else
      throw 'Current user is null';
  }

  Future<Map<String, dynamic>> getAllUserData() async {
    if (_firebaseAuth.currentUser != null) {
      await _fireStore
          .collection('Users')
          .where('uid', isEqualTo: _firebaseAuth.currentUser!.uid)
          .get()
          .then((value) {
            return value.docs.asMap();
      });
    } else
      throw 'Current user is null';

    return {};
  }
}

//String _displayName="", _enrollmentNumber="", _instituteName="", _contactNumber="";
