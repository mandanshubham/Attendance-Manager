import 'package:att_man/Firebase/DatabaseHandler.dart';
import 'package:att_man/Firebase/GoogleAuthentication.dart';
import 'package:att_man/LoginScreens/GoogleLoginScreen.dart';
import 'package:att_man/Utils/Constants.dart';
import 'package:att_man/Widgets/MyElevatedButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Widgets/MyOutlinedButton.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _displayName,
        _enrollmentNumber,
        _instituteName,
        _contactNumber,
        _emailId;
    return Scaffold(
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: DatabaseHandler().getAllUserData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var profileData = snapshot.data!.docs[0].data();
              _displayName = profileData['displayName'];
              _enrollmentNumber = profileData['enrollmentNumber'];
              _instituteName = profileData['instituteName'];
              _contactNumber = profileData['contactNumber'];
              _emailId = profileData['emailId'];

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PROFILE',
                        style: GoogleFonts.quicksand(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Display Name',
                        style: GoogleFonts.quicksand(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic),
                      ),
                      Text(
                        _displayName,
                        style: GoogleFonts.quicksand(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Email Id',
                        style: GoogleFonts.quicksand(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic),
                      ),
                      Text(
                        _emailId,
                        style: GoogleFonts.quicksand(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Enrollment Number',
                        style: GoogleFonts.quicksand(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic),
                      ),
                      Text(
                        _enrollmentNumber,
                        style: GoogleFonts.quicksand(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Institute Name',
                        style: GoogleFonts.quicksand(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic),
                      ),
                      Text(
                        _instituteName,
                        style: GoogleFonts.quicksand(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Contact Number',
                        style: GoogleFonts.quicksand(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic),
                      ),
                      Text(
                        '+91 $_contactNumber',
                        style: GoogleFonts.quicksand(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: MyElevatedButton(
                              text: 'Edit profile',
                              onPressed: () {
                                //Todo:
                              },
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: MyOutlinedButton(
                              text: 'Logout',
                              onPressed: () async {
                                await GoogleAuthentication()
                                    .signOutFromGoogle();
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return GoogleLoginScreen();
                                    },
                                  ),
                                  (_) => false,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: kPrimary0,
                ),
              );
            }
          }),
    );
  }
}
