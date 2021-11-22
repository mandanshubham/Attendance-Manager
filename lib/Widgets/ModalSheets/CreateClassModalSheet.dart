import 'package:att_man/Firebase/DatabaseHandler.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../MyElevatedButton.dart';
import '../MyTextFormField.dart';

Future<void> createClassModalSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (builder)  {
      return  CreateClassScreen();
    },
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
    ),
  );
}

class CreateClassScreen extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

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
              'Title / Subject Name',
              style: GoogleFonts.quicksand(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
            MyTextFormField(
              controller: titleController,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Description',
              style: GoogleFonts.quicksand(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
            MyTextFormField(
              controller: descriptionController,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyElevatedButton(
                  text: 'Create class',
                  onPressed: () async {
                    Navigator.pop(context);
                    var snapshot = await DatabaseHandler().getAllUserData();
                    var profileData = snapshot.data() as Map<String, dynamic>;
                    String displayName = profileData['displayName'];
                    String emailId = profileData['emailId'];
                    await DatabaseHandler().createClass(titleController.text, descriptionController.text,displayName,emailId);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
