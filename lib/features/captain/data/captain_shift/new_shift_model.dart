import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class NewShiftModel extends Equatable {
  String? status;
  String? message;
  String? shiftCarType;
  int? shiftOdometerReading;
  String? shiftLocation;
  double? shiftLatitude;
  double? shiftLongitude;
  String? shiftStartDate;
  int? shiftUserId;
  String? shiftUpdatedAt;
  String? shiftCreatedAt;
  int? shiftId;

  NewShiftModel({
    this.status,
    this.message,
    this.shiftCarType,
    this.shiftOdometerReading,
    this.shiftLocation,
    this.shiftLatitude,
    this.shiftLongitude,
    this.shiftStartDate,
    this.shiftUserId,
    this.shiftUpdatedAt,
    this.shiftCreatedAt,
    this.shiftId,
  });

  factory NewShiftModel.fromJson(Map<String, dynamic> json) {
    return NewShiftModel(
      status: json['status'],
      message: json['message'],
      shiftCarType: json['shift']['shift'],
      shiftOdometerReading:
          int.parse(json['shift']['odometer_reading'].toString()),
      shiftLocation: json['shift']['location'],
      shiftLatitude:double.parse(json['shift']['latitude'].toString()),
      shiftLongitude:double.parse( json['shift']['longitude'].toString()),
      shiftStartDate: json['shift']['start_date'],
      shiftUserId: json['shift']['user_id'],
      shiftUpdatedAt: json['shift']['updated_at'],
      shiftCreatedAt: json['shift']['created_at'],
      shiftId: json['shift']['id'],
    );
  }

  @override
  List<Object?> get props => [
        status,
        message,
        shiftCarType,
        shiftOdometerReading,
        shiftLocation,
        shiftLatitude,
        shiftLongitude,
        shiftStartDate,
        shiftUserId,
        shiftUpdatedAt,
        shiftCreatedAt,
        shiftId,
      ];
}
