import 'package:att_man/Model/student.dart';
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
  Future<void> createClass(String title, String description, String displayName, String emailId) async {
    User? currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      _fireStore.collection('Classes').add({
        'displayName' : displayName,
        'emailId' : emailId,
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

  Stream<QuerySnapshot> streamMessages(String classCode) {
    return _fireStore
        .collection('Messages')
        .where('classCode', isEqualTo: classCode)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> streamNotification(String classCode) {
    return _fireStore
        .collection('Messages')
        .where('classCode', isEqualTo: classCode)
        .snapshots();
  }

  Future<List<Student>> getStudents(List<String> ids) async {
    List<Future<DocumentSnapshot>> futures = [];
    ids.forEach((element) {
      Future<DocumentSnapshot> future =
          _fireStore.collection('Users').doc(element).get();
      futures.add(future);
    });
    List<DocumentSnapshot> studentData = await Future.wait(futures);
    List<Student> students = [];
    studentData.forEach((element) {
      Map data = element.data() as Map;
      Student student = new Student(
          data['uid'], data['displayName'], data['enrollmentNumber']);
      students.add(student);
    });
    return students;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getJoinedClassData(String classCode) async {
    late Future<QuerySnapshot<Map<String, dynamic>>> myDoc;
    await _fireStore
        .collection('Classes')
        .where('classCode', isEqualTo: classCode)
        .get().then((value) {
        myDoc =  value.docs[0].reference.collection('Attendance').orderBy('date', descending: true).get();
    });

    return myDoc;
  }



  Future<void> sendMessage(String classCode, String message, String title, String description,String displayName, String emailId) async {
    User? currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      _fireStore.collection('Messages').add({
        'displayName' : displayName,
        'emailId' : emailId,
        'uid': currentUser.uid,
        'title': title,
        'description': description,
        'classCode': classCode,
        'message' : message,
        'timestamp' : Timestamp.now()
      });
    }
  }

  Future<void> deleteClass(String classCode) async {
    var myDoc = _fireStore
        .collection('Classes')
        .where('classCode', isEqualTo: classCode)
        .get();

    myDoc.then((value) {
      String docId = value.docs[0].id;
      if(docId.isNotEmpty) {
       var attDocs = _fireStore.collection('Classes').doc(docId).collection('Attendance').get();
       attDocs.then((value) {
         value.docs.forEach((element) {
           String subDocId = element.id;
           _fireStore.collection('Classes').doc(docId).collection('Attendance').doc(subDocId).delete();
         });
       }).then((value) {
         _fireStore.collection('Classes').doc(docId).delete();
       });
      }
      else {
        throw 'Unable to delete, cause docId is empty';
      }
    });
  }
}
