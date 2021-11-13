import 'package:att_man/BottomNavScreens/Home/CreatedClassScreen.dart';
import 'package:att_man/BottomNavScreens/Home/JoinedClassScreen.dart';
import 'package:att_man/Firebase/DatabaseHandler.dart';
import 'package:att_man/Utils/Constants.dart';
import 'package:att_man/Widgets/ModalSheets/CreateClassModalSheet.dart';
import 'package:att_man/Widgets/ModalSheets/JoinClassBottomSheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Widgets/MyElevatedButton.dart';
import '../../Widgets/MyOutlinedButton.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: MyElevatedButton(
                    text: 'Join a class',
                    onPressed: () {
                      //Todo:
                      joinClassBottomSheet(context);
                    },
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: MyOutlinedButton(
                    text: 'Create class',
                    onPressed: () {
                      createClassModalSheet(context);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              ' JOINED CLASSES',
              style: GoogleFonts.quicksand(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: DatabaseHandler().streamJoinedClasses(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.toString());
                  return Flexible(
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      shrinkWrap: true,
                      children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                        return Card(
                          elevation: 0.5,
                          child: ListTile(
                            onTap: () {
                              //Todo: Navigate to joinedClassScreen()
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => JoinedClassScreen(
                                    snapshot: document,
                                    classCode: data['classCode'].toString(),
                                    classTitle: data['title'],
                                    description: data['description'],
                                  ),
                                ),
                              );
                            },
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 10),
                            leading: CircleAvatar(
                              backgroundColor: kPrimaryLight50,
                              child: Icon(
                                Icons.account_tree_rounded,
                                color: kPrimary0,
                                size: 25,
                              ),
                            ),
                            title: Text(
                              data['title'],
                              style: GoogleFonts.quicksand(
                                  fontSize: 18),
                            ),
                            subtitle: Text(
                              data['description'],
                              style: GoogleFonts.quicksand(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                } else
                  return Text(
                    'You have not created any class yet',
                    style: GoogleFonts.quicksand(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  );
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              ' CREATED CLASSES',
              style: GoogleFonts.quicksand(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
            StreamBuilder(
              stream: DatabaseHandler().streamCreateClasses(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.toString());
                  return Flexible(
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return Card(
                          elevation: 0.5,
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreatedClassScreen(
                                    snapshot: document,
                                    classCode: data['classCode'].toString(),
                                    classTitle: data['title'],
                                    description: data['description'],
                                    totalStudents: data['students'].length.toString(),
                                    displayName: data['displayName'],
                                    emailId: data['emailId'],
                                  ),
                                ),
                              );
                            },
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            leading: CircleAvatar(
                              backgroundColor: kPrimaryLight50,
                              child: Icon(
                                Icons.account_tree_rounded,
                                color: kPrimary0,
                                size: 25,
                              ),
                            ),
                            title: Text(
                              data['title'],
                              style: GoogleFonts.quicksand(
                                  fontSize: 18),
                            ),
                            subtitle: Text(
                              data['description'],
                              style: GoogleFonts.quicksand(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                } else
                  return Text(
                    'You have not created any class yet',
                    style: GoogleFonts.quicksand(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  );
              },
            ),
          ],
        ),
      ),
    );
  }
}
