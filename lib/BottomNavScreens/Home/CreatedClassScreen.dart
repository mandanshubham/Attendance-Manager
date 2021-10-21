import 'package:att_man/BottomNavScreens/Home/takeAttendance.dart';
import 'package:att_man/Firebase/DatabaseHandler.dart';
import 'package:att_man/Model/student.dart';
import 'package:att_man/Utils/Constants.dart';
import 'package:att_man/Widgets/MyElevatedButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CreatedClassScreen extends StatelessWidget {
  final String classCode, classTitle, description;
  final DocumentSnapshot snapshot;

  CreatedClassScreen(
      {required this.classCode,
      required this.classTitle,
      required this.description,
      required this.snapshot});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
              style: GoogleFonts.quicksand(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 4,
          ),
          Card(
            elevation: 0.5,
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              title: Text(
                'Class Code',
                style: GoogleFonts.quicksand(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              subtitle: SelectableText(
                classCode,
                style: GoogleFonts.quicksand(
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: kPrimaryLight50,
                    child: IconButton(
                      icon: Icon(
                        Icons.share_rounded,
                        color: kPrimary0,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    backgroundColor: kPrimaryLight50,
                    child: IconButton(
                      icon: Icon(
                        Icons.copy,
                        color: kPrimary0,
                      ),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(
                            text:
                                'To join the $classTitle [$description] use this code : ' +
                                    classCode));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 0.5,
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              title: Text(
                'Total students in the class',
                style: GoogleFonts.quicksand(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              subtitle: SelectableText(
                '100',
                style: GoogleFonts.quicksand(
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [],
            ),
          ),
          MyElevatedButton(
            text: 'TakeAttendance',
            onPressed: () async {
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
                          )));
            },
          )
        ],
      ),
    );
  }
}
