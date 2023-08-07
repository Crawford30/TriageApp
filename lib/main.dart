import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:triage_app/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:triage_app/widgets/navbar_roots.dart';
import 'package:triage_app/utils/helper.dart';

void main() async {
  // Ensure that the Flutter binding is initialized before running the app.
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  // Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}



class MyApp extends StatefulWidget {
  const MyApp();
  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {

  String _userEmail = '';

  @override
  void initState() {
    getUserEmailFromStorage();

    // Timer(Duration(2), () => Get.to)
    super.initState();

  }


  void getUserEmailFromStorage() async {
    String? userEmail = await getDataLocally("user_email");
    setState(() {
      _userEmail = userEmail ?? '';
    });
  }

  // Navigator.of(context).pushReplacement(
  // MaterialPageRoute(builder: (context) => NavBarRoots()),
  // );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  _userEmail == null ? WelcomeScreen() : NavBarRoots(),
    );
  }
}
