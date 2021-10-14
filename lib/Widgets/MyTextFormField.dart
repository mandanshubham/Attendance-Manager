import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff7e8ce0),
          ),
        ),
        hoverColor: Colors.black,
        border: OutlineInputBorder(),
      ),
      style: GoogleFonts.quicksand(
          fontSize: 18, fontWeight: FontWeight.w400),
    );
  }
}
