import 'package:att_man/BottomNavScreens/Home/TakeAttendance.dart';
import 'package:att_man/Utils/Constants.dart';
import 'package:att_man/Widgets/MyElevatedButton.dart';
import 'package:att_man/Widgets/ModalSheets/MenuCreatedClasssMS.dart';
import 'package:att_man/Widgets/MyOutlinedButton.dart';
import 'package:att_man/Widgets/MyTextFormField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CreatedClassScreen extends StatelessWidget {
  final String classCode, classTitle, description;
  final DocumentSnapshot snapshot;
  final String totalStudents;

  CreatedClassScreen({
    required this.classCode,
    required this.classTitle,
    required this.description,
    required this.snapshot,
    required this.totalStudents,
  });

  final TextEditingController sendController = TextEditingController();

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
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.menu_rounded,
              color: kPrimary0,
            ),
            onPressed: () {
              menuCreatedClassMS(context, classCode);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 0.5,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total students in the class',
                      style: GoogleFonts.quicksand(
                        fontSize: 12,
                      ),
                    ),
                    SelectableText(
                      totalStudents,
                      style: GoogleFonts.quicksand(
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Row(
                children: [
                  Expanded(
                    child: MyElevatedButton(
                      text: 'Take Attendance',
                      onPressed: () async {
                        if (totalStudents != '0') {
                          Map data = snapshot.data() as Map;
                          DocumentReference ref = snapshot.reference;
                          List students = data['students'];
                          List<String> c = [];
                          students.forEach((element) {
                            c.add(element.toString());
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TakeAttendance(
                                ids: c,
                                classRef: ref,
                              ),
                            ),
                          );
                        } else {
                          final snackBar = SnackBar(
                            content: Text(
                              'No students in the class!',
                              style: GoogleFonts.quicksand(
                                fontSize: 16,
                              ),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: MyOutlinedButton(
                      text: 'Manage Attendance',
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 3, top: 20),
              child: Text(
                'Announcements',
                style: GoogleFonts.quicksand(
                  fontSize: 12,
                ),
              ),
            ),
            Expanded(
              child: Card(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 3, bottom: 10, right: 3),
              child: TextField(
                controller: sendController,
                cursorColor: kPrimary0,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kPrimary0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kPrimary0,
                    ),
                  ),
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.send_rounded,
                      color: kPrimary0,
                    ),
                    onPressed: () {},
                  ),
                ),
                style: GoogleFonts.quicksand(
                    fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
