class RegisterModel {
  String email;
  String password;
  String confirmPassword;
  String contactNo;
  String userType;

  RegisterModel({
    this.email,
    this.password,
    this.confirmPassword,
    this.contactNo,
    this.userType,
  });

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      email: map.containsKey('email') ? (map['email'] ?? '') : '',
      password: map.containsKey('password') ? (map['password'] ?? '') : '',
      confirmPassword: map.containsKey('confirmPassword')
          ? (map['confirmPassword'] ?? '')
          : '',
      contactNo: map.containsKey('contactNo') ? (map['contactNo'] ?? '') : '',
      userType: map.containsKey('userType') ? (map['userType'] ?? '') : '',
    );
  }
}
