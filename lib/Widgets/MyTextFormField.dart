import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xff7e8ce0)),
        ),
        hoverColor: Colors.black,
        border: UnderlineInputBorder(),
      ),
      style: GoogleFonts.quicksand(
      ),
    );
  }
}