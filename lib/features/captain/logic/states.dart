import 'package:commuter/features/captain/data/captain_shift/control_shift_time_model.dart';
import 'package:commuter/features/captain/data/captain_shift/end_shift_model.dart';
import 'package:commuter/features/captain/data/captain_shift/new_shift_model.dart';
import 'package:commuter/features/captain/data/captain_shift/personal_model.dart';
import 'package:commuter/features/captain/data/captain_shift/place_details_model.dart';

abstract class CaptainAppStates {}

class InitializeCaptainAppState extends CaptainAppStates {}

class PleaseValidateCaptainAppState extends CaptainAppStates {}

class ChangeStartProcessAppState extends CaptainAppStates {}

class CheckBreakOrResumeShiftAppState extends CaptainAppStates {}

/// captain dash board
class LoadingUserDataState extends CaptainAppStates {}

class SuccessUserDataState extends CaptainAppStates {}

class ErrorUserDataState extends CaptainAppStates {
  final String error;

  ErrorUserDataState({required this.error});
}

class UploadImageState extends CaptainAppStates {}

/// Captain Dash Board

class LoadingMessagesCaptainAppState extends CaptainAppStates {}

class SuccessMessagesCaptainAppState extends CaptainAppStates {}

class ErrorMessagesCaptainAppState extends CaptainAppStates {
  final String error;

  ErrorMessagesCaptainAppState({required this.error});
}

/// Shift:: New shifts States Section

class LoadingGetAllCarTypesCaptainAppState extends CaptainAppStates {}

class SuccessGetAllCarTypesCaptainAppState extends CaptainAppStates {}

class ErrorGetAllCarTypesCaptainAppState extends CaptainAppStates {
  final String error;

  ErrorGetAllCarTypesCaptainAppState({required this.error});
}

class LoadingStartNewShiftCaptainAppState extends CaptainAppStates {}

class SuccessStartNewShiftCaptainAppState extends CaptainAppStates {
  final NewShiftModel newShiftModel;

  SuccessStartNewShiftCaptainAppState({required this.newShiftModel});
}

class ErrorStartNewShiftCaptainAppState extends CaptainAppStates {
  final String error;

  ErrorStartNewShiftCaptainAppState({required this.error});
}

class LoadingResumeShiftCaptainAppState extends CaptainAppStates {}

class SuccessResumeShiftCaptainAppState extends CaptainAppStates {
  final ControlShiftTimeModel controlShiftTimeModel;

  SuccessResumeShiftCaptainAppState({required this.controlShiftTimeModel});
}

class ErrorResumeShiftCaptainAppState extends CaptainAppStates {
  final String error;

  ErrorResumeShiftCaptainAppState({required this.error});
}

class LoadingBreakShiftCaptainAppState extends CaptainAppStates {}

class SuccessBreakShiftCaptainAppState extends CaptainAppStates {
  final ControlShiftTimeModel controlShiftTimeModel;

  SuccessBreakShiftCaptainAppState({required this.controlShiftTimeModel});
}

class ErrorBreakShiftCaptainAppState extends CaptainAppStates {
  final String error;

  ErrorBreakShiftCaptainAppState({required this.error});
}

/// Shift:: Revenue States Section
class ChangeAddRevenueState extends CaptainAppStates {}

class LoadingAddShiftsRevenueCaptainAppState extends CaptainAppStates {}

class SuccessAddShiftsRevenueCaptainAppState extends CaptainAppStates {}

class ErrorAddShiftsRevenueCaptainAppState extends CaptainAppStates {
  final String error;

  ErrorAddShiftsRevenueCaptainAppState({required this.error});
}

class LoadingShiftsRevenueTripCaptainAppState extends CaptainAppStates {}

class SuccessShiftsRevenueTripCaptainAppState extends CaptainAppStates {}

class ErrorShiftsRevenueTripCaptainAppState extends CaptainAppStates {
  final String error;

  ErrorShiftsRevenueTripCaptainAppState({required this.error});
}

class LoadingAddApplicationTripRevenueCaptainAppState
    extends CaptainAppStates {}

class SuccessAddApplicationTripRevenueCaptainAppState
    extends CaptainAppStates {}

class ErrorAddApplicationTripRevenueCaptainAppState extends CaptainAppStates {
  final String message;

  ErrorAddApplicationTripRevenueCaptainAppState({required this.message});
}

/// Shift:: Expenses States Section
class ChangeAddExpensesState extends CaptainAppStates {}

class LoadingAddShiftsExpensesCaptainAppState extends CaptainAppStates {}

class SuccessAddShiftsExpensesCaptainAppState extends CaptainAppStates {}

class ErrorAddShiftsExpensesCaptainAppState extends CaptainAppStates {
  final String error;

  ErrorAddShiftsExpensesCaptainAppState({required this.error});
}

class LoadingAddExpensesChargeCaptainAppState extends CaptainAppStates {}

class SuccessAddExpensesChargeCaptainAppState extends CaptainAppStates {}

class ErrorAddExpensesChargeCaptainAppState extends CaptainAppStates {
  final String error;

  ErrorAddExpensesChargeCaptainAppState({required this.error});
}

class LoadingExpensesFuelCaptainAppState extends CaptainAppStates {}

class SuccessExpensesFuelCaptainAppState extends CaptainAppStates {}

class ErrorExpensesFuelCaptainAppState extends CaptainAppStates {
  final String error;

