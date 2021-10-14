import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class MyElevatedButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  MyElevatedButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xff7e8ce0)),
        elevation: MaterialStateProperty.resolveWith<double?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed))
                return 5;
              return null;
            }),
      ),
      onPressed: (){
        onPressed();
      },
      child: Text(text,
        style: GoogleFonts.quicksand(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white
        ),
      ),
    );
  }
}