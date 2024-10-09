import 'package:commuter/core/shared/model/base_response_model.dart';
import 'package:equatable/equatable.dart';

class GetAllRevenueCourseModel
    extends BaseResponseModel<List<RevenueCourseModel>> {
  const GetAllRevenueCourseModel({
    required super.status,
    required super.message,
    super.body,
  });

  factory GetAllRevenueCourseModel.fromJson(Map<String, dynamic> json) {
    return GetAllRevenueCourseModel(
      status: json['status'],
      message: json['message'],
      body: List<RevenueCourseModel>.from(json['revenue_courses']
          .map((e) => RevenueCourseModel.fromJson(e))).toList(),
    );
  }
}

class RevenueCourseModel extends Equatable {
  final int? id;
  final String? courseNumber;
  final String? tripType;
  final int? cashPayment;
  final String? financialValueCourses;
  final String? createdAt;
  final String? updatedAt;
  final int? shiftId;

  const RevenueCourseModel({
    this.id,
    this.courseNumber,
    this.tripType,
    this.cashPayment,
    this.financialValueCourses,
    this.createdAt,
    this.updatedAt,
    this.shiftId,
  });

  // fromJson factory method
  factory RevenueCourseModel.fromJson(Map<String, dynamic> json) {
    return RevenueCourseModel(
      id: json['id'] as int?,
      courseNumber: json['course_number'].toString(),
      tripType: json['trip_type'].toString(),
      cashPayment: json['cash_payment'] as int?,
      financialValueCourses: json['financial_value_courses'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      shiftId: json['shift_id'] as int?,
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'course_number': courseNumber,
      'trip_type': tripType,
      'cash_payment': cashPayment,
      'financial_value_courses': financialValueCourses,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'shift_id': shiftId,
    };
  }

  @override
  List<Object?> get props => [
        id,
        courseNumber,
        tripType,
        cashPayment,
        financialValueCourses,
        createdAt,
        updatedAt,
        shiftId,
      ];
}
