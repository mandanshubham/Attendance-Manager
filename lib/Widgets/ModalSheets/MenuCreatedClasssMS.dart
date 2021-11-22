import 'package:att_man/Firebase/DatabaseHandler.dart';
import 'package:att_man/Utils/Constants.dart';
import 'package:att_man/Widgets/MyElevatedButton.dart';
import 'package:att_man/Widgets/MyTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void menuCreatedClassMS(BuildContext context, String classCode) {
  showModalBottomSheet(
    context: context,
    builder: (builder) {
      return MenuCreatedClassMS(
        classCode: classCode,
      );
    },
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
    ),
  );
}

class MenuCreatedClassMS extends StatelessWidget {
  final String classCode;

  const MenuCreatedClassMS({Key? key, required this.classCode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 40),
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
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              title: Text(
                'Class Code',
                style: GoogleFonts.quicksand(
                  fontSize: 12,
                ),
              ),
              subtitle: SelectableText(
                classCode,
                style: GoogleFonts.quicksand(
                  fontSize: 22,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: kPrimaryLight50,
                    child: IconButton(
                      icon: Icon(
                        Icons.share_rounded,
                        color: kPrimary0,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    backgroundColor: kPrimaryLight50,
                    child: IconButton(
                      icon: Icon(
                        Icons.copy,
                        color: kPrimary0,
                      ),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: classCode));
                      },
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            // ListTile(
            //   onTap: () {},
            //   contentPadding: EdgeInsets.all(0),
            //   leading: Icon(
            //     Icons.people_alt_rounded,
            //     color: kPrimary0,
            //   ),
            //   title: Text(
            //     'Students',
            //     style: GoogleFonts.quicksand(
            //       fontSize: 16,
            //     ),
            //   ),
            // ),
            ListTile(
              onTap: () {},
              contentPadding: EdgeInsets.all(0),
              leading: Icon(
                Icons.download_rounded,
                color: kPrimary0,
              ),
              title: Text(
                'Download Attendance',
                style: GoogleFonts.quicksand(
                  fontSize: 16,
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                await DatabaseHandler().deleteClass(classCode);
                Navigator.pop(context);
              },
              contentPadding: EdgeInsets.all(0),
              leading: Icon(
                Icons.delete_rounded,
                color: Colors.redAccent,
              ),
              title: Text(
                'Delete class',
                style: GoogleFonts.quicksand(
                    fontSize: 16, color: Colors.redAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