  ErrorExpensesFuelCaptainAppState({required this.error});
}

/// Shift:: Notes States Section

class LoadingSendNoteCaptainAppState extends CaptainAppStates {}

class SuccessSendNoteCaptainAppState extends CaptainAppStates {}

class ErrorSendNoteCaptainAppState extends CaptainAppStates {
  final String error;

  ErrorSendNoteCaptainAppState({required this.error});
}

/// Shift:: Supplies States Section
class ShowSuppliesImageState extends CaptainAppStates {}

class LoadingGetAllSuppliersCaptainAppState extends CaptainAppStates {}

class SuccessGetAllSuppliersCaptainAppState extends CaptainAppStates {}

class ErrorGetAllSuppliersCaptainAppState extends CaptainAppStates {
  final String error;

  ErrorGetAllSuppliersCaptainAppState({required this.error});
}

class LoadingAddSuppliersCaptainAppState extends CaptainAppStates {}

class SuccessAddSuppliersCaptainAppState extends CaptainAppStates {}

class ErrorAddSuppliersCaptainAppState extends CaptainAppStates {
  final String error;

  ErrorAddSuppliersCaptainAppState({required this.error});
}

/// Shift:: End Shift States Section

class LoadingEndNewShiftCaptainAppState extends CaptainAppStates {}

class SuccessEndNewShiftCaptainAppState extends CaptainAppStates {
  final EndShiftModel endShiftModel;

  SuccessEndNewShiftCaptainAppState({required this.endShiftModel});
}

class ErrorEndNewShiftCaptainAppState extends CaptainAppStates {
  final String error;

  ErrorEndNewShiftCaptainAppState({required this.error});
}

/// Reports States Section

class LoadingGetDailyReportAppState extends CaptainAppStates {}

class SuccessGetDailyReportAppState extends CaptainAppStates {}

class ErrorGetDailyReportAppState extends CaptainAppStates {
  final String error;

  ErrorGetDailyReportAppState({required this.error});
}

class LoadingGetAllDailyReportAppState extends CaptainAppStates {}

class SuccessGetAllDailyReportAppState extends CaptainAppStates {}

class ErrorGetAllDailyReportAppState extends CaptainAppStates {
  final String error;

  ErrorGetAllDailyReportAppState({required this.error});
}

class LoadingFilterReportAppState extends CaptainAppStates {}

class SuccessFilterReportAppState extends CaptainAppStates {}

class ErrorFilterReportAppState extends CaptainAppStates {
  final String error;

  ErrorFilterReportAppState({required this.error});
}

class LoadingGetSummaryRevenueAppState extends CaptainAppStates {}

class SuccessGetSummaryRevenueAppState extends CaptainAppStates {}

class ErrorGetSummaryRevenueAppState extends CaptainAppStates {
  final String error;

  ErrorGetSummaryRevenueAppState({required this.error});
}

class LoadingGetSummaryExpenseAppState extends CaptainAppStates {}

class SuccessGetSummaryExpenseAppState extends CaptainAppStates {}

class ErrorGetSummaryExpenseAppState extends CaptainAppStates {
  final String error;

  ErrorGetSummaryExpenseAppState({required this.error});
}

class ChangeBetweenDailyAndMonthlyAppState extends CaptainAppStates {}

class SelectDateOfMonthlyCaptainReportAppState extends CaptainAppStates {}

/// Personal Details States Section
class LoadingGetProfilePersonalDetailsAppState extends CaptainAppStates {}

class SuccessGetProfilePersonalDetailsAppState extends CaptainAppStates {
  final PersonalModel getPersonalModel;

  SuccessGetProfilePersonalDetailsAppState({required this.getPersonalModel});
}

class ErrorGetProfilePersonalDetailsAppState extends CaptainAppStates {
  final String error;

  ErrorGetProfilePersonalDetailsAppState({required this.error});
}
class LoadingUpdateProfilePersonalDetailsAppState extends CaptainAppStates {}

class SuccessUpdateProfilePersonalDetailsAppState extends CaptainAppStates {
  final PersonalModel getPersonalModel;

  SuccessUpdateProfilePersonalDetailsAppState({required this.getPersonalModel});
}

class ErrorUpdateProfilePersonalDetailsAppState extends CaptainAppStates {
  final String error;

  ErrorUpdateProfilePersonalDetailsAppState({required this.error});
}

class LoadingDeleteCredentialsAppState extends CaptainAppStates {}

class SuccessDeleteCredentialsAppState extends CaptainAppStates {}

class ErrorDeleteCredentialsAppState extends CaptainAppStates {
  final String error;

  ErrorDeleteCredentialsAppState({required this.error});
}

class LoadingLogoutAppState extends CaptainAppStates {}

class SuccessLogoutAppState extends CaptainAppStates {
  final String message;

  SuccessLogoutAppState({required this.message});
}

class ErrorLogoutAppState extends CaptainAppStates {
  final String error;

  ErrorLogoutAppState({required this.error});
}

/// Maps States Section

class PlacesLoaded extends CaptainAppStates {
  final List<dynamic> placesSuggestion;

  PlacesLoaded(this.placesSuggestion);
}

class PlaceDetailsLoaded extends CaptainAppStates {
  final Place placeLocation;

  PlaceDetailsLoaded(this.placeLocation);
}

class RestartScreen extends CaptainAppStates {}
