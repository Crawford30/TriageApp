import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triage_app/utils/Constants.dart';
import 'register.dart';
import 'reset_password.dart';
import 'doctor_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:triage_app/widgets/navbar_roots.dart';
import 'package:triage_app/widgets/navbar_roots.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = new RegExp(p);
bool observeText = true;
bool isChecked = false;

class _LoginState extends State<Login> {

  // editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  // firebase
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  void validation() {

      signUserIn(emailController.text, passwordController.text);
      print("YES");
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (ctx) => Dashboard(),
      //   ),
      // );


  }

  @override
  Widget build(BuildContext context) {
    // Get the screen dimensions
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
       // appbar leading icon.
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
                    height: screenHeight * 0.6,
                    child: Column(
                      children: [
                        Container(
                          child: Padding(
                            padding:
                            const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [

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
                                  controller: emailController,
                                  validator: (value) {
                                    if (value == "") {
                                      return "Please Enter E-mail";
                                    } else if (!regExp.hasMatch(value!)) {
                                      return "E-mail Is Invalid";
                                    }
                                    return "";
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  onSaved: (value) {
                                    emailController.text = value!;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "E-mail Address",
                                    prefixIcon: Icon(Icons.email),
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
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
                                  controller: passwordController,
                                  obscureText: observeText,
                                  textInputAction: TextInputAction.done,
                                  onSaved: (value) {
                                    passwordController.text = value!;
                                  },
                                  validator: (value) {
                                    if (value == "") {
                                      return "Password Is Required";
                                    } else if (value!.length < 8) {
                                      return "Password is Too Short";
                                    }
                                    return "";
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Password",
                                    prefixIcon: Icon(Icons.lock),
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
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        // Align(
                                        //   alignment: Alignment.centerLeft,
                                        //   child: Checkbox(
                                        //     value: isChecked,
                                        //     onChanged: (value) {
                                        //       isChecked = !isChecked;
                                        //       setState(() {});
                                        //     },
                                        //   ),
                                        // ),
                                        // Text(
                                        //   "Remember Me",
                                        //   style: TextStyle(color: Colors.black),
                                        // ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (ctx) => ResetPassword(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Forgot Password?",
                                        style: TextStyle(
                                          color: Color(Constants.COLOR_DARK_GREEN),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 45,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold,
                                        color: Color(Constants.COLOR_WHITE),
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        primary: Color(Constants.COLOR_DARK_GREEN) // Set the background color of the button
                                    ),

                                    onPressed: () {
                                      FocusScope.of(context).unfocus();
                                      signUserIn(emailController.text, passwordController.text);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Don't have any account?",
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
                                              builder: (context) => Signup(),
                                            ));
                                      },
                                      child: Text(
                                        "Create Account",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(Constants.COLOR_DARK_GREEN),
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



  // login function
  void signUserIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
          Fluttertoast.showToast(msg: "Login Successful"),
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => NavBarRoots())),
        });
      } on FirebaseAuthException catch (error) {
        String errorMessage = "An undefined Error happened.";

        if (error.code == "invalid-email") {
          errorMessage = "Your email address appears to be malformed.";
        } else if (error.code == "wrong-password") {
          errorMessage = "Your password is wrong.";
        } else if (error.code == "user-not-found") {
          errorMessage = "User with this email doesn't exist.";
        } else if (error.code == "user-disabled") {
          errorMessage = "User with this email has been disabled.";
        } else if (error.code == "too-many-requests") {
          errorMessage = "Too many requests";
        } else if (error.code == "operation-not-allowed") {
          errorMessage = "Signing in with Email and Password is not enabled.";
        }

        Fluttertoast.showToast(msg: errorMessage);
        print("Firebase error code: ${error.code}");
      }
    }
  }

}
