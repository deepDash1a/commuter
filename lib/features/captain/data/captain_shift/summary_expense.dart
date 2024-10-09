import 'package:equatable/equatable.dart';

class SummaryExpensesModel extends Equatable {
  final String status;
  final SummaryExpenses summaryExpenses;
  final ExpenseDetails details;

  const SummaryExpensesModel({
    required this.status,
    required this.summaryExpenses,
    required this.details,
  });

  // Factory method to create an instance from JSON
  factory SummaryExpensesModel.fromJson(Map<String, dynamic> json) {
    return SummaryExpensesModel(
      status: json['status'] as String,
      summaryExpenses: SummaryExpenses.fromJson(json['summary_expenses']),
      details: ExpenseDetails.fromJson(json['details']),
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'summary_expenses': summaryExpenses.toJson(),
      'details': details.toJson(),
    };
  }

  @override
  List<Object?> get props => [status, summaryExpenses, details];
}

class SummaryExpenses extends Equatable {
  final String startDate;
  final int id;
  final String name;
  final int shiftId;
  final int userId;
  final String workHours;
  final int carTypesId;
  final dynamic kilometers; // nullable
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
  final String totalExpense;
  final String totalPriceSuppliers;
  final String cashFloat;
  final String hourCash;
  final dynamic hourTrip; // nullable
  final dynamic hourKm; // nullable

  const SummaryExpenses({
    required this.startDate,
    required this.id,
    required this.name,
    required this.shiftId,
    required this.userId,
    required this.workHours,
    required this.carTypesId,
    this.kilometers,
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
    required this.totalExpense,
    required this.totalPriceSuppliers,
    required this.cashFloat,
    required this.hourCash,
    this.hourTrip,
    this.hourKm,
  });

  // Factory method to create an instance from JSON
  factory SummaryExpenses.fromJson(Map<String, dynamic> json) {
    return SummaryExpenses(
      startDate: json['start_date'] as String,
      id: json['id'] as int,
      name: json['name'] as String,
      shiftId: json['shift_id'] as int,
      userId: json['user_id'] as int,
      workHours: json['work_hours'] as String,
      carTypesId: json['car_types_id'] as int,
      kilometers: json['kilometers'],
      numTripsApps: json['num_trips_apps'] as String,
      totalFinancialValueApplication:
      json['total_financial_value_application'] as String,
      numTripsExternal: json['num_trips_external'] as String,
      totalFinancialValueTripsExternal:
      json['total_financial_value_trips_external'] as String,
      numCourseNumber: json['num_course_number'] as int,
      totalFinancialValueCourses: json['total_financial_value_courses'] as String,
      totalRevenue: json['total_revenue'] as String,
      totalExpensesChargeTrips: json['total_expenses_charge_trips'] as String,
      totalExpensesFuel: json['total_expenses_fuel'] as String,
      totalExpensesTypeAdditional:
      json['total_expenses_type_additional'] as String,
      totalExpense: json['total_expense'] as String,
      totalPriceSuppliers: json['total_price_suppliers'] as String,
      cashFloat: json['cash_float'] as String,
      hourCash: json['hour_cash'] as String,
      hourTrip: json['hour_trip'],
      hourKm: json['hour_km'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'start_date': startDate,
      'id': id,
      'name': name,
      'shift_id': shiftId,
      'user_id': userId,
      'work_hours': workHours,
      'car_types_id': carTypesId,
      'kilometers': kilometers,
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
      'total_expense': totalExpense,
      'total_price_suppliers': totalPriceSuppliers,
      'cash_float': cashFloat,
      'hour_cash': hourCash,
      'hour_trip': hourTrip,
      'hour_km': hourKm,
    };
  }

  @override
  List<Object?> get props => [
    startDate,
    id,
    name,
    shiftId,
    userId,
    workHours,
    carTypesId,
    kilometers,
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
    totalExpense,
    totalPriceSuppliers,
    cashFloat,
    hourCash,
    hourTrip,
    hourKm,
  ];
}

class ExpenseDetails extends Equatable {
  final List<dynamic> charge;
  final List<dynamic> fuel;
  final List<dynamic> additional;

  const ExpenseDetails({
    required this.charge,
    required this.fuel,
    required this.additional,
  });

  // Factory method to create an instance from JSON
  factory ExpenseDetails.fromJson(Map<String, dynamic> json) {
    return ExpenseDetails(
      charge: List<dynamic>.from(json['charge'] ?? []),
      fuel: List<dynamic>.from(json['fuel'] ?? []),
      additional: List<dynamic>.from(json['additional'] ?? []),
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'charge': charge,
      'fuel': fuel,
      'additional': additional,
    };
  }

  @override
  List<Object?> get props => [charge, fuel, additional];
}
