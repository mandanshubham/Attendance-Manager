import 'package:att_man/Utils/Constants.dart';
import 'package:att_man/Widgets/MyElevatedButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void joinClassBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (builder) {
      return JoinClass();
    },
  );
}

class JoinClass extends StatelessWidget {
  const JoinClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.only(left: 20, right: 20, bottom: 140, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Enter code to join the class',
            style: GoogleFonts.quicksand(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 4,
                child: TextFormField(
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
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: MyElevatedButton(
                  text: 'Join',
                  onPressed: () {},
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}