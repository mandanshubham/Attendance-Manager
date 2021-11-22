import 'package:att_man/Firebase/DatabaseHandler.dart';
import 'package:att_man/Utils/Constants.dart';
import 'package:att_man/Widgets/MyElevatedButton.dart';
import 'package:att_man/Widgets/MyTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void joinClassBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (builder) {
      return JoinClassBottomSheet();
    },
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0)),
    ),
  );
}

class JoinClassBottomSheet extends StatelessWidget {
  final TextEditingController joinClassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: const EdgeInsets.only(top: 20,left: 10,right: 10,bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                height: 5,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Enter code to join the class',
              style: GoogleFonts.quicksand(
                  fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 4,
                  child: MyTextFormField(controller: joinClassController,)
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: MyElevatedButton(
                    text: 'Join',
                    onPressed: () async {
                      Navigator.pop(context);
                      await DatabaseHandler().joinClass(joinClassController.text.trim());
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
