import 'package:commuter/core/shared/model/base_response_model.dart';

class LoginModel extends BaseResponseModel<LoginUser> {
  const LoginModel({
    required super.status,
    required super.message,
    super.token,
    super.body,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'],
      message: json['message'],
      token: json['token'],
      body: LoginUser.fromJson(json['user']),
    );
  }
}

class LoginUser {
  int id;
  String firstName;
  String lastName;
  String whatsappNumber;
  String anotherNumber;
  String email;
  String nationalIdFrontImage;
  String nationalIdBackImage;
  String licenseFrontImage;
  String licenseBackImage;
  String address;
  String birthCertificate;
  String feshTshbeeh;
  String? emailVerifiedAt;
  String? profileImage;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  LoginUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.whatsappNumber,
    required this.anotherNumber,
    required this.email,
    required this.nationalIdFrontImage,
    required this.nationalIdBackImage,
    required this.licenseFrontImage,
    required this.licenseBackImage,
    required this.address,
    required this.birthCertificate,
    required this.feshTshbeeh,
    this.emailVerifiedAt,
    this.profileImage,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create an instance from JSON
  factory LoginUser.fromJson(Map<String, dynamic> json) {
    return LoginUser(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      whatsappNumber: json['whatsapp_number'],
      anotherNumber: json['another_number'],
      email: json['email'],
      nationalIdFrontImage: json['national_id_front_image'],
      nationalIdBackImage: json['national_id_back_image'],
      licenseFrontImage: json['license_front_image'],
      licenseBackImage: json['license_back_image'],
      address: json['address'],
      birthCertificate: json['birth_certificate'],
      feshTshbeeh: json['fesh_tshbeeh'],
      emailVerifiedAt: json['email_verified_at'],
      profileImage: json['ProfileImage'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'whatsapp_number': whatsappNumber,
      'another_number': anotherNumber,
      'email': email,
      'national_id_front_image': nationalIdFrontImage,
      'national_id_back_image': nationalIdBackImage,
      'license_front_image': licenseFrontImage,
      'license_back_image': licenseBackImage,
      'address': address,
      'birth_certificate': birthCertificate,
      'fesh_tshbeeh': feshTshbeeh,
      'email_verified_at': emailVerifiedAt,
      'ProfileImage': profileImage,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
