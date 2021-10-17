import 'package:att_man/BottomNavScreens/BottomNavLayout.dart';
import 'package:att_man/Firebase/DatabaseHandler.dart';
import 'package:att_man/Firebase/GoogleAuthentication.dart';
import 'package:att_man/LoginScreens/PersonalInformation.dart';
import 'package:att_man/Utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hey there,',
              style: GoogleFonts.quicksand(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
            Text(
              'Welcome back',
              style: GoogleFonts.quicksand(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                text: 'Login to your ',
                style: GoogleFonts.quicksand(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                    color: Colors.black),
                children: const <TextSpan>[
                  TextSpan(
                      text: 'account ',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: kPrimary0)),
                  TextSpan(text: 'to continue'),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            OutlinedButton(
              onPressed: () async {
                GoogleAuthentication().signInWithGoogle().then(
                  (user) {
                    DatabaseHandler().userHasDatabase().then(
                          (isRegistered) {
                            if (isRegistered) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => BottomNavLayout()),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PersonalInformation()),
                              );
                            }
                          },
                        );
                  },
                );
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  width: 1,
                  color: kPrimary0,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Image.asset(
                      'assets/g_logo.png',
                      height: 45,
                      width: 45,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Sign in with Google',
                    style: GoogleFonts.quicksand(
                        fontSize: 16,
                        letterSpacing: 2,
                        color: kPrimary0,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
