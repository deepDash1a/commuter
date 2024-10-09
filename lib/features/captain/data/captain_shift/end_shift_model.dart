import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class EndShiftModel extends Equatable {
  String? status;
  String? message;
  int? shiftId;
  int? shiftUserId;
  String? shiftCarType;
  int? shiftOdometerReading;
  String? shiftImageOdometerReading;
  String? shiftStartDate;
  String? shiftBreakDate;
  String? shiftResumeDate;
  String? shiftEndDate;
  String? shiftWorkHours;
  String? shiftCurrentStatus;
  String? shiftLocation;
  double? shiftLatitude;
  double? shiftLongitude;
  int? shiftEndOdometerReading;
  Null shiftEndImageOdometerReading;
  String? shiftCreatedAt;
  String? shiftUpdatedAt;

  EndShiftModel({
    this.status,
    this.message,
    this.shiftId,
    this.shiftUserId,
    this.shiftCarType,
    this.shiftOdometerReading,
    this.shiftImageOdometerReading,
    this.shiftStartDate,
    this.shiftBreakDate,
    this.shiftResumeDate,
    this.shiftEndDate,
    this.shiftWorkHours,
    this.shiftCurrentStatus,
    this.shiftLocation,
    this.shiftLatitude,
    this.shiftLongitude,
    this.shiftEndOdometerReading,
    this.shiftEndImageOdometerReading,
    this.shiftCreatedAt,
    this.shiftUpdatedAt,
  });

  factory EndShiftModel.fromJson(Map<String, dynamic> json) {
    return EndShiftModel(
      status: json['status'],
      message: json['message'],
      shiftId: json['shift']['id'],
      shiftUserId: json['shift']['user_id'],
      shiftCarType: json['shift']['car_type'],
      shiftOdometerReading: json['shift']['odometer_reading'],
      shiftImageOdometerReading: json['shift']['image_odometer_reading'],
      shiftStartDate: json['shift']['start_date'],
      shiftBreakDate: json['shift']['break_date'],
      shiftResumeDate: json['shift']['resume_date'],
      shiftEndDate: json['shift']['end_date'],
      shiftWorkHours: json['shift']['work_hours'],
      shiftCurrentStatus: json['shift']['current_status'],
      shiftLocation: json['shift']['location'],
      shiftLatitude: json['shift']['latitude'],
      shiftLongitude: json['shift']['longitude'],
      shiftEndOdometerReading: int.parse(json['shift']['end_odometer_reading']),
      shiftEndImageOdometerReading: json['shift']['end_image_odometer_reading'],
      shiftCreatedAt: json['shift']['created_at'],
      shiftUpdatedAt: json['shift']['updated_at'],
    );
  }

  @override
  List<Object?> get props => [
        status,
        message,
        shiftId,
        shiftUserId,
        shiftCarType,
        shiftOdometerReading,
        shiftImageOdometerReading,
        shiftStartDate,
        shiftBreakDate,
        shiftResumeDate,
        shiftEndDate,
        shiftWorkHours,
        shiftCurrentStatus,
        shiftLocation,
        shiftLatitude,
        shiftLongitude,
        shiftEndOdometerReading,
        shiftEndImageOdometerReading,
        shiftCreatedAt,
        shiftUpdatedAt,
      ];
}
