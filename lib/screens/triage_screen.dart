import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:triage_app/model/triage_form_nurse_model.dart';
import 'package:triage_app/model/user_model.dart';

class TriageScreen extends StatefulWidget {
  final String? patientId;
  final String? patientNumber;

  TriageScreen({this.patientId, this.patientNumber});

  @override
  _TriageScreenState createState() => _TriageScreenState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
FirebaseAuth _auth = FirebaseAuth.instance;

class _TriageScreenState extends State<TriageScreen> {
  // final String patientId = ModalRoute.of(context)!.patientId.arguments as String;
  // final String patientNumber = ModalRoute.of(context)!.patientNumber.arguments as String;

  final List<String> userTypeItems = [
    'Alert',
    'Verbal',
    'Pain',
    'Unresponsive',
    'Irritable'
  ];
  bool _isSubmitting = false;
  final TextEditingController _villageZoneController = TextEditingController();
  final TextEditingController _parishController = TextEditingController();
  final TextEditingController _subCountyController = TextEditingController();
  final TextEditingController _userTypeController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _maritalStatusController =
      TextEditingController();
  final TextEditingController _nationalIDController = TextEditingController();
  final TextEditingController _localChairPersonController =
      TextEditingController();
  final TextEditingController _nOKNameController = TextEditingController();
  final TextEditingController _nOKRelationshipController =
      TextEditingController();
  final TextEditingController _nOKContactController = TextEditingController();
  final TextEditingController _referringHealthFacilityController =
      TextEditingController();
  final TextEditingController _referralDiagnosisNoteController =
      TextEditingController();
  final TextEditingController _referralReasonController =
      TextEditingController();
  final TextEditingController _seniorConsultantNameController =
      TextEditingController();
  final TextEditingController _consultantNameController =
      TextEditingController();
  final TextEditingController _medicalOfficerNameController =
      TextEditingController();
  final TextEditingController _caseSummaryController = TextEditingController();

  String selectedTriageCategoryLabel = "";
  String selectedLabelNationality = "";

  String selectedReferralInLabel = "";
  String selectedInformedSeniorConsultantLabel = "";
  String selectedInformedConsultantLabel = "";
  String selectedInformedMedicalOfficerLabel = "";

  bool isChecked = false;
  String? selectedValue;
  String? patientNumberReturned;

  List<String> imgs = [
    "doctor1.jpg",
    "doctor2.jpg",
    "doctor3.jpg",
    "doctor4.jpg",
  ];


