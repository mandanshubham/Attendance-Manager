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
          .get().then((value) {
        if (value.docs.isNotEmpty) {
          _flag = true;
        }
      }).catchError((error) => throw(error));
    }

    return _flag;
  }
}
