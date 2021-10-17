import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'MyElevatedButton.dart';
import 'MyTextFormField.dart';

Future<void> createClassModalSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (builder) {
      return CreateClassScreen();
    },
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
    ),
  );
}

class CreateClassScreen extends StatelessWidget {
  final TextEditingController subjectNameController = TextEditingController();
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
            Text(
              'Subject name',
              style: GoogleFonts.quicksand(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
            MyTextFormField(
              controller: subjectNameController,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Description\n(Grade/Year/Semester/Division/Section)',
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
                  onPressed: () {
                    //
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
