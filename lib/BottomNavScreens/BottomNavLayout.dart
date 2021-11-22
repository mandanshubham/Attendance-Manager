import 'package:att_man/BottomNavScreens/Home/Home.dart';
import 'package:att_man/BottomNavScreens/Notification.dart';
import 'package:att_man/BottomNavScreens/Profile.dart';
import 'package:att_man/Utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';


class BottomNavLayout extends StatefulWidget {
  const BottomNavLayout({Key? key}) : super(key: key);

  @override
  _BottomNavLayoutState createState() => _BottomNavLayoutState();
}

class _BottomNavLayoutState extends State<BottomNavLayout> {
  int _currentIndex = 0;
  List<Widget> _bottomNavScreens=[];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    _bottomNavScreens = [
    Home(),
    //Notifications(),
    Profile(),
    ];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
       bottomNavigationBar: BottomNavigationBar(
         items: const <BottomNavigationBarItem>[
           BottomNavigationBarItem(
             icon: Icon(Icons.home_rounded),
             label: 'Home',
           ),
           // BottomNavigationBarItem(
           //   icon: Icon(Icons.email_rounded),
           //   label: 'Notifications',
           // ),
           BottomNavigationBarItem(
             icon: Icon(Icons.account_box_rounded),
             label: 'Profile',
           ),
         ],
         currentIndex: _currentIndex,
         selectedItemColor: kPrimary0,
         onTap: _onItemTapped,
         selectedLabelStyle: GoogleFonts.quicksand(fontWeight: FontWeight.w500),
         unselectedLabelStyle: GoogleFonts.quicksand(),
       ),
        body: _bottomNavScreens.elementAt(_currentIndex),
      ),
    );
  }
}
