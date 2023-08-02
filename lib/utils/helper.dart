import 'dart:math';

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
