import 'package:att_man/BottomNavScreens/ProfileEditScreen.dart';
import 'package:att_man/Firebase/DatabaseHandler.dart';
import 'package:att_man/Firebase/GoogleAuthentication.dart';
import 'package:att_man/LoginScreens/GoogleLoginScreen.dart';
import 'package:att_man/Utils/Constants.dart';
import 'package:att_man/Widgets/MyElevatedButton.dart';
import 'package:att_man/Widgets/MyTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void profileMS(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (builder) {
      return ProfileMS();
    },
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
    ),
  );
}

class ProfileMS extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding:
        const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                height: 5,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(
                    ),
                  ),
                );
              },
              contentPadding: EdgeInsets.all(0),
              leading: Icon(
                Icons.edit_rounded,
                color: kPrimary0,
              ),
              title: Text(
                'Edit Profile',
                style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () async {
                await GoogleAuthentication().signOutFromGoogle();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return GoogleLoginScreen();
                    },
                  ),
                      (_) => false,
                );
              },
              contentPadding: EdgeInsets.all(0),
              leading: Icon(
                Icons.logout,
                color: kPrimary0,
              ),
              title: Text(
                'Logout',
                style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
