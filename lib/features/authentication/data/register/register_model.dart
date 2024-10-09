import 'package:commuter/core/shared/model/base_response_model.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationModel extends BaseResponseModel<RegisterUser> {
  const RegistrationModel({
    required super.status,
    required super.message,
    super.token,
    super.body,
  });

  factory RegistrationModel.fromJson(Map<String, dynamic> json) {
    return RegistrationModel(
      status: json['status'],
      message: json['message'],
      token: json['token'],
      body: RegisterUser.fromJson(json['user']),
    );
  }
}

class RegisterUser extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String whatsappNumber;
  final String anotherNumber;
  final String email;
  final String nationalIdFrontImage;
  final String nationalIdBackImage;
  final String licenseFrontImage;
  final String licenseBackImage;
  final String address;
  final String birthCertificate;
  final String feshTshbeeh;
  final String? graduationCertificateImage;
  final String? militaryCertificateImage;
  final String? walletNumber;
  final String? bankAccountNumber;
  final String? expirationLicenseDate;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RegisterUser({
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
    this.graduationCertificateImage,
    this.militaryCertificateImage,
    this.walletNumber,
    this.bankAccountNumber,
    this.expirationLicenseDate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    whatsappNumber,
    anotherNumber,
    email,
    nationalIdFrontImage,
    nationalIdBackImage,
    licenseFrontImage,
    licenseBackImage,
    address,
    birthCertificate,
    feshTshbeeh,
    graduationCertificateImage,
    militaryCertificateImage,
    walletNumber,
    bankAccountNumber,
    expirationLicenseDate,
    status,
    createdAt,
    updatedAt,
  ];

  factory RegisterUser.fromJson(Map<String, dynamic> json) {
    return RegisterUser(
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
      graduationCertificateImage: json['graduation_certificate_image'],
      militaryCertificateImage: json['military_certificate_image'],
      walletNumber: json['wallet_number'],
      bankAccountNumber: json['bank_account_number'],
      expirationLicenseDate: json['expiration_license_date'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

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
      'graduation_certificate_image': graduationCertificateImage,
      'military_certificate_image': militaryCertificateImage,
      'wallet_number': walletNumber,
      'bank_account_number': bankAccountNumber,
      'expiration_license_date': expirationLicenseDate,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
