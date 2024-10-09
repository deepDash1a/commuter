import 'package:commuter/core/shared/model/base_response_model.dart';
import 'package:equatable/equatable.dart';

class ReportFilterModel extends BaseResponseModel<Report> {
  const ReportFilterModel({
    required super.status,
    required super.message,
    super.body,
  });

  factory ReportFilterModel.fromJson(Map<String, dynamic> json) {
    return ReportFilterModel(
      status: json['status'],
      message: json['message'],
      body: Report.fromJson(json['report']),
    );
  }
}

class Report extends Equatable {
  final String numberOfTrips;
  final String totalRevenues;
  final String totalWorkHours;
  final String totalExpenses;
  final String totalKilometers;
  final String totalSupplies;
  final String averageTripCost;
  final String averageHourCost;
  final String averageDailyRevenue;
  final String captainCovenant;
  final String totalExpensesFuel;
  final String totalExpensesTypeAdditional;
  final String totalEmergencyExpenses;
  final String totalSalary;
  final String totalProfit;
  final String averageTripDistance;
  final String averageValueOfKilometers;
  final String averageDailyExpenses;
  final String totalSuppliesCost;
  final String averageDailySalary;
  final String averageDailyProfit;

  const Report({
    required this.numberOfTrips,
    required this.totalRevenues,
    required this.totalWorkHours,
    required this.totalExpenses,
    required this.totalKilometers,
    required this.totalSupplies,
    required this.averageTripCost,
    required this.averageHourCost,
    required this.averageDailyRevenue,
    required this.captainCovenant,
    required this.totalExpensesFuel,
    required this.totalExpensesTypeAdditional,
    required this.totalEmergencyExpenses,
    required this.totalSalary,
    required this.totalProfit,
    required this.averageTripDistance,
    required this.averageValueOfKilometers,
    required this.averageDailyExpenses,
    required this.totalSuppliesCost,
    required this.averageDailySalary,
    required this.averageDailyProfit,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      numberOfTrips: json['number_of_trips'],
      totalRevenues: json['total_revenues'],
      totalWorkHours: json['total_work_hours'],
      totalExpenses: json['total_expenses'],
      totalKilometers: json['total_kilometers'],
      totalSupplies: json['total_supplies'],
      averageTripCost: json['average_trip_cost'],
      averageHourCost: json['average_hour_cost'],
      averageDailyRevenue: json['average_daily_revenue'],
      captainCovenant: json['captain_covenant'],
      totalExpensesFuel: json['total_expenses_fuel'],
      totalExpensesTypeAdditional: json['total_expenses_type_additional'],
      totalEmergencyExpenses: json['total_emergency_expenses'],
      totalSalary: json['total_salary'],
      totalProfit: json['total_profit'],
      averageTripDistance: json['average_trip_distance'],
      averageValueOfKilometers: json['average_value_of_kilometers'],
      averageDailyExpenses: json['average_daily_expenses'],
      totalSuppliesCost: json['total_supplies_cost'],
      averageDailySalary: json['average_daily_salary'],
      averageDailyProfit: json['average_daily_profit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number_of_trips': numberOfTrips,
      'total_revenues': totalRevenues,
      'total_work_hours': totalWorkHours,
      'total_expenses': totalExpenses,
      'total_kilometers': totalKilometers,
      'total_supplies': totalSupplies,
      'average_trip_cost': averageTripCost,
      'average_hour_cost': averageHourCost,
      'average_daily_revenue': averageDailyRevenue,
      'captain_covenant': captainCovenant,
      'total_expenses_fuel': totalExpensesFuel,
      'total_expenses_type_additional': totalExpensesTypeAdditional,
      'total_emergency_expenses': totalEmergencyExpenses,
      'total_salary': totalSalary,
      'total_profit': totalProfit,
      'average_trip_distance': averageTripDistance,
      'average_value_of_kilometers': averageValueOfKilometers,
      'average_daily_expenses': averageDailyExpenses,
      'total_supplies_cost': totalSuppliesCost,
      'average_daily_salary': averageDailySalary,
      'average_daily_profit': averageDailyProfit,
    };
  }

  @override
  List<Object?> get props => [
        numberOfTrips,
        totalRevenues,
        totalWorkHours,
        totalExpenses,
        totalKilometers,
        totalSupplies,
        averageTripCost,
        averageHourCost,
        averageDailyRevenue,
        captainCovenant,
        totalExpensesFuel,
        totalExpensesTypeAdditional,
        totalEmergencyExpenses,
        totalSalary,
        totalProfit,
        averageTripDistance,
        averageValueOfKilometers,
        averageDailyExpenses,
        totalSuppliesCost,
        averageDailySalary,
        averageDailyProfit,
      ];
}
