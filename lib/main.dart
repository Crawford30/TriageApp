import 'package:flutter/material.dart';
import 'package:triage_app/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // Remove 'super.key' as it is not required in this case.
  // Since you're not providing any new parameters, there's no need for the 'const MyApp({super.key})' constructor.
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
