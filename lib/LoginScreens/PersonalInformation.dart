import 'package:att_man/Dashboard.dart';
import 'package:att_man/Widgets/MyElevatedButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Widgets/MyTextFormField.dart';

class PersonalInformation extends StatelessWidget {
  const PersonalInformation({Key? key}) : super(key: key);

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
                MyTextFormField(),
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
                MyTextFormField(),
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
                MyTextFormField(),
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
                MyTextFormField(),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: MyElevatedButton(
                    text: 'Sign up',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Dashboard()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
