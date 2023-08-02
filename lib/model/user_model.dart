class UserModel {
  String? uid;
  String? email;
  String? name;
  String? userType;
  String? phoneNumber;
  String? refNumber;


  UserModel({this.uid, this.email, this.name, this.userType, this.phoneNumber, this.refNumber});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      userType: map['userType'],
      refNumber: map['refNumber'],
      phoneNumber: map['phoneNumber'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'userType': userType,
      'refNumber': refNumber,
      'phoneNumber': phoneNumber,
    };
  }
}