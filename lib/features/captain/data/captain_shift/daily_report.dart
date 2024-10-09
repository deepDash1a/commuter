import 'package:commuter/core/shared/model/base_response_model.dart';
import 'package:equatable/equatable.dart';

class GetDailyReportModel extends BaseResponseModel<List<DailyReportModel>?> {
  const GetDailyReportModel({
    required super.status,
    required super.message,
    super.body,
  });

  factory GetDailyReportModel.fromJson(Map<String, dynamic> json) {
    return GetDailyReportModel(
      status: json['status'],
      message: json['message'],
      body: List<DailyReportModel>.from(
              json['daily_reports']?.map((e) => DailyReportModel.fromJson(e)) ??
                  [])
          .toList(),
    );
  }
}

class GetAllDailyReportModel
    extends BaseResponseModel<List<DailyReportModel>?> {
  const GetAllDailyReportModel({
    required super.status,
    required super.message,
    super.body,
  });

  factory GetAllDailyReportModel.fromJson(Map<String, dynamic> json) {
    return GetAllDailyReportModel(
      status: json['status'],
      message: json['message'],
      body: List<DailyReportModel>.from(
              json['all_reports']?.map((e) => DailyReportModel.fromJson(e)) ??
                  [])
          .toList(),
    );
  }
}

class DailyReportModel extends Equatable {
  final String startDate;
  final int id;
  final String firstName;
  final String lastName;
  final int carTypeId;
  final String carType;
  final String carMake;
  final String carModel;
  final int shiftId;
  final int userId;
  final String workHours;
  final dynamic calculatedKilometers;
  final String numTripsApps;
  final String totalFinancialValueApplication;
  final String numTripsExternal;
  final String totalFinancialValueTripsExternal;
  final int numCourseNumber;
  final String totalFinancialValueCourses;
  final String totalRevenue;
  final String totalExpensesChargeTrips;
  final String totalExpensesFuel;
  final String totalExpensesTypeAdditional;
  final String totalEmergencyExpenses;
  final String balanceFinancialValueTripsExternal;
  final String totalExpense;
  final String covenant;
  final String totalPriceSuppliers;
  final String fine;
  final String totalPriceFine;
  final String poundPerHour;
  final String poundPerTrip;
  final String poundPerKilometer;
  final String totalCovenant;
  final String totalMonthlyRevenue;
  final String totalMonthlyExpenses;
  final String totalMonthlySuppliers;

  const DailyReportModel({
    required this.startDate,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.carTypeId,
    required this.carType,
    required this.carMake,
    required this.carModel,
    required this.shiftId,
    required this.userId,
    required this.workHours,
    this.calculatedKilometers,
    required this.numTripsApps,
    required this.totalFinancialValueApplication,
    required this.numTripsExternal,
    required this.totalFinancialValueTripsExternal,
    required this.numCourseNumber,
    required this.totalFinancialValueCourses,
    required this.totalRevenue,
    required this.totalExpensesChargeTrips,
    required this.totalExpensesFuel,
    required this.totalExpensesTypeAdditional,
    required this.totalEmergencyExpenses,
    required this.balanceFinancialValueTripsExternal,
    required this.totalExpense,
    required this.covenant,
    required this.totalPriceSuppliers,
    required this.fine,
    required this.totalPriceFine,
    required this.poundPerHour,
    required this.poundPerTrip,
    required this.poundPerKilometer,
    required this.totalCovenant,
    required this.totalMonthlyRevenue,
    required this.totalMonthlyExpenses,
    required this.totalMonthlySuppliers,
  });

