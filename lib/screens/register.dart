import 'package:flutter/cupertino.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:triage_app/utils/Constants.dart';
import 'login.dart';

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

final List<String> userTypeItems = [
  'Nurse',
  'Doctor',
];

String? selectedValue;

class _SignupState extends State<Signup> {
  void validation() {
    final FormState? _form = _formKey.currentState;
    if (_form!.validate()) {
      print("YES");
    } else {
      print("NO");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
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
                            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 20.0),
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
                                    if (value == "") {
                                      return "Please Enter Full Name";
                                    }
                                    return "";
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.person),
                                    hintText: "Full Name",
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
                                    if (value == "") {
                                      return "Please Enter E-mail";
                                    } else if (!regExp.hasMatch(value!)) {
                                      return "E-mail Is Invalid";
                                    }
                                    return "";
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.email),
                                    hintText: "E-mail Address",
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
                                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
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
                                      .map((item) => DropdownMenuItem<String>(
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
                                    padding: EdgeInsets.symmetric(horizontal: 16),
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
                                    return "";
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.phone),
                                    hintText: "Phone Number",
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                //
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Align(
                                //       alignment: Alignment.centerLeft,
                                //       child: Container(
                                //         width: MediaQuery.of(context).size.width * 0.4,
                                //         child: TextFormField(
                                //           validator: (value) {
                                //             if (value == "") {
                                //               return "Please Enter Zip Code";
                                //             }
                                //             return "";
                                //           },
                                //           decoration: InputDecoration(
                                //             border: OutlineInputBorder(),
                                //             hintText: "Zip Code",
                                //             hintStyle: TextStyle(
                                //               color: Colors.black,
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //     SizedBox(
                                //       width: 10,
                                //     ),
                                //     Align(
                                //       alignment: Alignment.centerRight,
                                //       child: Container(
                                //         width: MediaQuery.of(context).size.width * 0.4,
                                //         child: TextFormField(
                                //           validator: (value) {
                                //             if (value == "") {
                                //               return "Please Enter State";
                                //             }
                                //             return "";
                                //           },
                                //           decoration: InputDecoration(
                                //             border: OutlineInputBorder(),
                                //             hintText: "State",
                                //             hintStyle: TextStyle(
                                //               color: Colors.black,
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
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
                                  validator: (value) {
                                    if (value == "") {
                                      return "Confirm Password Is Required";
                                    } else if (value!.length < 8) {
                                      return "Confirm Password is Too Short";
                                    }
                                    return "";
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
                                ),
                                SizedBox(
                                  height: 20,
                                ),


                                Container(
                                  height: 45,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    child: Text(
                                      "Register",
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold,
                                        color: Color(Constants.COLOR_WHITE),
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(Constants.COLOR_DARK_GREEN),
                                    ),
                                    onPressed: () {
                                      validation();
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
}
