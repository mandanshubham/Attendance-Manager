import 'package:att_man/BottomNavScreens/Home/JoinedClassAttendanceList.dart';
import 'package:att_man/Firebase/DatabaseHandler.dart';
import 'package:att_man/Utils/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';

class JoinedClassScreen extends StatelessWidget {
  final String classCode, classTitle, description;
  final DocumentSnapshot snapshot;

  JoinedClassScreen({
    required this.classCode,
    required this.classTitle,
    required this.description,
    required this.snapshot,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: DatabaseHandler().getJoinedClassData(classCode),
              builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    var _currentUser = _firebaseAuth.currentUser?.uid.toString();
                    var _data = snapshot.data as QuerySnapshot<Map<String, dynamic>>;
                    var totalClasses = _data.docs.length;
                    var totalPresents = 0;
                    List val = _data.docs;
                    val.forEach((element) {
                      if(element['att.$_currentUser']==true) totalPresents++;
                    });
                    var absents = totalClasses - totalPresents;
                    return Column(
                      children: [
                        Card(
                          elevation: 0.5,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(5),
                            onTap: () {
                              //Todo: show student attendance to him;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => JoinedClassAttendanceList(
                                    attendanceDocs: val,
                                    classTitle: classTitle,
                                    description: description,
                                    totalClasses: totalClasses.toString(),
                                    totalPresents: totalPresents.toString(),
                                    absents: absents.toString(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Attendance Chart          ',
                                    style: GoogleFonts.quicksand(
                                      fontSize: 16,
                                    ),
                                  ),
                                  Container(
                                    height : 120,
                                    child: PieChart(dataMap: {
                                      'Presents' : totalPresents.toDouble()/totalClasses*100,
                                      'Absents' : absents.toDouble()/totalClasses*100
                                    },
                                      animationDuration: Duration(milliseconds: 800),
                                      chartLegendSpacing: 32,
                                      chartRadius: 50,
                                      colorList: [Colors.green, Colors.redAccent],
                                      initialAngleInDegree: 0,
                                      chartType: ChartType.ring,
                                      ringStrokeWidth: 40,
                                      legendOptions: LegendOptions(
                                        showLegends: false,
                                      ),
                                      chartValuesOptions: ChartValuesOptions(
                                        showChartValueBackground: true,
                                        showChartValues: true,
                                        showChartValuesInPercentage: false,
                                        showChartValuesOutside: false,
                                        decimalPlaces: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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
                      ],
                    );
                  }
                  return Container(height: 180,child: Center(child: CircularProgressIndicator(color: kPrimary0,strokeWidth: 2,),),);
              },
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
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: StreamBuilder(
                  stream: DatabaseHandler().streamMessages(classCode),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.toString());
                      return ListView(
                        reverse: true,
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                          return Card(
                            elevation: 0.5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SelectableText(
                                    data['message'],
                                    style: GoogleFonts.quicksand(
                                        fontSize: 18),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        DateFormat.yMMMd().format((data['timestamp'] as Timestamp).toDate()).toString() + ', '
                                            + DateFormat.Hm().format((data['timestamp'] as Timestamp).toDate()).toString() ,
                                        style: GoogleFonts.quicksand(
                                            fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    } else
                      return Center(
                        child: Text(
                          'No Message',
                          style: GoogleFonts.quicksand(
                              fontSize: 18),
                        ),
                      );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
