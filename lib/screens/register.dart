import 'package:flutter/cupertino.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:triage_app/utils/Constants.dart';
import 'login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'doctor_home_screen.dart';
import 'patient_home_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:triage_app/model/user_model.dart';
import 'package:triage_app/widgets/navbar_roots.dart';
import 'package:triage_app/utils/helper.dart';





class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = new RegExp(p);
bool observeText = true;
bool isChecked = false;
bool _isSubmitting = false;

bool _isNameTouched = false;
bool _isEmailAddressTouched = false;
bool _isUserTypeTouched = false;
bool _isPhoneNumberTouched = false;
bool _isPasswordTouched = false;
bool _isConfirmedPasswordTouched = false;

final List<String> userTypeItems = [
  'Patient',
  'Nurse',
  'Doctor',
];

String? selectedValue;

class _SignupState extends State<Signup> {
  bool _success = false;
  String _userEmail = '';
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userTypeController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void validation() {
    final FormState? _form = _formKey.currentState;
    if (_form != null) {
      if (_form.validate()) {
        print("YES");
         signUpWithEmail(_emailController.text, _passwordController.text);



      } else {
        print("NO");
        Fluttertoast.showToast(msg: "Please ensure all the required fills are filled");
        return;
        // _register();
        //  signUpWithEmail(_emailController.text, _passwordController.text);
      }
    } else {
      Fluttertoast.showToast(msg: "Form is not valid");
      return;
      print("Form is not ready.");
    }
  }

