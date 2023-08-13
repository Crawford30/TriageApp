import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:triage_app/model/triage_form_nurse_model.dart';
import 'package:triage_app/model/user_model.dart';
import 'package:intl/intl.dart';

class TriageDoctorScreen extends StatefulWidget {
  final String? patientId;
  final String? patientNumber;


  TriageDoctorScreen({this.patientId, this.patientNumber});

  @override
  _TriageDoctorScreenState createState() => _TriageDoctorScreenState();
}

class _TriageDoctorScreenState extends State<TriageDoctorScreen> {

  TextEditingController? _villageZoneController;
  TextEditingController? _parishController;
  TextEditingController? _subCountyController;
  TextEditingController? _districtController;
  TextEditingController? _maritalStatusController;
  TextEditingController? _nationalIDController;
  TextEditingController? _localChairPersonController;
  TextEditingController? _nOKNameController;
  TextEditingController? _nOKRelationshipController;
  TextEditingController? _nOKContactController;
  TextEditingController? _referringHealthFacilityController;
  TextEditingController? _referralDiagnosisNoteController;
  TextEditingController? _referralReasonController;
  TextEditingController? _seniorConsultantNameController;
  TextEditingController? _consultantNameController;
  TextEditingController? _medicalOfficerNameController;
  TextEditingController? _caseSummaryController;







  final TextEditingController _userTypeController = TextEditingController();






