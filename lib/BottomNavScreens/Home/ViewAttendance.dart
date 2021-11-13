import 'package:att_man/Firebase/DatabaseHandler.dart';
import 'package:att_man/Model/student.dart';
import 'package:att_man/Utils/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ViewAttendance extends StatelessWidget {

  final Map<String, dynamic> attendanceMap;
  final String date;
  final List<String> ids;

  ViewAttendance({
    required this.attendanceMap,
    required this.date,
    required this.ids
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        automaticallyImplyLeading: false,
        title: Text(
          date,
          style: GoogleFonts.quicksand(
            fontSize: 18,
            color: kPrimary0,
          ),
        ),
      ),
      body: FutureBuilder<List<Student>>(
          future: DatabaseHandler().getStudents(ids),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Student>? students = snapshot.data;
              List<AttendanceTile> ats = [];
              if (students != null) {
                students.forEach((element) {
                  AttendanceTile at = new AttendanceTile(
                    isPresent: attendanceMap[element.uid],
                      student: element);
                  ats.add(at);
                });
                return Padding(
                  padding: EdgeInsets.only(top: 40, left: 10, right: 10),
                  child: ListView.builder(
                      itemCount: ats.length,
                      itemBuilder: (_, index) {
                        return ats[index];
                      }),
                );
              }
              else
                return Center(
                    child: CircularProgressIndicator()
                );
            } else
              return Center(
                child: CircularProgressIndicator(),
              );
          }),
    );
  }
}

class AttendanceTile extends StatelessWidget {
  final bool isPresent;
  final Student student;
  AttendanceTile({
   required this.student,
    required this.isPresent
});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          student.enrollNo,
          style: GoogleFonts.quicksand(
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          student.displayName,
          style: GoogleFonts.quicksand(
            fontSize: 14,
          ),
        ),
        trailing: Text(
          isPresent ? 'P' : 'A',
          style: GoogleFonts.quicksand(
            fontSize: 30,
            color: isPresent ? Colors.green : Colors.red,
            fontWeight: FontWeight.w700
          ),
        ),
      ),
    );
  }
}