  void _register() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      User user = userCredential.user!; // Non-null assertion
      setState(() {
        _success = true;
        _userEmail = user.email ?? ''; // Null-aware assignment
      });
    } catch (e) {
      // Handle any exceptions that may occur during registration.
      setState(() {
        _success = false;
      });
      print('Error during registration: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {},
        ), // appbar leading icon.
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 0.0),
                child: Container(
                  height: screenHeight * 0.4,
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Image.asset(
                          "images/doctors.png",
                        ),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
              Expanded(

                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                8.0, 0.0, 8.0, 20.0),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Full Name:",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please Enter Full Name";
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  onSaved: (value) {
                                    _fullNameController.text = value ?? '';
                                  },
                                  controller: _fullNameController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.person),
                                    hintText: "Full Name",
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  textInputAction: TextInputAction.next,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "E-mail Address:",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please Enter E-mail";
                                    } else if (!regExp.hasMatch(value!)) {
                                      return "E-mail Is Invalid";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.email),
                                    hintText: "E-mail Address",
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  textInputAction: TextInputAction.next,
                                  autofocus: false,
                                  onSaved: (value) {
                                    _emailController.text = value ?? '';
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "User Type:",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                DropdownButtonFormField2<String>(
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person_pin_circle),
                                    // Add Horizontal padding using menuItemStyleData.padding so it matches
                                    // the menu padding when button's width is not specified.
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    // Add more decoration..
                                  ),
                                  hint: const Text(
                                    'Select User Type',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16
                                    ),
                                  ),
                                  items: userTypeItems
                                      .map((item) =>
                                      DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                      .toList(),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please select user type.';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    //Do something when selected item is changed.
                                    _userTypeController.text = value!;
                                  },
                                  onSaved: (value) {
                                    selectedValue = value.toString();
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    padding: EdgeInsets.only(right: 8),
                                  ),
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black45,
                                    ),
                                    iconSize: 24,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Phone Number:",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  validator: (value) {
                                    if (value == "") {
                                      return "Please Enter Phone Number";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  controller: _phoneNumberController,
                                  autofocus: false,
                                  onSaved: (value) {
                                    _phoneNumberController.text = value ?? '';
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.phone),
                                    hintText: "Phone Number",
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  textInputAction: TextInputAction.next,
                                ),
                                SizedBox(
                                  height: 10,
                                ),

                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Password:",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  obscureText: observeText,
                                  controller: _passwordController,
                                  autofocus: false,
                                  onSaved: (value) {
                                    _passwordController.text = value ?? '';
                                  },
                                  validator: (value) {
                                    if (value == "") {
                                      return "Password Is Required";
                                    } else if (value!.length < 8) {
                                      return "Password is Too Short";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.lock),
                                    hintText: "Password",
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          observeText = !observeText;
                                        });
                                      },
                                      child: Icon(
                                        observeText == true
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.black,
                                      ),
                                    ),
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  textInputAction: TextInputAction.next,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Confirm Password:",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  obscureText: observeText,
                                  controller: _confirmPasswordController,
                                  autofocus: false,
                                  onSaved: (value) {
                                    _confirmPasswordController.text =
                                        value ?? '';
                                  },

                                  validator: (value) {
                                    if (value == "") {
                                      return "Confirm Password Is Required";
                                    } else if (value!.length < 8) {
                                      return "Confirm Password is Too Short";
                                    } else if (_confirmPasswordController.text !=
                                        _passwordController.text) {
                                      return "Password don't match";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.lock),
                                    hintText: "Confirm Password",
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          observeText = !observeText;
                                        });
                                      },
                                      child: Icon(
                                        observeText == true
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.black,
                                      ),
                                    ),
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  textInputAction: TextInputAction.done,
                                ),
                                SizedBox(
                                  height: 20,
                                ),

                                Container(
                                  height: 45,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    child: _isSubmitting
                                        ? Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        CircularProgressIndicator(), // Show progress spinner when submitting
                                        SizedBox(width: 10),
                                        Text(
                                          'Registering...',
                                          style: TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold,
                                            color: Color(Constants.COLOR_WHITE),
                                          ),
                                        ),
                                      ],
                                    )
                                        : const Text(
                                      'Register',
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold,
                                        color: Color(Constants.COLOR_WHITE),
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(Constants.COLOR_DARK_GREEN),
                                    ),
                                    onPressed: _isSubmitting ? null : () {
                                      validation();
                                      FocusScope.of(context).unfocus();
                                    },
                                  ),
                                ),

                                // Container(
                                //   height: 45,
                                //   width: double.infinity,
                                //   child: ElevatedButton(
                                //
                                //     child: Text(
                                //       _isSubmitting
                                //           ? const CircularProgressIndicator() // Show progress spinner when submitting
                                //           : const Text('Register'),
                                //       style: TextStyle(
                                //         fontSize: 23,
                                //         fontWeight: FontWeight.bold,
                                //         color: Color(Constants.COLOR_WHITE),
                                //       ),
                                //     ),
                                //     style: ElevatedButton.styleFrom(
                                //       primary: Color(
                                //           Constants.COLOR_DARK_GREEN),
                                //     ),
                                //     onPressed: _isSubmitting ? null : () {
                                //       validation();
                                //       FocusScope.of(context).unfocus();
                                //     },
                                //
                                //     // onPressed: () {
                                //     //   validation();
                                //     //
                                //     // },
                                //   ),
                                // ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already have an account?",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Login(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(
                                              Constants.COLOR_DARK_GREEN),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  void signUpWithEmail(String email, String password) async {
    try {

      setState(() {
        _isSubmitting = true;
      });

      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      // User registration successful
      setState(() {
        _success = true;
        _userEmail = email;
      });


      String userType = _userTypeController.text.toLowerCase();
      postDetailsToFirestore(userType);


      // Reset the form
      _formKey.currentState?.reset();

      setState(() {
        _isSubmitting = false;
        _success = true;
        _userEmail = email;
      });

    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Fluttertoast.showToast(msg: errorMessage!);
      print(error.code);

      setState(() {
        _isSubmitting = false;
      });
    }
  }

  postDetailsToFirestore(String userType) async {
    // calling our firestore
    // calling our user model
    // sending these values


    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.name = _fullNameController.text;
    userModel.userType = _userTypeController.text;
    userModel.phoneNumber = _phoneNumberController.text;

    String userType = _userTypeController.text.toLowerCase();
    String randomNumberWithPrefix = generateRandomNumberWithPrefix(userType);
    userModel.refNumber = randomNumberWithPrefix;


    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());

  //=====Save Data Locally=====
    saveDataLocally("user_name", userModel.name ?? '');
    saveDataLocally("user_type", userModel.userType ?? '');
    saveDataLocally("user_email", userModel.email ?? '');
    saveDataLocally("ref_number", userModel.refNumber ?? '');
    saveDataLocally("user_number", userModel.phoneNumber ?? '');
    saveDataLocally("user_id", user.uid ?? '');

  //   saveDataLocally("user_name", userModel.name);
  //   saveDataLocally("user_type", userModel.userType);
  //   saveDataLocally("user_email", userModel.email);
  //   saveDataLocally("ref_number", userModel.refNumber);
  //   saveDataLocally("user_number", userModel.phoneNumber);
  //   saveDataLocally("user_id", user.uid);



    Fluttertoast.showToast(msg: "Account created successfully :) ");

     //Clear the form
    _formKey.currentState?.reset();

    // Use Navigator.pushReplacement to navigate to the new screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => NavBarRoots(),
      ),
    );



  }





}
