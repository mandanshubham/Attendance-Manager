import 'package:att_man/BottomNavScreens/BottomNavLayout.dart';
import 'package:att_man/Firebase/GoogleAuthentication.dart';
import 'package:att_man/Widgets/MyElevatedButton.dart';
import 'package:att_man/Widgets/MyOutlinedButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Widgets/MyTextFormField.dart';
import 'package:att_man/Firebase/DatabaseHandler.dart';

class PersonalInformation extends StatelessWidget {

  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController enrollmentNumberController = TextEditingController();
  final TextEditingController instituteNameController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Attendance Manger',
            style: GoogleFonts.quicksand(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Color(0xff7e8ce0),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Display name',
                  style: GoogleFonts.quicksand(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey),
                ),
                MyTextFormField(controller: displayNameController,),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Enrollment No.',
                  style: GoogleFonts.quicksand(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey),
                ),
                MyTextFormField(controller: enrollmentNumberController,),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Institute name',
                  style: GoogleFonts.quicksand(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey),
                ),
                MyTextFormField(controller: instituteNameController,),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Contact number',
                  style: GoogleFonts.quicksand(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey),
                ),
                MyTextFormField(controller: contactNumberController,),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: MyElevatedButton(
                        text: 'Continue',
                        onPressed: () async {
                          await DatabaseHandler().addUserToDatabase(
                              displayNameController.text.toUpperCase(),
                              instituteNameController.text.toUpperCase(),
                              enrollmentNumberController.text.toUpperCase(),
                              contactNumberController.text
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BottomNavLayout()),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: MyOutlinedButton(
                        text: 'Sign out',
                        onPressed: () async {
                         await GoogleAuthentication().signOutFromGoogle();
                         Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
