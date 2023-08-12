class TriageFormNurseModel {
  String? patientId;
  String? patientNumber;
  String? uid;
  String? triageCategory;
  String? patientNationality;
  String? patientVillage;
  String? patientParish;
  String? patientSubCounty;
  String? patientDistrict;
  String? patientMaritalStatus;
  String? patientNIN;
  String? patientLCName;
  String? patientNOKName;
  String? patientNOKRelationship;
  String? patientNOKContact;
  String? patientReferralIn;
  String? patientReferringHealFacility;
  String? patientReferralDiagnosis;
  String? patientReasonForReferral;
  String? patientInformedSeniorConsultant;
  String? patientSeniorConsultantName;
  String? patientInformedConsultant;
  String? patientConsultantName;
  String? patientInformedMedicalOfficer;
  String? patientMedicalOfficerName;
  String? patientCaseSummary;
  String? patientTriagedBy;
  String? patientTriagedAt;


  TriageFormNurseModel({
    this.patientId,
    this.patientNumber,
    this.uid,
    this.triageCategory,
    this.patientNationality,
    this.patientVillage,
    this.patientParish,
    this.patientSubCounty,
    this.patientDistrict,
    this.patientMaritalStatus,
    this.patientNIN,
    this.patientLCName,
    this.patientNOKName,
    this.patientNOKRelationship,
    this.patientNOKContact,
    this.patientReferralIn,
    this.patientReferringHealFacility,
    this.patientReferralDiagnosis,
    this.patientReasonForReferral,
    this.patientInformedSeniorConsultant,
    this.patientSeniorConsultantName,
    this.patientInformedConsultant,
    this.patientConsultantName,
    this.patientInformedMedicalOfficer,
    this.patientMedicalOfficerName,
    this.patientCaseSummary,
    this.patientTriagedBy,
    this.patientTriagedAt,

  });



  // receiving data from server
  factory TriageFormNurseModel.fromMap(map) {
    return TriageFormNurseModel(
      patientId: map['patientId'],
      patientNumber: map['patientNumber'],
      uid: map['uid'],
      triageCategory: map['triageCategory'],
      patientNationality: map['patientNationality'],
      patientVillage: map['patientVillage'],
      patientParish: map['patientParish'],
      patientSubCounty: map['patientSubCounty'],
      patientDistrict: map['patientDistrict'],
      patientMaritalStatus: map['patientMaritalStatus'],
      patientNIN: map['patientNIN'],
      patientLCName: map['patientLCName'],
      patientNOKName: map['patientNOKName'],
      patientNOKRelationship: map['patientNOKRelationship'],
      patientNOKContact: map['patientNOKContact'],
      patientReferralIn: map['patientReferralIn'],
      patientReferringHealFacility: map['patientReferringHealFacility'],
      patientReferralDiagnosis: map['patientReferralDiagnosis'],
      patientReasonForReferral: map['patientReasonForReferral'],
      patientInformedSeniorConsultant: map['patientInformedSeniorConsultant'],
      patientSeniorConsultantName: map['patientSeniorConsultantName'],
      patientInformedConsultant: map['patientInformedConsultant'],
      patientConsultantName: map['patientConsultantName'],
      patientInformedMedicalOfficer: map['patientInformedMedicalOfficer'],
      patientMedicalOfficerName: map['patientMedicalOfficerName'],
      patientCaseSummary: map['patientCaseSummary'],
      patientTriagedBy: map['patientTriagedBy'],
      patientTriagedAt: map['patientTriagedAt'],

    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'patientId': patientId,
      'patientNumber': patientNumber,
      'uid': uid,
      'triageCategory': triageCategory,
      'patientNationality': patientNationality,
      'patientVillage': patientVillage,
      'patientParish' : patientParish,
      'patientSubCounty': patientSubCounty,
      'patientDistrict': patientDistrict,
      'patientMaritalStatus': patientMaritalStatus,
      'patientNIN': patientNIN,
      'patientLCName': patientLCName,
      'patientNOKName': patientNOKName,
      'patientNOKRelationship': patientNOKRelationship,
      'patientReferralIn': patientReferralIn,
      'patientReferringHealFacility': patientReferringHealFacility,
      'patientReferralDiagnosis': patientReferralDiagnosis,
      'patientReasonForReferral': patientReasonForReferral,
      'patientInformedSeniorConsultant': patientInformedSeniorConsultant,
      'patientSeniorConsultantName': patientSeniorConsultantName,
      'patientInformedConsultant': patientInformedConsultant,
      'patientConsultantName': patientConsultantName,
      'patientInformedMedicalOfficer': patientInformedMedicalOfficer,
      'patientMedicalOfficerName' : patientMedicalOfficerName,
      'patientTriagedBy': patientTriagedBy,
      'patientTriagedAt': patientTriagedAt,
    };
  }
}