import 'package:att_man/Utils/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class JoinedClassAttendanceList extends StatelessWidget {

  final String  classTitle, description, totalClasses, totalPresents, absents;
  final List<dynamic> attendanceDocs;
  JoinedClassAttendanceList({
    required this.attendanceDocs,
    required this.classTitle,
    required this.description,
    required this.totalClasses,
    required this.totalPresents,
    required this.absents,
  });

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              classTitle,
              style: GoogleFonts.quicksand(
                fontSize: 18,
                color: kPrimary0,
              ),
            ),
            Text(
              description,
              style: GoogleFonts.quicksand(fontSize: 12, color: Colors.black),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 0.5,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Classes',
                            style: GoogleFonts.quicksand(
                              fontSize: 12,
                            ),
                          ),
                          SelectableText(
                            totalClasses.toString(),
                            style: GoogleFonts.quicksand(
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Presents',
                            style: GoogleFonts.quicksand(
                              fontSize: 12,
                            ),
                          ),
                          SelectableText(
                            totalPresents.toString(),
                            style: GoogleFonts.quicksand(
                                fontSize: 30,
                                color: Colors.green
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Absents',
                            style: GoogleFonts.quicksand(
                              fontSize: 12,

                            ),
                          ),
                          SelectableText(
                            absents.toString(),
                            style: GoogleFonts.quicksand(
                              fontSize: 30,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: attendanceDocs.length,
                itemBuilder: (context,index) {
                  String date = DateFormat.yMMMd().format((attendanceDocs[index]['date'] as Timestamp).toDate()).toString() + ', ' +
                      DateFormat.Hm().format((attendanceDocs[index]['date'] as Timestamp).toDate()).toString();
                  var _currentUser = _firebaseAuth.currentUser?.uid.toString();
                  Color? myColor = (attendanceDocs[index]['att.$_currentUser'] == true) ? Colors.green[100] : Colors.red[200];
                  return Card(
                    color: myColor,
                    child: ListTile(
                      title: Text(
                        date,
                        style: GoogleFonts.quicksand(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
