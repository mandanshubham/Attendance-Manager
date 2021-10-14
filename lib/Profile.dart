import 'package:att_man/Widgets/MyElevatedButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Widgets/MyOutlinedButton.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                'SHUBHAM MANDAN',
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
                'UI19CO55',
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
                'Indian Institute of Information Technology, Surat',
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
                '+91 9680611788',
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
                      onPressed: () {
                        //Todo:
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
