import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:triage_app/model/triage_form_nurse_model.dart';
import 'package:triage_app/model/user_model.dart';
import 'package:triage_app/model/triage_form_doctor_model.dart';
import 'package:intl/intl.dart';

class TriageDoctorScreen extends StatefulWidget {
  final String? patientId;
  final String? patientNumber;
  final String? status;

  TriageDoctorScreen({this.patientId, this.patientNumber, this.status});

  @override
  _TriageDoctorScreenState createState() => _TriageDoctorScreenState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
FirebaseAuth _auth = FirebaseAuth.instance;

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


  //====Doctors Screen====
  TextEditingController? _patientVaginalBleedingController;
  TextEditingController? _patientBlurringVisionController;


  final TextEditingController _userTypeController = TextEditingController();
  bool _isSubmitting = false;

  // final TextEditingController _patientVaginalBleedingController =
  //     TextEditingController();
  // final TextEditingController _patientBlurringVisionController =
  //     TextEditingController();
  final TextEditingController _patientEpigastricPainController =
      TextEditingController();
  final TextEditingController _patientDrainingOfLiquorController =
      TextEditingController();
  final TextEditingController _patientSwellingOfLegsController =
      TextEditingController();
  final TextEditingController _patientVomitingController =
      TextEditingController();
  final TextEditingController _patientFeverController = TextEditingController();
  final TextEditingController _patientHeadacheController =
      TextEditingController();
  final TextEditingController _patientStartOfLabourController =
      TextEditingController();
  final TextEditingController _patientPresentingComplaintsController =
      TextEditingController();
  final TextEditingController _patientDisabilityLevelController =
      TextEditingController();
  final TextEditingController _patientEyesObservationController =
      TextEditingController();
  final TextEditingController _patientSkinObservationController =
      TextEditingController();
  final TextEditingController _patientHairObservationController =
      TextEditingController();
  final TextEditingController _patientNailsObservationController =
      TextEditingController();
  final TextEditingController _patientHandsObservationController =
      TextEditingController();
  final TextEditingController _patientAbdomenObservationController =
      TextEditingController();
  final TextEditingController _patientPalpationController =
      TextEditingController();
  final TextEditingController _patientAuscultationController =
      TextEditingController();
  final TextEditingController _patientHyperHypoResonanceController =
      TextEditingController();
  final TextEditingController _patientOtherPresentingComplaintsController =
      TextEditingController();
  final TextEditingController
      _patientOtherPresentingComplaintsAbdomenController =
      TextEditingController();
  final TextEditingController _patientVaginaObservationController =
      TextEditingController();
  final TextEditingController _patientSignsOfPregnancyController =
      TextEditingController();
  final TextEditingController _patientFetalExamController =
      TextEditingController();