  Widget buildCheckboxWithLabelForTriage(String label, Color color) {
    return Row(
      children: [
        Checkbox(
          value: selectedTriageCategoryLabel == label,
          activeColor: color,
          onChanged: (value) {
            setState(() {
              if (selectedTriageCategoryLabel == label) {
                selectedTriageCategoryLabel = ""; // Uncheck if already selected
              } else {
                selectedTriageCategoryLabel = label; // Check the selected label
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

  Widget buildReferralInCheckboxWithLabel(String label) {
    return Row(
      children: [
        Checkbox(
          value: selectedReferralInLabel == label,
          activeColor: Colors.blue,
          onChanged: (value) {
            setState(() {
              if (selectedReferralInLabel == label) {
                selectedReferralInLabel = ""; // Uncheck if already selected
              } else {
                selectedReferralInLabel = label; // Check the selected label
              }
            });
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                              "Patient #:  ${widget.patientNumber}",
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height / 0.1,
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: 40,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          buildCheckboxWithLabelForTriage("RED", Colors.red),
                          buildCheckboxWithLabelForTriage(
                              "YELLOW", Colors.yellow),
                          buildCheckboxWithLabelForTriage(
                              "ORANGE", Colors.orange),
                          buildCheckboxWithLabelForTriage(
                              "GREEN", Colors.green),
                          buildCheckboxWithLabelForTriage("BLUE", Colors.blue),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Nationality: ",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
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
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: Container(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
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
                                onChanged: (value) {
                                  _villageZoneController.text = value!;
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
                                onChanged: (value) {
                                  _parishController.text = value!;
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
                                onChanged: (value) {
                                  _subCountyController.text = value!;
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
                                onChanged: (value) {
                                  _districtController.text = value!;
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

                              SizedBox(height: 20),
                              // Add space above the divider

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

                    SizedBox(height: 20),

                    Text(
                      "Bio-data: ",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: Container(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
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
                                onChanged: (value) {
                                  _maritalStatusController.text = value!;
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
                                onChanged: (value) {
                                  _nationalIDController.text = value!;
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
                                onChanged: (value) {
                                  _localChairPersonController.text = value!;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.person),
                                  hintText:
                                      "LC1 Chairperson/VHT Contact Person",
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
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    Text(
                      "Relationship: ",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: Container(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Next Of Kin Name:",
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
                                    return "Next Of Kin Name";
                                  }
                                  return null;
                                },
                                autofocus: false,
                                onSaved: (value) {
                                  // Handle saved value
                                },
                                onChanged: (value) {
                                  _nOKNameController.text = value!;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.person),
                                  hintText: "Next Of Kin Name",
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
                                onChanged: (value) {
                                  _nOKRelationshipController.text = value!;
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
                                onChanged: (value) {
                                  _nOKContactController.text = value!;
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
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(height: 20),
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

                    Text(
                      "Referral: ",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 5),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Container(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
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
                                validator: (value) {
                                  if (selectedReferralInLabel == "YES" &&
                                      value!.isEmpty) {
                                    return "Referring Health Facility is required";
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  if (selectedReferralInLabel == "YES") {
                                    setState(() {
                                      _referringHealthFacilityController.text =
                                          value;
                                    });
                                  }
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
                              SizedBox(height: 20),
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

                    Text(
                      "A). Referral Diagnosis: ",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 5),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.21,
                      child: Container(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
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
                                  if (selectedReferralInLabel == "YES" &&
                                      value!.isEmpty) {
                                    return "Referral Diagnosis Note is required";
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  if (selectedReferralInLabel == "YES") {
                                    setState(() {
                                      _referralDiagnosisNoteController.text =
                                          value;
                                    });
                                  }
                                },
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
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 5),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.28,
                      child: Container(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
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
                                  if (selectedReferralInLabel == "YES" &&
                                      value!.isEmpty) {
                                    return "Principle Reason for Referral Note is required";
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  if (selectedReferralInLabel == "YES") {
                                    setState(() {
                                      _referralReasonController.text = value;
                                    });
                                  }
                                },
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
                                  hintText:
                                      "Principle Reason for Referral Note",
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
                                          buildInformedSeniorConsultantCheckboxWithLabel(
                                              "NO"),
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
                                      if (selectedInformedSeniorConsultantLabel ==
                                              "YES" &&
                                          value!.isEmpty) {
                                        return "Senior Consultant's Name is required";
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      if (selectedInformedSeniorConsultantLabel ==
                                          "YES") {
                                        setState(() {
                                          _seniorConsultantNameController.text =
                                              value;
                                        });
                                      }
                                    },
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
                                          buildInformedConsultantCheckboxWithLabel(
                                              "NO"),
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
                                      if (selectedInformedConsultantLabel ==
                                              "YES" &&
                                          value!.isEmpty) {
                                        return "Consultant's Name is required";
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      if (selectedInformedConsultantLabel ==
                                          "YES") {
                                        setState(() {
                                          _consultantNameController.text =
                                              value;
                                        });
                                      }
                                    },
                                    // validator: (value) {
                                    //   if (selectedInformedConsultantLabel ==
                                    //       "YES") {
                                    //     return "Consultant's Name Required";
                                    //   }
                                    //   return null;
                                    // },
                                    // onChanged: (value) {
                                    //   _consultantNameController.text = value!;
                                    // },
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
                                          buildInformedMedicalOfficerCheckboxWithLabel(
                                              "NO"),
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
                                      if (selectedInformedMedicalOfficerLabel ==
                                              "YES" &&
                                          value!.isEmpty) {
                                        return "Medical Officer's Name is required";
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      if (selectedInformedMedicalOfficerLabel ==
                                          "YES") {
                                        setState(() {
                                          _medicalOfficerNameController.text =
                                              value;
                                        });
                                      }
                                    },
                                    // validator: (value) {
                                    //   if (selectedInformedMedicalOfficerLabel ==
                                    //       "YES") {
                                    //     return "Medical Officer's Name Required";
                                    //   }
                                    //   return null;
                                    // },
                                    // onChanged: (value) {
                                    //   _medicalOfficerNameController.text =
                                    //   value!;
                                    // },
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
                                    height: MediaQuery.of(context).size.height *
                                        0.28,
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
                                                  return "Field is required";
                                                }
                                                return null;
                                              },
                                              onChanged: (value) {
                                                _caseSummaryController.text =
                                                    value!;
                                              },
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
                  ],
                ),
              ),
            ],
          ),
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
              onTap: () async {
                if (selectedTriageCategoryLabel.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "Please select a triage Level/Category");
                  return;
                }
                if (selectedLabelNationality.isEmpty) {
                  Fluttertoast.showToast(msg: "Please select Nationality");
                  return;
                }

                if (selectedInformedSeniorConsultantLabel.isNotEmpty ||
                    selectedInformedConsultantLabel.isNotEmpty ||
                    selectedInformedMedicalOfficerLabel.isNotEmpty) {
                } else {
                  Fluttertoast.showToast(
                      msg: "Please select a person informed");
                }

                if (!_formKey.currentState!.validate()) {
                  return; // Stop the submission if the form is not valid
                }

                setState(() {
                  _isSubmitting = true; // Show "Submitting..." message
                });

                try {
                  await postDetailsToFirestore();

                  setState(() {
                    _isSubmitting = false;
                  });
                  // Rest of your code for success or error handling
                } catch (error) {
                  setState(() {
                    _isSubmitting = false; // Hide "Submitting..." message
                  });
                  Fluttertoast.showToast(msg: "An error occurred: $error");
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: Color(0xFF7165D6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    _isSubmitting ? "Submitting..." : "Submit Triage Form",
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

  Future<String> getCurrentUserName(String uid) async {
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (userSnapshot.exists) {
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;
      UserModel userModel = UserModel.fromMap(userData);
      return userModel.name ?? 'Unknown';
    } else {
      return 'User not found';
    }
  }

  Future<void> postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    DateTime currentDate = DateTime.now();
    String currentUserUid = user?.uid ?? '';
    String triagedBy = await getCurrentUserName(currentUserUid);

    TriageFormNurseModel triageData = TriageFormNurseModel(
      uid: user?.uid,
      patientId: widget.patientId,
      patientNumber: widget.patientNumber,
      triageCategory: selectedTriageCategoryLabel,
      patientNationality: selectedLabelNationality,
      patientVillage: _villageZoneController.text,
      patientParish: _parishController.text,
      patientSubCounty: _subCountyController.text,
      patientDistrict: _districtController.text,
      patientMaritalStatus: _maritalStatusController.text,
      patientNIN: _nationalIDController.text,
      patientLCName: _localChairPersonController.text,
      patientNOKName: _nOKNameController.text,
      patientNOKRelationship: _nOKRelationshipController.text,
      patientNOKContact: _nOKContactController.text,
      patientReferralIn:
          selectedReferralInLabel.isEmpty ? "NO" : selectedReferralInLabel,
      patientReferringHealFacility: _referringHealthFacilityController.text,
      patientReferralDiagnosis: _referralDiagnosisNoteController.text,
      patientReasonForReferral: _referralReasonController.text,
      patientInformedSeniorConsultant:
          selectedInformedSeniorConsultantLabel.isEmpty
              ? "NO"
              : selectedInformedSeniorConsultantLabel,
      patientSeniorConsultantName: _seniorConsultantNameController.text,
      patientInformedConsultant: selectedInformedConsultantLabel.isEmpty
          ? "NO"
          : selectedInformedConsultantLabel,
      patientConsultantName: _consultantNameController.text,
      patientInformedMedicalOfficer: selectedInformedMedicalOfficerLabel.isEmpty
          ? "NO"
          : selectedInformedMedicalOfficerLabel,
      patientMedicalOfficerName: _medicalOfficerNameController.text,
      patientCaseSummary: _caseSummaryController.text,
      patientTriagedBy: triagedBy,
      patientTriagedAt: currentDate.toLocal().toString(),
    );

    try {
      await firebaseFirestore
          .collection("nurseTriageFormData")
          .doc(widget.patientId)
          .set(triageData.toMap());

      Fluttertoast.showToast(msg: "Triage data saved successfully!");

      // Update nurseTriaged to "True"
      await firebaseFirestore
          .collection("users")
          .doc(widget.patientId)
          .update({'nurseTriaged': "True"});

      // Clear the form
      _formKey.currentState?.reset();

      // Route back to the previous page
      Navigator.pop(context);
    } catch (error) {
      Fluttertoast.showToast(msg: "An error occurred: $error");
    }
  }
}
