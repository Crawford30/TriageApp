import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triage_app/utils/helper.dart';
import 'package:triage_app/utils/Constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:triage_app/model/user_model.dart';
import 'package:triage_app/widgets/navbar_roots.dart';
import 'package:triage_app/utils/helper.dart';
import 'package:triage_app/screens/login.dart';


class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String _userName = '';

  @override
  void initState() {
    super.initState();
    getUserNameFromStorage();
  }


  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Would you like to logout now?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("No, Cancel"),
            ),
            ElevatedButton(
              onPressed: ()  {
                 removeDataLocally("user_email");
                print("User email removed from local storage");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );

                Fluttertoast.showToast(msg: "Logged Out Successfully");
              },
              child: Text("Yes, Proceed"),
            ),
          ],
        );
      },
    );
  }



  void getUserNameFromStorage() async {
    String? userName = await getDataLocally("user_name");
    setState(() {
      _userName = userName ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Settings",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 30),
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("images/doctor1.jpg"),
              ),
              title: Text(
                "${_userName}",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                ),
              ),
              subtitle: Text("Profile"),
            ),
            Divider(height: 50),
            ListTile(
              onTap: () {},
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  CupertinoIcons.person,
                  color: Colors.blue,
                  size: 35,
                ),
              ),
              title: Text(
                "Profile",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
            SizedBox(height: 20),
            ListTile(
              onTap: () {},
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.deepPurple,
                  size: 35,
                ),
              ),
              title: Text(
                "Notifications",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
            SizedBox(height: 20),
            ListTile(
              onTap: () {},
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.privacy_tip_outlined,
                  color: Colors.indigo,
                  size: 35,
                ),
              ),
              title: Text(
                "Privacy",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
            SizedBox(height: 20),
            ListTile(
              onTap: () {},
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.settings_suggest_outlined,
                  color: Colors.green,
                  size: 35,
                ),
              ),
              title: Text(
                "General",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
            SizedBox(height: 20),
            ListTile(
              onTap: () {},
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.info_outline_rounded,
                  color: Colors.orange,
                  size: 35,
                ),
              ),
              title: Text(
                "About Us",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
            Divider(height: 40),
            ListTile(
              onTap: () {
                _showLogoutConfirmationDialog();
              },
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.redAccent.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.info_outline_rounded,
                  color: Colors.redAccent,
                  size: 35,
                ),
              ),
              title: Text(
                "Log Out",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
