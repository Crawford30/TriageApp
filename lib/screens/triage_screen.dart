import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TriageScreen extends StatefulWidget {
  @override
  _TriageScreenState createState() => _TriageScreenState();
}

class _TriageScreenState extends State<TriageScreen> {
  String selectedLabel = "";
  String selectedLabelNationality = "";
  bool isChecked = false;

  List<String> imgs = [
    "doctor1.jpg",
    "doctor2.jpg",
    "doctor3.jpg",
    "doctor4.jpg",
  ];

  Widget buildCheckboxWithLabel(String label, Color color) {
    return Row(
      children: [
        Checkbox(
          value: selectedLabel == label,
          activeColor: color,
          onChanged: (value) {
            setState(() {
              if (selectedLabel == label) {
                selectedLabel = ""; // Uncheck if already selected
              } else {
                selectedLabel = label; // Check the selected label
              }
            });
          },
        ),
        Text(label),
      ],
    );
  }

  Widget buildNationalityCheckboxWithLabel(String label) {
    return Row(
      children: [
        Checkbox(
          value: selectedLabelNationality == label,
          activeColor: Colors.blue,
          onChanged: (value) {
            setState(() {
              if (selectedLabelNationality == label) {
                selectedLabelNationality = ""; // Uncheck if already selected
              } else {
                selectedLabelNationality = label; // Check the selected label
              }
            });
          },
        ),
        Text(label),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF7165D6),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      Icon(
                        Icons.more_vert,
                        color: Colors.white,
                        size: 28,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: AssetImage("images/doctor1.jpg"),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Patient Name",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Patient #: 0900000",
                            style: TextStyle(
                              color: Colors.white60,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: MediaQuery.of(context).size.height / 0.4,
              width: double.infinity,
              padding: EdgeInsets.only(
                top: 20,
                left: 15,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "TRIAGE LEVEL/CATEGORY:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        buildCheckboxWithLabel("RED", Colors.red),
                        buildCheckboxWithLabel("YELLOW", Colors.yellow),
                        buildCheckboxWithLabel("ORANGE", Colors.orange),
                        buildCheckboxWithLabel("GREEN", Colors.green),
                        buildCheckboxWithLabel("BLUE", Colors.blue),
                      ],
                    ),
                  ),
                  SizedBox(height: 10), // Add space above the divider

                  Align(
                    alignment: Alignment.center,
                    child: Divider(
                      color: Colors.grey, // Color of the divider
                      thickness: 1.0, // Thickness of the divider
                      indent: 16.0, // Indent on the left side
                      endIndent: 16.0, // Indent on the right side
                    ),
                  ),
                  SizedBox(height: 10),

                  Text(
                    "PATIENT'S DEMOGRAPHICS",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Nationality: ",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          buildNationalityCheckboxWithLabel("NATIONAL"),
                          buildNationalityCheckboxWithLabel("REFUGEE"),
                          buildNationalityCheckboxWithLabel("FOREIGNER"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10), // Add space above the divider

                  Align(
                    alignment: Alignment.center,
                    child: Divider(
                      color: Colors.grey, // Color of the divider
                      thickness: 1.0, // Thickness of the divider
                      indent: 16.0, // Indent on the left side
                      endIndent: 16.0, // Indent on the right side
                    ),
                  ),
                  SizedBox(height: 15),

                  Text(
                    "Address: ",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.42,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Village/Zone:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter Village/Zone";
                                }
                                return null;
                              },
                              autofocus: false,
                              onSaved: (value) {
                                // Handle saved value
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person),
                                hintText: "Village/Zone",
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Parish:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter Parish";
                                }
                                return null;
                              },
                              autofocus: false,
                              onSaved: (value) {
                                // Handle saved value
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person),
                                hintText: "Parish",
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Sub-county:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter Sub-county";
                                }
                                return null;
                              },
                              autofocus: false,
                              onSaved: (value) {
                                // Handle saved value
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person),
                                hintText: "Sub-county",
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "District:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter District";
                                }
                                return null;
                              },
                              autofocus: false,
                              onSaved: (value) {
                                // Handle saved value
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person),
                                hintText: "District",
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.next,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10), // Add space above the divider

                  Align(
                    alignment: Alignment.center,
                    child: Divider(
                      color: Colors.grey, // Color of the divider
                      thickness: 1.0, // Thickness of the divider
                      indent: 16.0, // Indent on the left side
                      endIndent: 16.0, // Indent on the right side
                    ),
                  ),
                  SizedBox(height: 15),

                  Text(
                    "Bio-data: ",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.34,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Marital Status:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Marital Status";
                                }
                                return null;
                              },
                              autofocus: false,
                              onSaved: (value) {
                                // Handle saved value
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person),
                                hintText: "Marital Status",
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "NIN:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "NIN";
                                }
                                return null;
                              },
                              autofocus: false,
                              onSaved: (value) {
                                // Handle saved
                                // value
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person),
                                hintText: "NIN",
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "LC1 Chairperson/VHT Contact Person:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter LC1 Chairperson/VHT Contact Person";
                                }
                                return null;
                              },
                              autofocus: false,
                              onSaved: (value) {
                                // Handle saved value
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person),
                                hintText: "LC1 Chairperson/VHT Contact Person",
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: Divider(
                      color: Colors.grey, // Color of the divider
                      thickness: 1.0, // Thickness of the divider
                      indent: 16.0, // Indent on the left side
                      endIndent: 16.0, // Indent on the right side
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Relationship: ",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.34,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Next Of Kin:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Next Of Kin";
                                }
                                return null;
                              },
                              autofocus: false,
                              onSaved: (value) {
                                // Handle saved value
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person),
                                hintText: "Next Of Kin",
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Relationship:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Relationship";
                                }
                                return null;
                              },
                              autofocus: false,
                              onSaved: (value) {
                                // Handle saved value
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person),
                                hintText: "Relationship",
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Contact:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Contact";
                                }
                                return null;
                              },
                              autofocus: false,
                              onSaved: (value) {
                                // Handle saved value
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person),
                                hintText: "Contact",
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: 10),

                            // Add space above the divider
                          ],
                        ),
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: Divider(
                      color: Colors.grey, // Color of the divider
                      thickness: 1.0, // Thickness of the divider
                      indent: 16.0, // Indent on the left side
                      endIndent: 16.0, // Indent on the right side
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Referral: ",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Referral IN:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              height: 40,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    8.0, 0.0, 8.0, 0.0),
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    buildNationalityCheckboxWithLabel("YES"),
                                    buildNationalityCheckboxWithLabel("NO"),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Referring Health Facility:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Referring Health Facility";
                                }
                                return null;
                              },
                              autofocus: false,
                              onSaved: (value) {
                                // Handle saved value
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person),
                                hintText: "Referring Health Facility",
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: Divider(
                      color: Colors.grey, // Color of the divider
                      thickness: 1.0, // Thickness of the divider
                      indent: 16.0, // Indent on the left side
                      endIndent: 16.0, // Indent on the right side
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "A). Referral Diagnosis: ",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Referral IN:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              height: 40,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    8.0, 0.0, 8.0, 0.0),
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    buildNationalityCheckboxWithLabel("YES"),
                                    buildNationalityCheckboxWithLabel("NO"),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Referring Health Facility:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Referring Health Facility";
                                }
                                return null;
                              },
                              autofocus: false,
                              onSaved: (value) {
                                // Handle saved value
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person),
                                hintText: "Referring Health Facility",
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: Divider(
                      color: Colors.grey, // Color of the divider
                      thickness: 1.0, // Thickness of the divider
                      indent: 16.0, // Indent on the left side
                      endIndent: 16.0, // Indent on the right side
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "B). Principle Reason for Referral: ",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Referral IN:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              height: 40,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    8.0, 0.0, 8.0, 0.0),
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    buildNationalityCheckboxWithLabel("YES"),
                                    buildNationalityCheckboxWithLabel("NO"),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Referring Health Facility:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Referring Health Facility";
                                }
                                return null;
                              },
                              autofocus: false,
                              onSaved: (value) {
                                // Handle saved value
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person),
                                hintText: "Referring Health Facility",
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(15),
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(height: 15),
            InkWell(
              onTap: () {},
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: Color(0xFF7165D6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Submit Triage Form",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