  // Factory method to create an instance from JSON
  factory DailyReportModel.fromJson(Map<String, dynamic> json) {
    return DailyReportModel(
      startDate: json['start_date'],
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      carTypeId: json['car_type_id'],
      carType: json['car_type'],
      carMake: json['car_make'],
      carModel: json['car_model'],
      shiftId: json['shift_id'],
      userId: json['user_id'],
      workHours: json['work_hours'],
      calculatedKilometers: json['calculated_kilometers'],
      numTripsApps: json['num_trips_apps'],
      totalFinancialValueApplication: json['total_financial_value_application'],
      numTripsExternal: json['num_trips_external'],
      totalFinancialValueTripsExternal:
          json['total_financial_value_trips_external'],
      numCourseNumber: json['num_course_number'],
      totalFinancialValueCourses: json['total_financial_value_courses'],
      totalRevenue: json['total_revenue'],
      totalExpensesChargeTrips: json['total_expenses_charge_trips'],
      totalExpensesFuel: json['total_expenses_fuel'],
      totalExpensesTypeAdditional: json['total_expenses_type_additional'],
      totalEmergencyExpenses: json['total_emergency_expenses'],
      balanceFinancialValueTripsExternal:
          json['balance_financial_value_trips_external'],
      totalExpense: json['total_expense'],
      covenant: json['covenant'],
      totalPriceSuppliers: json['total_price_suppliers'],
      fine: json['fine'],
      totalPriceFine: json['total_price_fine'],
      poundPerHour: json['pound_per_hour'],
      poundPerTrip: json['pound_per_trip'],
      poundPerKilometer: json['pound_per_kilometer'],
      totalCovenant: json['total_covenant'].toString(),
      totalMonthlyRevenue: json['total_monthly_revenue'].toString(),
      totalMonthlyExpenses: json['total_monthly_expenses'].toString(),
      totalMonthlySuppliers: json['total_monthly_suppliers'].toString(),
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'start_date': startDate,
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'car_type_id': carTypeId,
      'car_type': carType,
      'car_make': carMake,
      'car_model': carModel,
      'shift_id': shiftId,
      'user_id': userId,
      'work_hours': workHours,
      'calculated_kilometers': calculatedKilometers,
      'num_trips_apps': numTripsApps,
      'total_financial_value_application': totalFinancialValueApplication,
      'num_trips_external': numTripsExternal,
      'total_financial_value_trips_external': totalFinancialValueTripsExternal,
      'num_course_number': numCourseNumber,
      'total_financial_value_courses': totalFinancialValueCourses,
      'total_revenue': totalRevenue,
      'total_expenses_charge_trips': totalExpensesChargeTrips,
      'total_expenses_fuel': totalExpensesFuel,
      'total_expenses_type_additional': totalExpensesTypeAdditional,
      'total_emergency_expenses': totalEmergencyExpenses,
      'balance_financial_value_trips_external':
          balanceFinancialValueTripsExternal,
      'total_expense': totalExpense,
      'covenant': covenant,
      'total_price_suppliers': totalPriceSuppliers,
      'fine': fine,
      'total_price_fine': totalPriceFine,
      'pound_per_hour': poundPerHour,
      'pound_per_trip': poundPerTrip,
      'pound_per_kilometer': poundPerKilometer,
      'total_covenant': totalCovenant,
      'total_monthly_revenue': totalMonthlyRevenue,
      'total_monthly_expenses': totalMonthlyExpenses,
      'total_monthly_suppliers': totalMonthlySuppliers,
    };
  }

  @override
  List<Object?> get props => [
        startDate,
        id,
        firstName,
        lastName,
        carTypeId,
        carType,
        carMake,
        carModel,
        shiftId,
        userId,
        workHours,
        calculatedKilometers,
        numTripsApps,
        totalFinancialValueApplication,
        numTripsExternal,
        totalFinancialValueTripsExternal,
        numCourseNumber,
        totalFinancialValueCourses,
        totalRevenue,
        totalExpensesChargeTrips,
        totalExpensesFuel,
        totalExpensesTypeAdditional,
        totalEmergencyExpenses,
        balanceFinancialValueTripsExternal,
        totalExpense,
        covenant,
        totalPriceSuppliers,
        fine,
        totalPriceFine,
        poundPerHour,
        poundPerTrip,
        poundPerKilometer,
        totalCovenant,
        totalMonthlyRevenue,
        totalMonthlyExpenses,
        totalMonthlySuppliers,
      ];
}
