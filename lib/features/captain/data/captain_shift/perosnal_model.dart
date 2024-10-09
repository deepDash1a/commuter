class PersonalModel {
  User? user;

  PersonalModel({this.user});

  PersonalModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? whatsappNumber;
  String? anotherNumber;
  String? email;
  String? nationalIdFrontImage;
  String? nationalIdBackImage;
  String? licenseFrontImage;
  String? licenseBackImage;
  String? address;
  String? birthCertificate;
  String? feshTshbeeh;
  String? graduationCertificateImage;
  String? militaryCertificateImage;
  String? walletNumber;
  String? bankAccountNumber;
  String? expirationLicenseDate;
  String? emailVerifiedAt;
  String? profileImage;
  String? status;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.firstName,
        this.lastName,
        this.whatsappNumber,
        this.anotherNumber,
        this.email,
        this.nationalIdFrontImage,
        this.nationalIdBackImage,
        this.licenseFrontImage,
        this.licenseBackImage,
        this.address,
        this.birthCertificate,
        this.feshTshbeeh,
        this.graduationCertificateImage,
        this.militaryCertificateImage,
        this.walletNumber,
        this.bankAccountNumber,
        this.expirationLicenseDate,
        this.emailVerifiedAt,
        this.profileImage,
        this.status,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    whatsappNumber = json['whatsapp_number'];
    anotherNumber = json['another_number'];
    email = json['email'];
    nationalIdFrontImage = json['national_id_front_image'];
    nationalIdBackImage = json['national_id_back_image'];
    licenseFrontImage = json['license_front_image'];
    licenseBackImage = json['license_back_image'];
    address = json['address'];
    birthCertificate = json['birth_certificate'];
    feshTshbeeh = json['fesh_tshbeeh'];
    graduationCertificateImage = json['graduation_certificate_image'];
    militaryCertificateImage = json['military_certificate_image'];
    walletNumber = json['wallet_number'];
    bankAccountNumber = json['bank_account_number'];
    expirationLicenseDate = json['expiration_license_date'];
    emailVerifiedAt = json['email_verified_at'];
    profileImage = json['ProfileImage'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['whatsapp_number'] = this.whatsappNumber;
    data['another_number'] = this.anotherNumber;
    data['email'] = this.email;
    data['national_id_front_image'] = this.nationalIdFrontImage;
    data['national_id_back_image'] = this.nationalIdBackImage;
    data['license_front_image'] = this.licenseFrontImage;
    data['license_back_image'] = this.licenseBackImage;
    data['address'] = this.address;
    data['birth_certificate'] = this.birthCertificate;
    data['fesh_tshbeeh'] = this.feshTshbeeh;
    data['graduation_certificate_image'] = this.graduationCertificateImage;
    data['military_certificate_image'] = this.militaryCertificateImage;
    data['wallet_number'] = this.walletNumber;
    data['bank_account_number'] = this.bankAccountNumber;
    data['expiration_license_date'] = this.expirationLicenseDate;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['ProfileImage'] = this.profileImage;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
