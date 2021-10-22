import 'package:att_man/Firebase/DatabaseHandler.dart';
import 'package:att_man/Firebase/GoogleAuthentication.dart';
import 'package:att_man/LoginScreens/GoogleLoginScreen.dart';
import 'package:att_man/Utils/Constants.dart';
import 'package:att_man/Widgets/ModalSheets/ProfileMS.dart';
import 'package:att_man/Widgets/MyElevatedButton.dart';
import 'package:att_man/Widgets/ModalSheets/MenuCreatedClasssMS.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        automaticallyImplyLeading: false,
        title: Text(
          'PROFILE',
          style: GoogleFonts.quicksand(
            fontSize: 18,
            color: kPrimary0,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.menu_rounded,
              color: kPrimary0,
            ),
            onPressed: () {
              profileMS(context);
            },
          )
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
          future: DatabaseHandler().getAllUserData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var profileData = snapshot.data!.data() as Map<String, dynamic>;
              _displayName = profileData['displayName'];
              _enrollmentNumber = profileData['enrollmentNumber'];
              _instituteName = profileData['instituteName'];
              _contactNumber = profileData['contactNumber'];
              _emailId = profileData['emailId'];

              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
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
                  ],
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
