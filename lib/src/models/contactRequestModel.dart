class ContactRequestModel {
  final String firstName, lastName, phone, email;
  final String? id, address;

  const ContactRequestModel(
      {this.id,
      required this.firstName,
      required this.lastName,
      required this.phone,
      required this.address,
      required this.email});

  factory ContactRequestModel.fromJson(Map<String, dynamic> json) {
    return ContactRequestModel(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      phone: json["phone"],
      address: json["address"],
      email: json["email"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "phone": phone,
      "address": address,
      "email": email,
    };
  }

//
}
