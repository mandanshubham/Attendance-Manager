import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Widgets/MyElevatedButton.dart';
import 'Widgets/MyTextFormField.dart';

Future<void> createClassModalSheet(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      builder: (builder) {
        return CreateClassScreen();
      }
  );
}

class CreateClassScreen extends StatelessWidget {
  const CreateClassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20,),
              Text(
                'Subject name',
                style: GoogleFonts.quicksand(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
              MyTextFormField(),
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
              MyTextFormField(),
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
      ),
    );
  }
}
