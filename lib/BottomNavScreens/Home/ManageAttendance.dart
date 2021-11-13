import 'package:att_man/BottomNavScreens/Home/ViewAttendance.dart';
import 'package:att_man/Utils/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ManageAttendance extends StatelessWidget {

  final DocumentReference  docRef;
  ManageAttendance({
   required this.docRef,
  });

  Future<QuerySnapshot<Map<String, dynamic>>> getData() async {
    return docRef.collection('Attendance').orderBy('date',descending: true).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        automaticallyImplyLeading: false,
        title: Text(
          'Attendance List',
          style: GoogleFonts.quicksand(
            fontSize: 18,
            color: kPrimary0,
          ),
        ),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            var _data = snapshot.data as QuerySnapshot<Map<String, dynamic>>;
            var myDocs = _data.docs;
            return ListView.builder(
              itemCount: myDocs.length,
              itemBuilder: (context,index) {
                String date = DateFormat.yMMMd().format((myDocs[index]['date'] as Timestamp).toDate()).toString() + ', ' +
                    DateFormat.Hm().format((myDocs[index]['date'] as Timestamp).toDate()).toString();
                String day = DateFormat.E().format((myDocs[index]['date'] as Timestamp).toDate()).toString();
                var presents = 0;
                var absents = 0;
                Map<String, dynamic> attendanceMap = myDocs[index]['att'];
                List<String> ids = [];
                attendanceMap.entries.forEach((element) {
                  ids.add(element.key);
                  if(element.value==true)
                    presents++;
                  else
                    absents++;
                });
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewAttendance(
                           date: date,
                            ids: ids,
                            attendanceMap: attendanceMap,
                          ),
                        ),
                      );
                    },
                    title: Text(
                      date,
                      style: GoogleFonts.quicksand(
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      day,
                      style: GoogleFonts.quicksand(
                        fontSize: 14,
                      ),
                    ),
                    trailing: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Presents |',
                              style: GoogleFonts.quicksand(
                                fontSize: 12,
                              ),
                            ),
                            SelectableText(
                              presents.toString(),
                              style: GoogleFonts.quicksand(
                                  fontSize: 30,
                                  color: Colors.green
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              ' Absents',
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
                );
              },
            );
          }
          else return Center(child: CircularProgressIndicator(color: kPrimary0,),);
        },
      ),
    );
  }
}
