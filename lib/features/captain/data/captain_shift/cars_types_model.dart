import 'package:commuter/core/shared/model/base_response_model.dart';
import 'package:equatable/equatable.dart';

class GetAllCarTypesModel extends BaseResponseModel<List<CarTypesModel>> {
  const GetAllCarTypesModel({
    required super.status,
    required super.message,
    super.body,
  });

  factory GetAllCarTypesModel.fromJson(Map<String, dynamic> json) {
    return GetAllCarTypesModel(
      status: json['status'],
      message: json['message'],
      body: List<CarTypesModel>.from(
          json['car_types'].map((e) => CarTypesModel.fromJson(e))).toList(),
    );
  }
}

class CarTypesModel extends Equatable {
  final int userId;
  final String firstName;
  final String lastName;
  final String whatsappNumber;
  final int carTypeId;
  final String carType;
  final String carMake;
  final String carModel;

  const CarTypesModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.whatsappNumber,
    required this.carTypeId,
    required this.carType,
    required this.carMake,
    required this.carModel,
  });

  // Convert JSON to model instance
  factory CarTypesModel.fromJson(Map<String, dynamic> json) {
    return CarTypesModel(
      userId: json['user_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      whatsappNumber: json['whatsapp_number'],
      carTypeId: json['car_type_id'],
      carType: json['car_type'],
      carMake: json['car_make'],
      carModel: json['car_model'],
    );
  }

  // Convert model instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'first_name': firstName,
      'last_name': lastName,
      'whatsapp_number': whatsappNumber,
      'car_type_id': carTypeId,
      'car_type': carType,
      'car_make': carMake,
      'car_model': carModel,
    };
  }

  @override
  List<Object?> get props => [
        userId,
        firstName,
        lastName,
        whatsappNumber,
        carTypeId,
        carType,
        carMake,
        carModel,
      ];
}
