import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:triage_app/utils/helper.dart';
import 'package:triage_app/screens/appointment_screen.dart';
import 'package:triage_app/screens/triage_screen.dart';
import 'package:triage_app/screens/triage_doctor_screen.dart';
import 'package:triage_app/utils/Constants.dart';

class NurseHomeScreen extends StatefulWidget {
  @override
  _NurseHomeScreenState createState() => _NurseHomeScreenState();
}

class _NurseHomeScreenState extends State<NurseHomeScreen> {
  String _userName = '';
  List<DocumentSnapshot> _patients = [];
  List symptoms = [
    "Temperature",
    "Snuffle",
    "Fever",
    "Cough",
    "Cold",
  ];

  List imgs = [
    "doctor1.jpg",
    "doctor2.jpg",
    "doctor3.jpg",
    "doctor4.jpg",
  ];

  @override
  void initState() {
    super.initState();
    getUserNameFromStorage();
    fetchPatients().then((patients) {
      setState(() {
        _patients = patients;
      });
    });
  }

  Future<List<DocumentSnapshot>> fetchPatients() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('userType', isEqualTo: 'Patient')
              // .where('nurseTriaged', isEqualTo: 'False')
              .get();
      return snapshot.docs;
    } catch (e) {
      // Handle any errors if needed
      return [];
    }
  }

  void getUserNameFromStorage() async {
    String? userName = await getDataLocally("user_name");
    setState(() {
      _userName = userName ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _userName,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage("images/doctor1.jpg"),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  // Existing container code...
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFF7165D6),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add,
                          color: Color(0xFF7165D6),
                          size: 35,
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        "Clinic Visit",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Make an appointment",
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  // Existing container code...
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFFF0EEFA),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.home_filled,
                          color: Color(0xFF7165D6),
                          size: 35,
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        "Home Visit",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Call the doctor home",
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              "Patients For Maternity's Triage",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio:
                  0.8, // Adjust this value to control item aspect ratio
            ),
            itemCount: _patients.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (_patients[index]['nurseTriaged'] != "True") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TriageScreen(
                          patientId: _patients[index]['uid'],
                          patientNumber: _patients[index]['refNumber'],
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: _patients[index]['nurseTriaged'] == "True"
                        ? Colors.grey
                            .withOpacity(0.6) // Semi-transparent grey color
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Color(
                            Constants.COLOR_DARK_GREEN,
                          ),
                          child: Text(
                            getInitials(_patients[index]['name'] ?? ''),
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width *
                                  0.04, // Adjust the factor as needed
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Patient #: ${_patients[index]['refNumber']}",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width *
                                0.03, // Adjust the factor as needed
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          "E-mail: ${_patients[index]['email']}",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width *
                                0.025, // Adjust the factor as needed
                            color: Colors.black45,
                          ),
                        ),
                        Text(
                          "Status: ${_patients[index]['nurseTriaged'] == "True" ? "Triaged" : "In Queue"}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _patients[index]['nurseTriaged'] == "True"
                                ? Colors.green
                                : Colors.red,
                            fontSize: MediaQuery.of(context).size.width *
                                0.025, // Adjust the factor as needed
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
