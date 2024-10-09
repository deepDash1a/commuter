import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ControlShiftTimeModel extends Equatable {
  String? status;
  String? message;
  int? id;
  String? workHours;
  String? currentStatus;

  ControlShiftTimeModel({
    this.status,
    this.message,
    this.id,
    this.workHours,
    this.currentStatus,
  });

  factory ControlShiftTimeModel.fromJson(Map<String, dynamic> json) {
    return ControlShiftTimeModel(
      status: json['status'],
      message: json['message'],
      id: json['shift']['id'],
      workHours: json['shift']['work_hours'],
      currentStatus: json['shift']['current_status'],
    );
  }

  @override
  List<Object?> get props => [
        status,
        message,
        id,
        workHours,
        currentStatus,
      ];
}
