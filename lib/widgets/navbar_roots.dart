import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triage_app/screens/doctor_home_screen.dart';
import 'package:triage_app/screens/patient_home_screen.dart';
import 'package:triage_app/screens/messages_screen.dart';
import 'package:triage_app/screens/schedule_screen.dart';
import 'package:triage_app/screens/settings_screen.dart';
import 'package:triage_app/utils/helper.dart';
import 'package:triage_app/screens/welcome_screen.dart';

class NavBarRoots extends StatefulWidget {
  @override
  State<NavBarRoots> createState() => _NavBarRootsState();
}

class _NavBarRootsState extends State<NavBarRoots> {
  int _selectedIndex = 0;
  List<Widget> _screens = [];
  String _userType = '';

  @override
  void initState() {
    super.initState();
    getUserTypeFromStorage();
  }

  void getUserTypeFromStorage() async {
    String? userType = await getDataLocally("user_type");
    setState(() {
      _userType = userType ?? '';
      _screens = _getScreensForUserType(userType);
    });
  }

  List<Widget> _getScreensForUserType(String? userType) {
    return [
      userType != null && userType == 'Patient'  ? PatientHomeScreen() : DoctorHomeScreen(),
      MessagesScreen(),
      ScheduleScreen(),
      SettingScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // Show loading or any other UI while waiting for user_type from storage
    if (_userType.isEmpty) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        height: 80,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xFF7165D6),
          unselectedItemColor: Colors.black26,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble_text_fill),
              label: "Messages",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined),
              label: "Schedule",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
