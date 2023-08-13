class TriageFormDoctorModel {
  String? patientId;
  String? triageFormNurseId;
  String? patientNumber;
  String? uid;
  String? patientVaginalBleeding;
  String? patientBlurringVision;
  String? patientEpigastricPain;
  String? patientDrainingOfLiquor;
  String? patientSwellingOfLegs;
  String? patientVomiting;
  String? patientFever;
  String? patientHeadache;
  String? patientStartOfLabour;
  String? patientPresentingComplaints;
  String? patientDisabilityLevel;
  String? patientEyesObservation;
  String? patientSkinObservation;
  String? patientHairObservation;
  String? patientNailsObservation;
  String? patientAbdomenObservation;
  String? patientPalpation;
  String? patientAuscultation;
  String? patientHyperHypoResonance;
  String? patientOtherPresentingComplaints;
  String? patientVaginaObservation;
  String? patientSignsOfPregnancy;
  String? patientFetalExam;
  String? patientExaminedBy;
  String? patientExaminedAt;

  TriageFormNurseModel({
    this.patientId,
    this.triageFormNurseId,
    this.patientNumber,
    this.uid,
    this.patientVaginalBleeding,
    this.patientBlurringVision,
    this.patientEpigastricPain,
    this.patientDrainingOfLiquor,
    this.patientSwellingOfLegs,
    this.patientVomiting,
    this.patientFever,
    this.patientHeadache,
    this.patientStartOfLabour,
    this.patientPresentingComplaints,
    this.patientDisabilityLevel,
    this.patientEyesObservation,
    this.patientSkinObservation,
    this.patientHairObservation,
    this.patientNailsObservation,
    this.patientAbdomenObservation,
    this.patientPalpation,
    this.patientAuscultation,
    this.patientHyperHypoResonance,
    this.patientOtherPresentingComplaints,
    this.patientVaginaObservation,
    this.patientSignsOfPregnancy,
    this.patientFetalExam,
    this.patientExaminedBy,
    this.patientExaminedAt,
  });

  // receiving data from server
  factory TriageFormDoctorModel.fromMap(map) {
    return TriageFormDoctorModel(
      patientId: map['patientId'],
      triageFormNurseId: map['triageFormNurseId'],
      patientNumber: map['patientNumber'],
      uid: map['uid'],
      patientVaginalBleeding: map['patientVaginalBleeding'],
      patientBlurringVision: map['patientBlurringVision'],
      patientEpigastricPain: map['patientEpigastricPain'],
      patientDrainingOfLiquor: map['patientDrainingOfLiquor'],
      patientSwellingOfLegs: map['patientSwellingOfLegs'],
      patientVomiting: map['patientVomiting'],
      patientFever: map['patientFever'],
      patientHeadache: map['patientHeadache'],
      patientStartOfLabour: map['patientStartOfLabour'],
      patientPresentingComplaints: map['patientPresentingComplaints'],
      patientDisabilityLevel: map['patientDisabilityLevel'],
      patientEyesObservation: map['patientEyesObservation'],
      patientSkinObservation: map['patientSkinObservation'],
      patientHairObservation: map['patientHairObservation'],
      patientNailsObservation: map['patientNailsObservation'],
      patientAbdomenObservation: map['patientAbdomenObservation'],
      patientPalpation: map['patientPalpation'],
      patientAuscultation: map['patientAuscultation'],
      patientHyperHypoResonance: map['patientHyperHypoResonance'],
      patientOtherPresentingComplaints: map['patientOtherPresentingComplaints'],
      patientVaginaObservation: map['patientVaginaObservation'],
      patientSignsOfPregnancy: map['patientSignsOfPregnancy'],
      patientFetalExam: map['patientFetalExam'],
      patientExaminedBy: map['patientExaminedBy'],
      patientExaminedAt: map['patientExaminedAt'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'patientId': patientId,
      'patientNumber': patientNumber,
      'uid': uid,
      'triageFormNurseId': triageFormNurseId,
      'patientVaginalBleeding': patientVaginalBleeding,
      'patientBlurringVision': patientBlurringVision,
      'patientEpigastricPain': patientEpigastricPain,
      'patientDrainingOfLiquor': patientDrainingOfLiquor,
      'patientSwellingOfLegs': patientSwellingOfLegs,
      'patientVomiting': patientVomiting,
      'patientFever': patientFever,
      'patientHeadache': patientHeadache,
      'patientStartOfLabour': patientStartOfLabour,
      'patientPresentingComplaints': patientPresentingComplaints,
      'patientDisabilityLevel': patientDisabilityLevel,
      'patientEyesObservation': patientEyesObservation,
      'patientNailsObservation': patientNailsObservation,
      'patientSkinObservation': patientSkinObservation,
      'patientHairObservation': patientHairObservation,
      'patientAbdomenObservation': patientAbdomenObservation,
      'patientPalpation': patientPalpation,
      'patientAuscultation': patientAuscultation,
      'patientHyperHypoResonance': patientHyperHypoResonance,
      'patientOtherPresentingComplaints': patientOtherPresentingComplaints,
      'patientVaginaObservation': patientVaginaObservation,
      'patientSignsOfPregnancy': patientSignsOfPregnancy,
      'patientFetalExam': patientFetalExam,
      'patientExaminedBy': patientExaminedBy,
      'patientExaminedAt': patientExaminedAt,
    };
  }
}
