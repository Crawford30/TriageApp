import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

String generateRandomNumberWithPrefix(String userType) {
  Random random = Random();
  int randomNumber = 1 + random.nextInt(999); // Random number between 1 and 999

  DateTime now = DateTime.now();
  String currentYear = now.year.toString();

  if (userType == 'doctor') {
    return 'MD-$currentYear-$randomNumber';
  } else if (userType == 'nurse') {
    return 'MN-$currentYear-$randomNumber';
  } else if (userType == 'patient') {
    return 'MP-$currentYear-$randomNumber';
  } else {
    throw ArgumentError('Invalid user type: $userType');
  }
}


//Saved Data
void saveDataLocally(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

//Remove Data
void removeDataLocally(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove(key);
}


Future<String?> getDataLocally(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

String getInitials(String name) {
  List<String> names = name.split(' ');
  if (names.length > 1) {
    return '${names.first[0]}${names.last[0]}'.toUpperCase();
  } else {
    return '${names.first[0]}'.toUpperCase();
  }
}