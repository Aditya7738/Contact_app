class SignupModel {
  final String name, phone, email, password, dob;

  const SignupModel(
      {required this.name,
      required this.phone,
      required this.email,
      required this.dob,
      required this.password});

  factory SignupModel.fromJSON(Map<String, dynamic> json) {
    return SignupModel(
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        dob: json["dob"],
        password: json["password"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "phone": phone,
      "email": email,
      "dob": dob,
      "password": password
    };
  }
}
