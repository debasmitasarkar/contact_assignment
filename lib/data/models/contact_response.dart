// To parse this JSON data, do
//
//     final contactResponse = contactResponseFromJson(jsonString);

import 'dart:convert';

ContactResponse contactResponseFromJson(String str) =>
    ContactResponse.fromJson(json.decode(str));

String contactResponseToJson(ContactResponse data) =>
    json.encode(data.toJson());

class ContactResponse {
  ContactResponse({
    required this.status,
    required this.count,
    required this.next,
    required this.prev,
    required this.pageNum,
    required this.data,
  });

  int status;
  int count;
  bool next;
  bool prev;
  int pageNum;
  List<Contact> data;

  factory ContactResponse.fromJson(Map<String, dynamic> json) =>
      ContactResponse(
        status: json["status"],
        count: json["count"],
        next: json["next"],
        prev: json["prev"],
        pageNum: json["page_num"],
        data: List<Contact>.from(json["data"].map((x) => Contact.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "count": count,
        "next": next,
        "prev": prev,
        "page_num": pageNum,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Contact {
  Contact({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.colorCode,
    required this.phoneNumber,
    required this.image,
  });

  int id;
  String firstName;
  String lastName;
  String email;
  String gender;
  String colorCode;
  String phoneNumber;
  String image;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        gender: json["gender"],
        colorCode: json["color_code"],
        phoneNumber: json["phone_number"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "gender": gender,
        "color_code": colorCode,
        "phone_number": phoneNumber,
        "image": image,
      };
}