  Map<String, dynamic>? nurseTriageData;
  Map<String, dynamic>? doctorTriageData;

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
    String formattedTime =
        DateFormat('hh:mma').format(parsedDateTime).toLowerCase();
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
            // setState(() {
            //   if (selectedInformedSeniorConsultantLabel == label) {
            //     selectedInformedSeniorConsultantLabel =
            //     ""; // Uncheck if already selected
            //   } else {
            //     selectedInformedSeniorConsultantLabel =
            //         label; // Check the selected label
            //   }
            // });
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
            // setState(() {
            //   if (selectedInformedConsultantLabel == label) {
            //     selectedInformedConsultantLabel =
            //     ""; // Uncheck if already selected
            //   } else {
            //     selectedInformedConsultantLabel =
            //         label; // Check the selected label
            //   }
            // });
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
            // setState(() {
            //   if (selectedInformedMedicalOfficerLabel == label) {
            //     selectedInformedMedicalOfficerLabel =
            //     ""; // Uncheck if already selected
            //   } else {
            //     selectedInformedMedicalOfficerLabel =
            //         label; // Check the selected label
            //   }
            // });
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
                            // Text(
                            //   "Patient #: 0900000",
                            //   style: TextStyle(
                            //     color: Colors.white60,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
                      height: MediaQuery.of(context).size.height * 0.42,
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
                                controller: _villageZoneController,
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
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.34,
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
                                controller: _localChairPersonController,
                                enabled: false,
                                autofocus: false,
                                onSaved: (value) {
                                  // Handle saved value
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
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.34,
                      child: Container(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
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
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 5),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
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
                                    height: MediaQuery.of(context).size.height *
                                        0.38,
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
                                              controller:
                                                  _caseSummaryController,
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Relevant History: ",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
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
                                    controller: _patientVaginalBleedingController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Vaginal Bleeding required";
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      _patientVaginalBleedingController?.text = value;
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
                                    controller: _patientBlurringVisionController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Blurring Vision required";
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      _patientBlurringVisionController?.text =
                                          value!;
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
                                    onChanged: (value) {
                                      _patientEpigastricPainController.text =
                                          value!;
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
                                    onChanged: (value) {
                                      _patientDrainingOfLiquorController.text =
                                          value!;
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
                                    onChanged: (value) {
                                      _patientSwellingOfLegsController.text =
                                          value!;
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
                                    onChanged: (value) {
                                      _patientVomitingController.text = value!;
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
                                    onChanged: (value) {
                                      _patientFeverController.text = value!;
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
                                    onChanged: (value) {
                                      _patientHeadacheController.text = value!;
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
                                    onChanged: (value) {
                                      _patientStartOfLabourController.text =
                                          value!;
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
                                              onChanged: (value) {
                                                _patientOtherPresentingComplaintsController
                                                    .text = value!;
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
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 15),

                    Text(
                      "a). General Examination: ",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 16),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      // Add more decoration..
                                    ),
                                    hint: const Text(
                                      'Select Disability Level',
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
                                        return 'Please select Disability Level.';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      //Do something when selected item is changed.
                                      _patientDisabilityLevelController.text =
                                          value!;
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
                                    onChanged: (value) {
                                      _patientEyesObservationController.text =
                                          value!;
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
                                    onChanged: (value) {
                                      _patientSkinObservationController.text =
                                          value!;
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
                                    onChanged: (value) {
                                      _patientHairObservationController.text =
                                          value!;
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
                                    onChanged: (value) {
                                      _patientNailsObservationController.text =
                                          value!;
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
                                    onChanged: (value) {
                                      _patientHandsObservationController.text =
                                          value!;
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
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
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
                                    onChanged: (value) {
                                      _patientAbdomenObservationController
                                          .text = value!;
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
                                    onChanged: (value) {
                                      _patientPalpationController.text = value!;
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
                                    keyboardType:
                                        TextInputType.numberWithOptions(
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
                                    onChanged: (value) {
                                      _patientAuscultationController.text =
                                          value!;
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
                                    onChanged: (value) {
                                      _patientHyperHypoResonanceController
                                          .text = value!;
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
                                              onChanged: (value) {
                                                _patientOtherPresentingComplaintsAbdomenController
                                                    .text = value!;
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
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
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
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Required";
                                                }
                                                return null;
                                              },
                                              onChanged: (value) {
                                                _patientVaginaObservationController
                                                    .text = value!;
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
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 15),

                    Text(
                      "a). Heart & Lung Examinations: ",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
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
                                    onChanged: (value) {
                                      _patientSignsOfPregnancyController.text =
                                          value!;
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
                                                            validator: (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                return "Required";
                                                              }
                                                              return null;
                                                            },
                                                            onChanged: (value) {
                                                              _patientFetalExamController
                                                                      .text =
                                                                  value!;
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
                                                                color: Colors
                                                                    .black,
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
                                                            alignment: Alignment
                                                                .center,
                                                            child: Divider(
                                                              color:
                                                                  Colors.grey,
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
              onTap: _isSubmitting || widget.status == 'True' ? null : () async {
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
                  color: _isSubmitting || widget.status == 'True' ? Colors.grey : Color(0xFF7165D6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    _isSubmitting ? "Submitting..." : widget.status == 'True' ? "Patient Serviced Already" : "Submit Form",
                    // _isSubmitting ? "Submitting..." : "Submit Form",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            )

            // InkWell(
            //   onTap: () async {
            //     if (!_formKey.currentState!.validate()) {
            //       return; // Stop the submission if the form is not valid
            //     }
            //
            //     setState(() {
            //       _isSubmitting = true; // Show "Submitting..." message
            //     });
            //
            //     try {
            //       await postDetailsToFirestore();
            //       setState(() {
            //         _isSubmitting = false;
            //       });
            //       // Rest of your code for success or error handling
            //     } catch (error) {
            //       setState(() {
            //         _isSubmitting = false; // Hide "Submitting..." message
            //       });
            //       Fluttertoast.showToast(msg: "An error occurred: $error");
            //     }
            //   },
            //   child: Container(
            //     width: MediaQuery.of(context).size.width,
            //     padding: EdgeInsets.symmetric(vertical: 18),
            //     decoration: BoxDecoration(
            //       color: Color(0xFF7165D6),
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child: Center(
            //       child: Text(
            //         _isSubmitting ? "Submitting..." : "Submit  Form",
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 18,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
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

    TriageFormDoctorModel triageData = TriageFormDoctorModel(
      uid: user?.uid,
      patientId: widget.patientId,
      patientNumber: widget.patientNumber,
      triageFormNurseId: nurseTriageData?["uid"],
      patientVaginalBleeding: _patientVaginalBleedingController?.text ?? '',
      patientBlurringVision: _patientBlurringVisionController?.text ?? '',
      patientEpigastricPain: _patientEpigastricPainController.text,
      patientDrainingOfLiquor: _patientDrainingOfLiquorController.text,
      patientSwellingOfLegs: _patientSwellingOfLegsController.text,
      patientVomiting: _patientVomitingController.text,
      patientFever: _patientFeverController.text,
      patientHeadache: _patientHeadacheController.text,
      patientStartOfLabour: _patientStartOfLabourController.text,
      patientPresentingComplaints: _patientOtherPresentingComplaintsAbdomenController.text,
      patientDisabilityLevel: _patientDisabilityLevelController.text,
      patientEyesObservation: _patientEyesObservationController.text,
      patientSkinObservation: _patientSkinObservationController.text,
      patientHairObservation: _patientHairObservationController.text,
      patientNailsObservation: _patientNailsObservationController.text,
      patientAbdomenObservation: _patientAbdomenObservationController.text,
      patientPalpation: _patientPalpationController.text,
      patientAuscultation: _patientAuscultationController.text,
      patientHyperHypoResonance: _patientHyperHypoResonanceController.text,
      patientOtherPresentingComplaints:
          _patientOtherPresentingComplaintsController.text,
      patientVaginaObservation: _patientVaginaObservationController.text,
      patientSignsOfPregnancy: _patientSignsOfPregnancyController.text,
      patientFetalExam: _patientFetalExamController.text,
      patientExaminedBy: triagedBy,
      patientExaminedAt: currentDate.toLocal().toString(),
    );

    try {
      await firebaseFirestore
          .collection("doctorTriageFormData")
          .doc(widget.patientId)
          .set(triageData.toMap());

      Fluttertoast.showToast(msg: "Triage data saved successfully!");

      // Update nurseTriaged to "True"
      await firebaseFirestore
          .collection("users")
          .doc(widget.patientId)
          .update({'doctorTriaged': "True"});

      // Clear the form
      _formKey.currentState?.reset();

      // Route back to the previous page
      Navigator.pop(context);
    } catch (error) {
      Fluttertoast.showToast(msg: "An error occurred: $error");
    }
  }

  Future<void> fetchData() async {
    await fetchNurseTriageData();
    await fetchDoctorTriageData();


    // Assuming nurseTriageData is used to build the UI, you might need to trigger a rebuild
    setState(() {
      _villageZoneController =
          TextEditingController(text: nurseTriageData?['patientVillage'] ?? '');
      _parishController =
          TextEditingController(text: nurseTriageData?['patientParish'] ?? '');
      _subCountyController = TextEditingController(
          text: nurseTriageData?['patientSubCounty'] ?? '');
      _districtController = TextEditingController(
          text: nurseTriageData?['patientDistrict'] ?? '');
      _maritalStatusController = TextEditingController(
          text: nurseTriageData?['patientMaritalStatus'] ?? '');
      _nationalIDController =
          TextEditingController(text: nurseTriageData?['patientNIN'] ?? '');
      _localChairPersonController =
          TextEditingController(text: nurseTriageData?['patientLCName'] ?? '');
      _nOKNameController =
          TextEditingController(text: nurseTriageData?['patientNOKName'] ?? '');
      _nOKRelationshipController = TextEditingController(
          text: nurseTriageData?['patientNOKRelationship'] ?? '');
      _nOKContactController = TextEditingController(
          text: nurseTriageData?['patientNOKContact'] ?? '');
      _referringHealthFacilityController = TextEditingController(
          text: nurseTriageData?['patientReferringHealFacility'] ?? '');
      _referralDiagnosisNoteController = TextEditingController(
          text: nurseTriageData?['patientReferralDiagnosis'] ?? '');
      _referralReasonController = TextEditingController(
          text: nurseTriageData?['patientReasonForReferral'] ?? '');
      _seniorConsultantNameController = TextEditingController(
          text: nurseTriageData?['patientSeniorConsultantName'] ?? '');
      _consultantNameController = TextEditingController(
          text: nurseTriageData?['patientConsultantName'] ?? '');
      _medicalOfficerNameController = TextEditingController(
          text: nurseTriageData?['patientMedicalOfficerName'] ?? '');
      _caseSummaryController = TextEditingController(
          text: nurseTriageData?['patientCaseSummary'] ?? '');

      selectedLabelNationality = (nurseTriageData?['patientNationality'] ?? '');
      selectedTriageCategoryLabel = (nurseTriageData?['triageCategory'] ?? '');
      selectedReferralInLabel =
          (nurseTriageData?['patientReferralIn'] ?? "NO");
      selectedInformedSeniorConsultantLabel =
          (nurseTriageData?['patientInformedSeniorConsultant'] ?? "NO");
      selectedInformedConsultantLabel =
          (nurseTriageData?['patientInformedConsultant'] ?? "NO");
      selectedInformedMedicalOfficerLabel =
          (nurseTriageData?['patientInformedMedicalOfficer'] ?? "NO");


      _patientVaginalBleedingController = TextEditingController(
        text: doctorTriageData?['patientVaginalBleeding'] ?? '',
      );
      _patientBlurringVisionController = TextEditingController(
        text: doctorTriageData?['patientBlurringVision'] ?? '',
      );


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
  Future<void> fetchDoctorTriageData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('doctorTriageFormData')
          .doc(widget.patientId)
          .get();
      if (snapshot.exists) {
        setState(() {
          doctorTriageData = snapshot.data()!;
        });

        print("doctorTriageData: $doctorTriageData");
      }
    } catch (error) {
      print("Error fetching doctorTriageData: $error");
    }
  }

}


