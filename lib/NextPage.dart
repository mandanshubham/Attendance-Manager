import 'package:att_man/BottomNavScreens/BottomNavLayout.dart';
import 'package:att_man/Firebase/DatabaseHandler.dart';
import 'package:att_man/LoginScreens/GoogleLoginScreen.dart';
import 'package:att_man/Utils/Constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NextPage extends StatefulWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {

  void _nextPage() async {
    User? user = FirebaseAuth.instance.currentUser;
    bool registered = await DatabaseHandler().userHasDatabase();
    if(user != null && registered) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BottomNavLayout()),
      );
    }
    else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GoogleLoginScreen()),
      );
    }
  }

  @override
  void initState() {
    _nextPage();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: kPrimary0,
        ),
      ),
    );
  }
}
