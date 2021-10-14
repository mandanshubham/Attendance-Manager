import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyOutlinedButton extends StatelessWidget {
  final String text;
  MyOutlinedButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: ()  {
        //todo:
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          width: 1,
          color: Color(0xff7e8ce0),
        ),
      ),
      child: Text(text,
        style: GoogleFonts.quicksand(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xff7e8ce0)
        ),
      ),
    );
  }
}