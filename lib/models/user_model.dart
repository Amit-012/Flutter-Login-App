class UserModel {
  final String fullName;
  final String phoneNo;
  final String email;
  final String password;

  UserModel(this.fullName, this.phoneNo, this.email, this.password);

  toJson() {
    return {
      "FullName": fullName,
      "Phone": phoneNo,
      "Email": email,
      "Password": password,
    };
  }
}
