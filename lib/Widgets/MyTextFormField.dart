import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  MyTextFormField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
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