  Map<String, dynamic>? nurseTriageData;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    fetchData();


  }

  final List<String> userTypeItems = [
    'Alert',
    'Verbal',
    'Pain',
    'Unresponsive',
    'Irritable'
  ];



  bool isChecked = false;
  String? selectedValue;




  String selectedTriageCategoryLabel = "";
  String selectedLabelNationality = "";
  String selectedLabel = "";


  String selectedReferralInLabel = "";
  String selectedInformedSeniorConsultantLabel = "";
  String selectedInformedConsultantLabel = "";
  String selectedInformedMedicalOfficerLabel = "";

  List<String> imgs = [
    "doctor1.jpg",
    "doctor2.jpg",
    "doctor3.jpg",
    "doctor4.jpg",
  ];



  String formatDateTime(String? inputDateTime) {
    if (inputDateTime == null) {
      return 'N/A';
    }
    DateTime parsedDateTime = DateTime.parse(inputDateTime);
    String formattedDate = DateFormat('dd-MMM-yyyy').format(parsedDateTime);
    String formattedTime = DateFormat('hh:mma').format(parsedDateTime).toLowerCase();
    String formattedDateTime = '$formattedDate at $formattedTime';
    return formattedDateTime;
  }

  Widget buildCheckboxWithLabel(String label, Color color) {
    return Row(
      children: [
        Checkbox(
          value: selectedTriageCategoryLabel == label,
          activeColor: color,
          onChanged: (value) {
            // setState(() {
            //   if (selectedTriageCategoryLabel == label) {
            //     selectedTriageCategoryLabel = ""; // Uncheck if already selected
            //   } else {
            //     selectedTriageCategoryLabel = label; // Check the selected label
            //   }
            // });
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
            // setState(() {
            //   if (selectedLabelNationality == label) {
            //     selectedLabelNationality = ""; // Uncheck if already selected
            //   } else {
            //     selectedLabelNationality = label; // Check the selected label
            //   }
            // });
          },
        ),
        Text(label),
      ],
    );
  }

  Widget buildReferralInCheckboxWithLabel(String label) {
    return Row(
      children: [
        Checkbox(
          value: selectedReferralInLabel == label,
          activeColor: Colors.blue,
          onChanged: (value) {
            // setState(() {
            //   if (selectedReferralInLabel == label) {
            //     selectedReferralInLabel = ""; // Uncheck if already selected
            //   } else {
            //     selectedReferralInLabel = label; // Check the selected label
            //   }
            // });
          },
        ),
        Text(label),
      ],
    );
  }

  Widget buildInformedSeniorConsultantCheckboxWithLabel(String label) {
    return Row(
      children: [
        Checkbox(
          value: selectedInformedSeniorConsultantLabel == label,
          activeColor: Colors.blue,
          onChanged: (value) {
            setState(() {
              if (selectedInformedSeniorConsultantLabel == label) {
                selectedInformedSeniorConsultantLabel =
                ""; // Uncheck if already selected
              } else {
                selectedInformedSeniorConsultantLabel =
                    label; // Check the selected label
              }
            });
          },
        ),
        Text(label),
      ],
    );
  }

  Widget buildInformedConsultantCheckboxWithLabel(String label) {
    return Row(
      children: [
        Checkbox(
          value: selectedInformedConsultantLabel == label,
          activeColor: Colors.blue,
          onChanged: (value) {
            setState(() {
              if (selectedInformedConsultantLabel == label) {
                selectedInformedConsultantLabel =
                ""; // Uncheck if already selected
              } else {
                selectedInformedConsultantLabel =
                    label; // Check the selected label
              }
            });
          },
        ),
        Text(label),
      ],
    );
  }

  Widget buildInformedMedicalOfficerCheckboxWithLabel(String label) {
    return Row(
      children: [
        Checkbox(
          value: selectedInformedMedicalOfficerLabel == label,
          activeColor: Colors.blue,
          onChanged: (value) {
            setState(() {
              if (selectedInformedMedicalOfficerLabel == label) {
                selectedInformedMedicalOfficerLabel =
                ""; // Uncheck if already selected
              } else {
                selectedInformedMedicalOfficerLabel =
                    label; // Check the selected label
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
              height: MediaQuery.of(context).size.height / 0.09,
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
                              controller: _villageZoneController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter Village/Zone";
                                }
                                return null;
                              },
                              autofocus: false,
                              enabled: false,
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
                              controller: _parishController,
                              enabled: false,
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
                              controller: _subCountyController,
                              enabled: false,
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
                              controller: _districtController,
                              enabled: false,
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
                              controller: _maritalStatusController,
                              enabled: false,
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
                              controller: _nationalIDController,
                              enabled: false,
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
                              controller: _localChairPersonController,
                              enabled: false,
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
                              controller: _nOKNameController,
                              enabled: false,
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
                              controller: _nOKRelationshipController,
                              enabled: false,
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
                              controller: _nOKContactController,
                              enabled: false,
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
                                    buildReferralInCheckboxWithLabel("YES"),
                                    buildReferralInCheckboxWithLabel("NO"),
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
                              autofocus: false,
                              onSaved: (value) {
                                // Handle saved value
                              },
                              controller: _referringHealthFacilityController,
                              enabled: false,
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
                    height: MediaQuery.of(context).size.height * 0.21,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Referral Diagnosis Note:",
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
                                  return "Referral Diagnosis Note";
                                }
                                return null;
                              },
                              controller: _referralDiagnosisNoteController,
                              enabled: false,
                              autofocus: false,
                              onSaved: (value) {
                                // Handle saved value
                              },
                              minLines: 3,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              maxLength: 600,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Referral Diagnosis Note",
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 15,
                                  // Adjust the vertical padding as needed
                                  horizontal:
                                      10, // Adjust the horizontal padding as needed
                                ),
                              ),
                              textAlignVertical: TextAlignVertical.center,
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
                    height: MediaQuery.of(context).size.height * 0.28,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Principle Reason for Referral:",
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
                                  return "Principle Reason for Referral Note";
                                }
                                return null;
                              },
                              controller: _referralReasonController,
                              enabled: false,
                              autofocus: false,
                              onSaved: (value) {
                                // Handle saved value
                              },
                              minLines: 3,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              maxLength: 600,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Principle Reason for Referral Note",
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 15,
                                  // Adjust the vertical padding as needed
                                  horizontal:
                                      10, // Adjust the horizontal padding as needed
                                ),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                            ),
                            SizedBox(height: 5),
                            Align(
                              alignment: Alignment.center,
                              child: Divider(
                                color: Colors.grey, // Color of the divider
                                thickness: 1.0, // Thickness of the divider
                                indent: 16.0, // Indent on the left side
                                endIndent: 16.0, // Indent on the right side
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),
                  Text(
                    "STAFF ON DUTY",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),

                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Informed Senior Consultant:",
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
                                    child: Row(
                                      children: [
                                        buildInformedSeniorConsultantCheckboxWithLabel(
                                            "YES"),
                                        SizedBox(width: 10),
                                        buildInformedSeniorConsultantCheckboxWithLabel("NO"),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Senior Consultant's Name:",
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
                                      return "Senior Consultant's Name";
                                    }
                                    return null;
                                  },
                                  controller: _seniorConsultantNameController,
                                  enabled: false,
                                  autofocus: false,
                                  onSaved: (value) {
                                    // Handle saved value
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.person),
                                    hintText: "Senior Consultant's Name",
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
                                  "Informed Consultant:",
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
                                    child: Row(
                                      children: [
                                        buildInformedConsultantCheckboxWithLabel(
                                            "YES"),
                                        SizedBox(width: 10),
                                        buildInformedConsultantCheckboxWithLabel("NO"),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Consultant's Name:",
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
                                      return "Consultant's Name";
                                    }
                                    return null;
                                  },
                                  controller: _consultantNameController,
                                  enabled: false,
                                  autofocus: false,
                                  onSaved: (value) {
                                    // Handle saved value
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.person),
                                    hintText: "Consultant's Name",
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
                                  "Informed Medical Officer:",
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
                                    child: Row(
                                      children: [
                                        buildInformedMedicalOfficerCheckboxWithLabel(
                                            "YES"),
                                        SizedBox(width: 10),
                                        buildInformedMedicalOfficerCheckboxWithLabel("NO"),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Medical Officer's Name:",
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
                                      return "Medical Officer's Name";
                                    }
                                    return null;
                                  },
                                  controller: _medicalOfficerNameController,
                                  enabled: false,
                                  autofocus: false,
                                  onSaved: (value) {
                                    // Handle saved value
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.person),
                                    hintText: "Medical Officer's Name",
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
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.38,
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0.0, 0.0, 0.0, 0.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Case summary history, physical findings & final outcome:",
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
                                                return "Field is require";
                                              }
                                              return null;
                                            },
                                            controller: _caseSummaryController,
                                            enabled: false,
                                            autofocus: false,
                                            onSaved: (value) {
                                              // Handle saved value
                                            },
                                            minLines: 4,
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: 6,
                                            maxLength: 800,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText:
                                                  "Case summary history, physical findings & final outcome",
                                              hintStyle: TextStyle(
                                                color: Colors.black,
                                              ),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                vertical: 15,
                                                // Adjust the vertical padding as needed
                                                horizontal:
                                                    10, // Adjust the horizontal padding as needed
                                              ),
                                            ),
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                          ),
                                          SizedBox(height: 5),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Divider(
                                              color: Colors.grey,
                                              // Color of the divider
                                              thickness: 1.0,
                                              // Thickness of the divider
                                              indent: 16.0,
                                              // Indent on the left side
                                              endIndent:
                                              16.0, // Indent on the right side
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            "Triaged By: ${nurseTriageData?['patientTriagedBy']}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            "Triaged At: ${formatDateTime(nurseTriageData?['patientTriagedAt'])}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Divider(
                                              color: Colors.grey,
                                              // Color of the divider
                                              thickness: 1.0,
                                              // Thickness of the divider
                                              indent: 16.0,
                                              // Indent on the left side
                                              endIndent:
                                                  16.0, // Indent on the right side
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
                      ],
                    ),
                  ),

                  SizedBox(height: 10),
                  Text(
                    "***DOCTOR'S ASSESSMENT***",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Relevant History: ",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Vaginal Bleeding:",
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
                                      return "Vaginal Bleeding required";
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  onSaved: (value) {
                                    // Handle saved value
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.note),
                                    hintText: "Vaginal Bleeding",
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
                                  "Blurring Vision:",
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
                                      return "Blurring Vision required";
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  onSaved: (value) {
                                    // Handle saved value
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.note),
                                    hintText: "Blurring Vision",
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
                                  "Epigastric Pain:",
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
                                      return "Epigastric Pain required";
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  onSaved: (value) {
                                    // Handle saved value
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.note),
                                    hintText: "Epigastric Pain",
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
                                  "Draining Of  Liquor:",
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
                                      return "Draining Of Liquor required";
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  onSaved: (value) {
                                    // Handle saved value
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.note),
                                    hintText: "Draining Of Liquor",
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
                                  "Swelling Of Legs:",
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
                                      return "Swelling Legs  Of required";
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  onSaved: (value) {
                                    // Handle saved value
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.note),
                                    hintText: "Swelling Of Legs",
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
                                  "Vomiting:",
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
                                      return "Vomiting required";
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  onSaved: (value) {
                                    // Handle saved value
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.note),
                                    hintText: "Vomiting",
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
                                  "Fever:",
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
                                      return "Fever required";
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  onSaved: (value) {
                                    // Handle saved value
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.note),
                                    hintText: "Fever",
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
                                  "Headache:",
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
                                      return "Headache required";
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  onSaved: (value) {
                                    // Handle saved value
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.note),
                                    hintText: "Headache",
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
                                  "When did labour Start?",
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
                                      return "When did labour start required";
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  onSaved: (value) {
                                    // Handle saved value
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon:
                                        Icon(Icons.calendar_month_outlined),
                                    hintText: "When did labor start?",
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
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.28,
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0.0, 0.0, 0.0, 0.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Other Presenting Complaints or Symptoms:",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          TextFormField(
                                            autofocus: false,
                                            onSaved: (value) {
                                              // Handle saved value
                                            },
                                            minLines: 3,
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: 5,
                                            maxLength: 600,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText:
                                                  "Other Presenting Complaints or Symptoms",
                                              hintStyle: TextStyle(
                                                color: Colors.black,
                                              ),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                vertical: 15,
                                                // Adjust the vertical padding as needed
                                                horizontal:
                                                    10, // Adjust the horizontal padding as needed
                                              ),
                                            ),
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                          ),
                                          SizedBox(height: 5),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Divider(
                                              color: Colors.grey,
                                              // Color of the divider
                                              thickness: 1.0,
                                              // Thickness of the divider
                                              indent: 16.0,
                                              // Indent on the left side
                                              endIndent:
                                                  16.0, // Indent on the right side
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
                      ],
                    ),
                  ),

                  SizedBox(height: 10),
                  Text(
                    "***PHYSICAL EXAMINATIONS:***",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 15),

                  Text(
                    "a). General Examination: ",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Disability Level of Consciousness(AVPUI):",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
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
                                    'Select Disability Level Of Consciousness',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                  ),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  "EYES",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Checkout the colour of conjunctiva and sclera (and record whether it is white or jaundiced)",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Required";
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  onSaved: (value) {
                                    // Handle saved value
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.note),
                                    hintText: "Eyes Observation",
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 10),
                                  ),
                                  textAlignVertical: TextAlignVertical.center,
                                  textInputAction: TextInputAction.next,
                                ),
                                SizedBox(height: 5),
                                SizedBox(height: 15),
                                Text(
                                  "SKIN",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Look at the oedema, dehydration, signs of anaemia, lymph nodes and peripheral jaundice",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Required";
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  onSaved: (value) {
                                    // Handle saved value
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.note),
                                    hintText: "Skin observation",
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 10),
                                  ),
                                  textAlignVertical: TextAlignVertical.center,
                                  textInputAction: TextInputAction.next,
                                ),
                                SizedBox(height: 5),
                                SizedBox(height: 15),
                                Text(
                                  "HAIR",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Check if the hair is brittle, silver, curled, scanty, patches and dandruff.",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Required";
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  onSaved: (value) {
                                    // Handle saved value
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.note),
                                    hintText: "Hair observation",
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 10),
                                  ),
                                  textAlignVertical: TextAlignVertical.center,
                                  textInputAction: TextInputAction.next,
                                ),
                                SizedBox(height: 5),
                                SizedBox(height: 15),
                                Text(
                                  "NAILS",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Check out for clubbing nails, shape (spoon shaped or not) and then the pigmentation.",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Required";
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  onSaved: (value) {
                                    // Handle saved value
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.note),
                                    hintText: "Nails observation",
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 10),
                                  ),
                                  textAlignVertical: TextAlignVertical.center,
                                  textInputAction: TextInputAction.next,
                                ),
                                SizedBox(height: 5),
                                SizedBox(height: 15),
                                Text(
                                  "HANDS",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Checkout for capillary refill, patches, cracked in the hand, swellings, and tenderness",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Required";
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  onSaved: (value) {
                                    // Handle saved value
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.note),
                                    hintText: "Hands observation",
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
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),

                  Text(
                    "b). Abdominal Examinations: ",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15),
                                Text(
                                  "Observational Assessment(Abdomen)",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Where they see if the abdomen is normally full, swollen, symmetrical and presence of scars",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Required";
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  onSaved: (value) {
                                    // Handle saved value
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.note),
                                    hintText:
                                        "Observational Assessment(Abdomen)",
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
                                SizedBox(height: 15),
                                Text(
                                  "Palpation",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Check out the tenderness, and masses in the lower abdomen or pregnancy and determine the centimetres",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Required";
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  onSaved: (value) {
                                    // Handle saved value
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.note),
                                    hintText: "Palpation",
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 10),
                                  ),
                                  textAlignVertical: TextAlignVertical.center,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                ),
                                SizedBox(height: 10),
                                SizedBox(height: 15),
                                Text(
                                  "Auscultation",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Check for Abdominal sounds (bowl sounds) or any sounds that may be noticed",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Required";
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  onSaved: (value) {
                                    // Handle saved value
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.note),
                                    hintText: "Auscultation",
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
                                SizedBox(height: 15),
                                Text(
                                  "Palpation Resonance (Hyper/Hypo resonance)",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Check for tenderness and rebound tenderness ",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Required";
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  onSaved: (value) {
                                    // Handle saved value
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.note),
                                    hintText:
                                        "Palpation Resonance (Hyper/Hypo resonance)",
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
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.28,
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0.0, 0.0, 0.0, 0.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Other Presenting Complaints or Symptoms:",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          TextFormField(

                                            enabled: false,
                                            autofocus: false,
                                            onSaved: (value) {
                                              // Handle saved value
                                            },
                                            minLines: 3,
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: 5,
                                            maxLength: 600,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText:
                                                  "Other Presenting Complaints or Symptoms",
                                              hintStyle: TextStyle(
                                                color: Colors.black,
                                              ),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                vertical: 15,
                                                // Adjust the vertical padding as needed
                                                horizontal:
                                                    10, // Adjust the horizontal padding as needed
                                              ),
                                            ),
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                          ),
                                          SizedBox(height: 5),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Divider(
                                              color: Colors.grey,
                                              // Color of the divider
                                              thickness: 1.0,
                                              // Thickness of the divider
                                              indent: 16.0,
                                              // Indent on the left side
                                              endIndent:
                                                  16.0, // Indent on the right side
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
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "c) Pelvic Examinations (Vaginal Exams):",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Observational Assessment(Vagina)",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5),

                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.28,
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0.0, 0.0, 0.0, 0.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Vaginal exam, observation, the external genitalia (swellings, wounds, irritant, inflamed, discharge, bleeding)",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(height: 5),
                                          TextFormField(
                                            autofocus: false,
                                            onSaved: (value) {
                                              // Handle saved value
                                            },
                                            minLines: 4,
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: 6,
                                            maxLength: 1000,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText:
                                                  "Observational Assessment(Vagina)",
                                              hintStyle: TextStyle(
                                                color: Colors.black,
                                              ),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                vertical: 15,
                                                // Adjust the vertical padding as needed
                                                horizontal:
                                                    10, // Adjust the horizontal padding as needed
                                              ),
                                            ),
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                          ),
                                          SizedBox(height: 5),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Divider(
                                              color: Colors.grey,
                                              // Color of the divider
                                              thickness: 1.0,
                                              // Thickness of the divider
                                              indent: 16.0,
                                              // Indent on the left side
                                              endIndent:
                                                  16.0, // Indent on the right side
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
                      ],
                    ),
                  ),
                  SizedBox(height: 15),

                  Text(
                    "***SPECIFIC EXAMINATIONS:***",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 15),

                  Text(
                    "a). Heart & Lung Examinations: ",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Signs of pregnancy",
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
                                      return "Required";
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  onSaved: (value) {
                                    // Handle saved value
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.note),
                                    hintText: "Signs of pregnancy",
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 10),
                                  ),
                                  textAlignVertical: TextAlignVertical.center,
                                  textInputAction: TextInputAction.next,
                                ),
                                SizedBox(height: 5),
                                SizedBox(height: 15),
                                Text(
                                  "Fetal Exam",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 5),
                                SizedBox(height: 5),
                                SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0.0, 0.0, 0.0, 0.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.32,
                                                child: Container(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        0.0, 0.0, 0.0, 0.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Fetal movement and heart rate, Superficial palpation, Fetal presentation)",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        SizedBox(height: 5),
                                                        TextFormField(
                                                          autofocus: false,
                                                          onSaved: (value) {
                                                            // Handle saved value
                                                          },
                                                          minLines: 6,
                                                          keyboardType:
                                                              TextInputType
                                                                  .multiline,
                                                          maxLines: 8,
                                                          maxLength: 1200,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                OutlineInputBorder(),
                                                            hintText:
                                                                "Fetal movement and heart rate, Superficial palpation, Fetal presentation)",
                                                            hintStyle:
                                                                TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .symmetric(
                                                              vertical: 15,
                                                              // Adjust the vertical padding as needed
                                                              horizontal:
                                                                  10, // Adjust the horizontal padding as needed
                                                            ),
                                                          ),
                                                          textAlignVertical:
                                                              TextAlignVertical
                                                                  .center,
                                                        ),
                                                        SizedBox(height: 5),
                                                        Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Divider(
                                                            color: Colors.grey,
                                                            // Color of the divider
                                                            thickness: 1.0,
                                                            // Thickness of the divider
                                                            indent: 16.0,
                                                            // Indent on the left side
                                                            endIndent:
                                                                16.0, // Indent on the right side
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
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
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
                    "Submit Form",
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

  Future<void> fetchData() async {
    await fetchNurseTriageData();
    // Assuming nurseTriageData is used to build the UI, you might need to trigger a rebuild
    setState(() {
      _villageZoneController =
          TextEditingController(text: nurseTriageData?['patientVillage'] ?? '');
      _parishController =
          TextEditingController(text: nurseTriageData?['patientParish'] ?? '');
      _subCountyController =
          TextEditingController(text: nurseTriageData?['patientSubCounty'] ?? '');
      _districtController =
          TextEditingController(text: nurseTriageData?['patientDistrict'] ?? '');
      _maritalStatusController =
          TextEditingController(text: nurseTriageData?['patientMaritalStatus'] ?? '');
      _nationalIDController =
          TextEditingController(text: nurseTriageData?['patientNIN'] ?? '');
      _localChairPersonController =
          TextEditingController(text: nurseTriageData?['patientLCName'] ?? '');
      _nOKNameController =
          TextEditingController(text: nurseTriageData?['patientNOKName'] ?? '');
      _nOKRelationshipController =
          TextEditingController(text: nurseTriageData?['patientNOKRelationship'] ?? '');
      _nOKContactController =
          TextEditingController(text: nurseTriageData?['patientNOKContact'] ?? '');
      _referringHealthFacilityController =
          TextEditingController(text: nurseTriageData?['patientReferringHealFacility'] ?? '');
      _referralDiagnosisNoteController =
          TextEditingController(text: nurseTriageData?['patientReferralDiagnosis'] ?? '');
      _referralReasonController =
          TextEditingController(text: nurseTriageData?['patientReasonForReferral'] ?? '');
      _seniorConsultantNameController =
          TextEditingController(text: nurseTriageData?['patientSeniorConsultantName'] ?? '');
      _consultantNameController =
          TextEditingController(text: nurseTriageData?['patientConsultantName'] ?? '');
      _medicalOfficerNameController =
          TextEditingController(text: nurseTriageData?['patientMedicalOfficerName'] ?? '');
      _caseSummaryController =
          TextEditingController(text: nurseTriageData?['patientCaseSummary'] ?? '');

      selectedLabelNationality =  (nurseTriageData?['patientNationality'] ?? '');
      selectedTriageCategoryLabel =  (nurseTriageData?['triageCategory'] ?? '');
      selectedReferralInLabel  =  (nurseTriageData?['patientReferringHealFacility'] ?? "NO");
      selectedInformedSeniorConsultantLabel =  (nurseTriageData?['patientInformedSeniorConsultant'] ?? "NO");
      selectedInformedConsultantLabel =  (nurseTriageData?['patientInformedConsultant'] ?? "NO");
      selectedInformedMedicalOfficerLabel =  (nurseTriageData?['patientInformedMedicalOfficer'] ?? "NO");


    });
  }

  Future<void> fetchNurseTriageData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('nurseTriageFormData')
          .doc(widget.patientId)
          .get();
      if (snapshot.exists) {
        setState(() {
          nurseTriageData = snapshot.data();
        });

        print("nurseTriageData: $nurseTriageData");
      }
    } catch (error) {
      print("Error fetching nurseTriageData: $error");
    }
  }
}
