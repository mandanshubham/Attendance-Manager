import 'package:att_man/Firebase/DatabaseHandler.dart';
import 'package:att_man/Model/student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TakeAttendance extends StatelessWidget {
  const TakeAttendance({Key? key, required this.ids, required this.classRef})
      : super(key: key);

  final List<String> ids;
  final DocumentReference classRef;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Student>>(
          future: DatabaseHandler().getStudents(ids),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Student>? students = snapshot.data;
              List<AttendanceTile> ats = [];
              if (students != null) {
                students.forEach((element) {
                  AttendanceTile at = new AttendanceTile(
                      onChanged: (f) {
                        element.isPresent = f;
                      },
                      student: element);
                  ats.add(at);
                });
                return Scaffold(
                  floatingActionButton: FloatingActionButton.extended(
                      onPressed: () {
                        //TODO take attendance here
                        Map<String, bool> att = {};
                        students.forEach((element) {
                          att[element.enrollNo] = element.isPresent;
                        });
                        classRef
                            .collection("Attendance")
                            .add({'date': DateTime.now(), 'att': att});
                        print(students[1].isPresent);
                      },
                      label: Text('Submit')),
                  body: Padding(
                    padding: EdgeInsets.only(top: 60, left: 10, right: 10),
                    child: ListView.builder(
                        itemCount: ats.length,
                        itemBuilder: (_, index) {
                          return ats[index];
                        }),
                  ),
                );
              } else
                return Center(
                  child: CircularProgressIndicator(),
                );
            } else
              return Center(
                child: CircularProgressIndicator(),
              );
          }),
    );
  }
}

class AttendanceTile extends StatefulWidget {
  final Function(bool) onChanged;
  final Student student;
  bool value;

  AttendanceTile(
      {Key? key,
      required this.onChanged,
      required this.student,
      this.value = false})
      : super(key: key);

  @override
  State<AttendanceTile> createState() => _AttendanceTileState();
}

class _AttendanceTileState extends State<AttendanceTile> {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
        title: Text(widget.student.displayName),
        subtitle: Text(widget.student.enrollNo),
        value: widget.value,
        onChanged: (val) {
          setState(() {
            widget.value = val;
          });
          widget.onChanged(val);
        });
  }
}
