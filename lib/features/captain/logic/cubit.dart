import 'dart:async';
import 'dart:io';

import 'package:commuter/core/network/api/api_consumer.dart';
import 'package:commuter/core/network/api/end_points.dart';
import 'package:commuter/core/network/error/exceptions.dart';
import 'package:commuter/core/routing/routes.dart';
import 'package:commuter/core/shared/extensions/nav_extension.dart';
import 'package:commuter/core/shared/logic/location_helper.dart';
import 'package:commuter/core/shared/logic/shared_pref.dart';
import 'package:commuter/core/shared/logic/shared_pref_keys.dart';
import 'package:commuter/core/shared/widgets/texts.dart';
import 'package:commuter/features/captain/data/captain_shift/cars_types_model.dart';
import 'package:commuter/features/captain/data/captain_shift/control_shift_time_model.dart';
import 'package:commuter/features/captain/data/captain_shift/daily_report.dart';
import 'package:commuter/features/captain/data/captain_shift/end_shift_model.dart';
import 'package:commuter/features/captain/data/captain_shift/new_shift_model.dart';
import 'package:commuter/features/captain/data/captain_shift/perosnal_model.dart';
import 'package:commuter/features/captain/data/captain_shift/place_details_model.dart';
import 'package:commuter/features/captain/data/captain_shift/places_suggestion.dart';
import 'package:commuter/features/captain/data/captain_shift/report_filter.dart';
import 'package:commuter/features/captain/data/captain_shift/revenue_course_model.dart';
import 'package:commuter/features/captain/data/captain_shift/summary_expense.dart';
import 'package:commuter/features/captain/data/captain_shift/summary_revenue.dart';
import 'package:commuter/features/captain/data/dash_board_model/dash_board_messages_model.dart';
import 'package:commuter/features/captain/logic/states.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class CaptainAppCubit extends Cubit<CaptainAppStates> {
  CaptainAppCubit(this.apiConsumer) : super(InitializeCaptainAppState());

  final ApiConsumer apiConsumer;

  /// TODO: General
  DashBoardMessageModel? dashBoardMessageModel;
  bool getMessage = false;
  int checkBreakOrResume = 0;
  Position? position;
  List<Placemark>? placeMarks;

  checkIfResumeOrBreak(int number) {
    checkBreakOrResume = number;
    emit(CheckBreakOrResumeShiftAppState());
  }

  XFile? pickImageFromDevice(XFile? imagePath, XFile newImage) {
    imagePath = newImage;
    emit(UploadImageState());
    return imagePath;
  }

  getAllMessages() async {
    getMessage = true;
    emit(LoadingMessagesCaptainAppState());

    try {
      final response = await apiConsumer.get(
        EndPoints.messages,
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${SharedPrefService.getData(key: SharedPrefKeys.token)}',
          },
        ),
      );

      dashBoardMessageModel = DashBoardMessageModel.fromJson(response.data);

      getMessage = false;
      emit(SuccessMessagesCaptainAppState());
    } on ServerException catch (error) {
      getMessage = false;

      emit(
        ErrorMessagesCaptainAppState(
          error: error.errorModel.errorMessage,
        ),
      );
    }
  }

  deleteCredentials() async {
    emit(LoadingDeleteCredentialsAppState());
    try {
      await SharedPrefService.removeData(key: SharedPrefKeys.userEmail);
      await SharedPrefService.removeData(key: SharedPrefKeys.userPassword);

      emit(SuccessDeleteCredentialsAppState());
    } on ServerException catch (error) {
      emit(
        ErrorDeleteCredentialsAppState(
          error: error.errorModel.errorMessage,
        ),
      );
    }
  }

  logout(BuildContext context) async {
    emit(LoadingLogoutAppState());
    context.pushNamedAndRemoveUntil(
      Routes.loginScreen,
      predicate: (Route<dynamic> route) => false,
    );
    try {
      await SharedPrefService.removeData(key: SharedPrefKeys.token);
      emit(
        SuccessLogoutAppState(
          message: 'تم تسجيل الخروج بنجاح',
        ),
      );
    } on ServerException catch (error) {
      emit(
        ErrorLogoutAppState(
          error: error.errorModel.errorMessage,
        ),
      );
    }
  }

  restartScreen(BuildContext context) {
    context.pop();
    emit(RestartScreen());
  }

  /// TODO: SHIFT SECTION
  // New Shift Logic Section ==> new shift
  var newShiftFormKey = GlobalKey<FormState>();
  bool getAllCarsLoading = false;
  GetAllCarTypesModel? getAllCarTypesModel;
  int? selectedCarTypeValue;
  var carMeterNewShiftController = TextEditingController();
  XFile? newShiftImage;
  NewShiftModel? newShiftModel;
  ControlShiftTimeModel? resumeShiftModel;

  getAllCarTypes() async {
    getAllCarsLoading = true;
    emit(LoadingGetAllCarTypesCaptainAppState());

    try {
      final response = await apiConsumer.get(
        EndPoints.getAllCars,
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${SharedPrefService.getData(key: SharedPrefKeys.token)}',
          },
        ),
      );

      getAllCarTypesModel = GetAllCarTypesModel.fromJson(response.data);

      getAllCarsLoading = false;
      emit(SuccessGetAllCarTypesCaptainAppState());
    } on ServerException catch (error) {
      getAllCarsLoading = false;
      emit(
        ErrorGetAllCarTypesCaptainAppState(
          error: error.errorModel.errorMessage,
        ),
      );
    }
  }

  startShift() async {
    emit(LoadingStartNewShiftCaptainAppState());

    final file = File(newShiftImage!.path);
    try {
      final response = await apiConsumer.post(
        EndPoints.startShift,
        isFormData: true,
        data: {
          'car_type_id': selectedCarTypeValue,
          'odometerStart': carMeterNewShiftController.text,
          'locationName': LocationUtils.currentAddress,
          'latitude': LocationUtils.currentPosition!.latitude,
          'longitude': LocationUtils.currentPosition!.longitude,
          'odometerImage': await MultipartFile.fromFile(
            file.path,
            filename: path.basename(file.path),
          ),
        },
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${SharedPrefService.getData(key: SharedPrefKeys.token)}',
          },
        ),
      );
      newShiftModel = NewShiftModel.fromJson(response.data);
      SharedPrefService.saveData(
          key: SharedPrefKeys.shiftId, value: newShiftModel!.shiftId);
      emit(SuccessStartNewShiftCaptainAppState(newShiftModel: newShiftModel!));
    } on ServerException catch (error) {
      print(error);
      emit(
        ErrorStartNewShiftCaptainAppState(
          error: error.errorModel.errorMessage,
        ),
      );
    }
  }

  resumeShiftTime() async {
    emit(LoadingResumeShiftCaptainAppState());

    try {
      final response = await apiConsumer.post(
        EndPoints.resumeShift,
        data: {
          'shiftId': SharedPrefService.getData(key: SharedPrefKeys.shiftId),
        },
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${SharedPrefService.getData(key: SharedPrefKeys.token)}',
          },
        ),
      );
      resumeShiftModel = ControlShiftTimeModel.fromJson(response.data);
      emit(SuccessResumeShiftCaptainAppState(
          controlShiftTimeModel: resumeShiftModel!));
    } on ServerException catch (error) {
      emit(
        ErrorResumeShiftCaptainAppState(error: error.errorModel.errorMessage),
      );
    }
  }

  breakShiftTime() async {
    emit(LoadingBreakShiftCaptainAppState());

    try {
      final response = await apiConsumer.post(
        EndPoints.breakShift,
        data: {
          'shiftId': SharedPrefService.getData(key: SharedPrefKeys.shiftId),
        },
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${SharedPrefService.getData(key: SharedPrefKeys.token)}',
          },
        ),
      );
      resumeShiftModel = ControlShiftTimeModel.fromJson(response.data);
      emit(SuccessBreakShiftCaptainAppState(
          controlShiftTimeModel: resumeShiftModel!));
    } on ServerException catch (error) {
      emit(
        ErrorResumeShiftCaptainAppState(error: error.errorModel.errorMessage),
      );
    }
  }

  /// TODO: SHIFT => REVENUE SECTION
  // Add shifts revenue
  int addRevenueNavAppBar = 0;
  var addRevenueFormKey = GlobalKey<FormState>();

  RevenueCourseModel? revenueNumberSelectedValue;
  List<DropdownMenuItem<String>> revenueTripTypeList = [
    const DropdownMenuItem(
      value: 'ذهاب',
      child: RegularText16dark(
        text: 'ذهاب',
      ),
    ),
    const DropdownMenuItem(
      value: 'عودة',
      child: RegularText16dark(
        text: 'عودة',
      ),
    ),
    const DropdownMenuItem(
      value: 'ذهاب وعودة',
      child: RegularText16dark(
        text: 'ذهاب وعودة',
      ),
    ),
  ];
  String? revenueTripTypeSelectedValue;
  List<DropdownMenuItem<int>> revenuePaymentList = [
    const DropdownMenuItem(
      value: 1,
      child: RegularText16dark(
        text: 'نعم',
      ),
    ),
    const DropdownMenuItem(
      value: 0,
      child: RegularText16dark(
        text: 'لا',
      ),
    ),
  ];
  int? revenuePaymentSelectedValue;
  var revenuePaymentValueController = TextEditingController();

  GetAllRevenueCourseModel? getAllRevenueCourseModel;
  bool getAllRevenueCourseLoading = false;

  getAllRevenueCourse() async {
    getAllRevenueCourseLoading = true;
    emit(LoadingAddShiftsRevenueCaptainAppState());

    try {
      final response = await apiConsumer.get(
        EndPoints.getAllCoursesRevenue,
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${SharedPrefService.getData(key: SharedPrefKeys.token)}',
          },
        ),
      );

      getAllRevenueCourseModel =
          GetAllRevenueCourseModel.fromJson(response.data);
      getAllRevenueCourseLoading = false;
      emit(SuccessAddShiftsRevenueCaptainAppState());
    } on ServerException catch (error) {
      getAllRevenueCourseLoading = false;
      emit(
        ErrorAddShiftsRevenueCaptainAppState(
          error: error.errorModel.errorMessage,
        ),
      );
    }
  }

  addShiftsRevenue() async {
    emit(LoadingAddShiftsRevenueCaptainAppState());

    try {
      await apiConsumer.post(
        EndPoints.addShiftsRevenue,
        isFormData: true,
        data: {
          'shift_id_course':
              '${SharedPrefService.getData(key: SharedPrefKeys.shiftId)}',
          'course_number': '${revenueNumberSelectedValue!.courseNumber}',
          'trip_type': revenueTripTypeSelectedValue,
          'cash_payment': revenuePaymentSelectedValue,
          'financial_value': double.parse(revenuePaymentValueController.text),
        },
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${SharedPrefService.getData(key: SharedPrefKeys.token)}',
          },
        ),
      );

      emit(SuccessAddShiftsRevenueCaptainAppState());
    } on ServerException catch (error) {
      emit(
        ErrorAddShiftsRevenueCaptainAppState(
          error: error.errorModel.errorMessage,
        ),
      );
    }
  }

  //add out side trip revenue
  var revenueOutsideFormKey = GlobalKey<FormState>();
  var revenueOutsideTripNumController = TextEditingController();
  var revenueOutsidePaymentValueController = TextEditingController();

  addRevenueTrip() async {
    emit(LoadingShiftsRevenueTripCaptainAppState());

    try {
      await apiConsumer.post(
        EndPoints.revenueTrips,
        isFormData: true,
        data: {
          'shift_id_trips':
              SharedPrefService.getData(key: SharedPrefKeys.shiftId),
          'num_trips_trips': int.parse(revenueOutsideTripNumController.text),
          'financial_value_trips':
              double.parse(revenueOutsidePaymentValueController.text),
        },
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${SharedPrefService.getData(key: SharedPrefKeys.token)}',
          },
        ),
      );

      emit(SuccessShiftsRevenueTripCaptainAppState());
    } on ServerException catch (error) {
      emit(
        ErrorShiftsRevenueTripCaptainAppState(
          error: error.errorModel.errorMessage,
        ),
      );
    }
  }

  // Add applications revenue
  var revenueAppFormKey = GlobalKey<FormState>();
  List<DropdownMenuItem<String>> revenueAppNameList = [
    const DropdownMenuItem(
      value: 'أوبر',
      child: RegularText16dark(
        text: 'أوبر',
      ),
    ),
    const DropdownMenuItem(
      value: 'ديدي',
      child: RegularText16dark(
        text: 'ديدي',
      ),
    ),
    const DropdownMenuItem(
      value: 'ان درايف',
      child: RegularText16dark(
        text: 'ان درايف',
      ),
    ),
    const DropdownMenuItem(
      value: 'كريم',
      child: RegularText16dark(
        text: 'كريم',
      ),
    ),
  ];
  String? revenueAppNameSelectedValue;
  var revenueAppTripNumController = TextEditingController();
  var revenueAppTripPaymentValueController = TextEditingController();
  XFile? revenueAppTripPaymentValueImage;

  addApplicationTripRevenue() async {
    emit(LoadingAddApplicationTripRevenueCaptainAppState());

    final file = File(revenueAppTripPaymentValueImage!.path);

    try {
      await apiConsumer.post(
        EndPoints.addApplicationTripRevenue,
        isFormData: true,
        data: {
          'shift_id_application':
              '${SharedPrefService.getData(key: SharedPrefKeys.shiftId)}',
          'app_name_application': revenueAppNameSelectedValue,
          'num_trips_application': revenueAppTripNumController.text,
          'financial_value_application':
              revenueAppTripPaymentValueController.text,
          'image_upload_application': await MultipartFile.fromFile(
            file.path,
            filename: path.basename(file.path),
          ),
        },
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${SharedPrefService.getData(key: SharedPrefKeys.token)}',
          },
        ),
      );

      emit(SuccessAddApplicationTripRevenueCaptainAppState());
    } on ServerException catch (error) {
      emit(
        ErrorAddApplicationTripRevenueCaptainAppState(
          message: error.errorModel.errorMessage,
        ),
      );
    }
  }

  void changeAddRevenue(int pageNumber) {
    addRevenueNavAppBar = pageNumber;
    emit(ChangeAddRevenueState());
  }

  /// TODO: SHIFT => EXPENSES SECTION
  // additional expenses
  int addExpensesNavAppBar = 0;
  var anotherExpensesFormKey = GlobalKey<FormState>();
  var expensesItemTypeController = TextEditingController();
  var expensesPaidCostController = TextEditingController();
  XFile? expensesAnotherImage;

  addAdditionalExpenses() async {
    emit(LoadingAddShiftsExpensesCaptainAppState());

    final file = File(expensesAnotherImage!.path);
    try {
      await apiConsumer.post(
        EndPoints.expensesAdditional,
        isFormData: true,
        data: {
          'shift_id_additional':
              '${SharedPrefService.getData(key: SharedPrefKeys.shiftId)}',
          'type_additional_expenses': expensesItemTypeController.text,
          'price_additional_expenses':
              double.parse(expensesPaidCostController.text),
          'image_price_additional_expenses': await MultipartFile.fromFile(
            file.path,
            filename: path.basename(file.path),
          ),
        },
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${SharedPrefService.getData(key: SharedPrefKeys.token)}',
          },
        ),
      );

      emit(SuccessAddShiftsExpensesCaptainAppState());
    } on ServerException catch (error) {
      emit(
        ErrorAddShiftsExpensesCaptainAppState(
          error: error.errorModel.errorMessage,
        ),
      );
    }
  }

  // applications charging expenses
  var expensesAppChargeFormKey = GlobalKey<FormState>();
  List<DropdownMenuItem<String>> expensesAppChargeNameList = [
    const DropdownMenuItem(
      value: 'أوبر',
      child: RegularText16dark(
        text: 'أوبر',
      ),
    ),
    const DropdownMenuItem(
      value: 'ديدي',
      child: RegularText16dark(
        text: 'ديدي',
      ),
    ),
    const DropdownMenuItem(
      value: 'ان درايف',
      child: RegularText16dark(
        text: 'ان درايف',
      ),
    ),
    const DropdownMenuItem(
      value: 'كريم',
      child: RegularText16dark(
        text: 'كريم',
      ),
    ),
  ];
  String? expensesAppChargeNameSelectedValue;
  var expensesAppChargePaidValue = TextEditingController();
  XFile? expensesAppChargeImage;

  addExpensesCharge() async {
    emit(LoadingAddExpensesChargeCaptainAppState());

    final file = File(expensesAppChargeImage!.path);
    try {
      await apiConsumer.post(
        EndPoints.expensesCharge,
        isFormData: true,
        data: {
          'shift_id_charge':
              '${SharedPrefService.getData(key: SharedPrefKeys.shiftId)}',
          'name_charge_app': expensesAppChargeNameSelectedValue,
          'price_app': double.parse(expensesAppChargePaidValue.text),
          'image_price_app': await MultipartFile.fromFile(
            file.path,
            filename: path.basename(file.path),
          ),
        },
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${SharedPrefService.getData(key: SharedPrefKeys.token)}',
          },
        ),
      );

      emit(SuccessAddExpensesChargeCaptainAppState());
    } on ServerException catch (error) {
      emit(
        ErrorAddExpensesChargeCaptainAppState(
          error: error.errorModel.errorMessage,
        ),
      );
    }
  }

  // Gaz expenses
  var expensesGazFormKey = GlobalKey<FormState>();
  List<DropdownMenuItem<String>> expensesGazList = [
    const DropdownMenuItem(
      value: 'البنزين',
      child: RegularText16dark(
        text: 'البنزين',
      ),
    ),
    const DropdownMenuItem(
      value: 'الغاز',
      child: RegularText16dark(
        text: 'الغاز',
      ),
    ),
  ];
  String? expensesGazSelectedValue;
  var expensesGazPaidValueController = TextEditingController();
  XFile? expensesGazImage;

  addExpensesFuel() async {
    emit(LoadingExpensesFuelCaptainAppState());

    try {
      var data = {
        'shift_id_fuel': SharedPrefService.getData(key: SharedPrefKeys.shiftId),
        'fuel_type': '$expensesGazSelectedValue',
        'price_fuel': int.parse(expensesGazPaidValueController.text),
      };

      MultipartFile? imageMultipartFile;

      if (expensesGazImage != null) {
        imageMultipartFile = await MultipartFile.fromFile(
          expensesGazImage!.path,
          filename: path.basename(expensesGazImage!.path),
        );
      }

      data['image_price_fuel'] = imageMultipartFile;

      await apiConsumer.post(
        EndPoints.expensesFuel,
        isFormData: true,
        data: data,
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${SharedPrefService.getData(key: SharedPrefKeys.token)}',
          },
        ),
      );

      emit(SuccessExpensesFuelCaptainAppState());
    } on ServerException catch (error) {
      emit(
        ErrorExpensesFuelCaptainAppState(
          error: error.errorModel.errorMessage,
        ),
      );
    }
  }

  void changeAddExpenses(int pageNumber) {
    addExpensesNavAppBar = pageNumber;
    emit(ChangeAddExpensesState());
  }

  /// TODO: SHIFT => SUPPLIES SECTION
  var supplyFormKey = GlobalKey<FormState>();
  var supplierNameController = TextEditingController();
  var suppliedAmountCostController = TextEditingController();
  List<DropdownMenuItem<String>> supplyMethodList = [
    const DropdownMenuItem(
      value: 'كاش',
      child: RegularText16dark(
        text: 'كاش',
      ),
    ),
    const DropdownMenuItem(
      value: 'حساب بنكي',
      child: RegularText16dark(
        text: 'حساب بنكي',
      ),
    ),
    const DropdownMenuItem(
      value: 'محفظة (فودافون - إتصالات - أورانج)',
      child: RegularText16dark(
        text: 'محفظة (فودافون - إتصالات - أورانج)',
      ),
    ),
    const DropdownMenuItem(
      value: 'فوري',
      child: RegularText16dark(
        text: 'فوري',
      ),
    ),
  ];
  String? supplyMethodSelectedValue;
  XFile? supplyMethodImage;

  addSuppliers() async {
    emit(LoadingAddSuppliersCaptainAppState());

    File? supplyMethodImageFile;
    if (supplyMethodImage != null) {
      supplyMethodImageFile = File(supplyMethodImage!.path);
    }

    try {
      await apiConsumer.post(
        EndPoints.suppliers,
        isFormData: true,
        data: {
          'shift_id_supplier':
              '${SharedPrefService.getData(key: SharedPrefKeys.shiftId)}',
          'supplier_name': supplierNameController.text,
          'price': suppliedAmountCostController.text,
          'way_pay': supplyMethodSelectedValue,
          if (supplyMethodImageFile != null)
            'image_upload_supplier': await MultipartFile.fromFile(
              supplyMethodImageFile.path,
              filename: path.basename(supplyMethodImageFile.path),
            ),
        },
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${SharedPrefService.getData(key: SharedPrefKeys.token)}',
          },
        ),
      );

      emit(SuccessAddSuppliersCaptainAppState());
    } on ServerException catch (error) {
      emit(ErrorAddSuppliersCaptainAppState(
        error: error.errorModel.errorMessage,
      ));
    }
  }

  changeSupplyMethodSelectedValue(String? value) {
    supplyMethodSelectedValue = value;
    emit(ShowSuppliesImageState());
  }

  /// TODO: SHIFT => NOTES SECTION
  var noteShiftFormKey = GlobalKey<FormState>();
  var writeNoteController = TextEditingController();

  sendNote() async {
    emit(LoadingSendNoteCaptainAppState());

    try {
      await apiConsumer.post(
        EndPoints.sendNote,
        data: {
          'note_content': writeNoteController.text,
        },
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${SharedPrefService.getData(key: SharedPrefKeys.token)}',
          },
        ),
      );

      emit(SuccessSendNoteCaptainAppState());
    } on ServerException catch (error) {
      emit(
        ErrorSendNoteCaptainAppState(
          error: error.errorModel.errorMessage,
        ),
      );
    }
  }

  /// TODO: SHIFT => END SHIFT SECTION
  var endShiftFormKey = GlobalKey<FormState>();
  var endShiftCarMeterController = TextEditingController();
  XFile? endShiftCarMeterImage;
  EndShiftModel? endShiftModel;

  endShift() async {
    emit(LoadingEndNewShiftCaptainAppState());
    try {
      final response = await apiConsumer.post(
        EndPoints.endShift,
        data: {
          'shiftId': SharedPrefService.getData(key: SharedPrefKeys.shiftId),
          'endOdometerStart': endShiftCarMeterController.text,
          'locationName': LocationUtils.currentAddress,
          'latitude': LocationUtils.currentPosition!.latitude,
          'longitude': LocationUtils.currentPosition!.longitude,
        },
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${SharedPrefService.getData(key: SharedPrefKeys.token)}',
          },
        ),
      );
      // SharedPrefService.removeData(key: SharedPrefKeys.startProcess);
      endShiftModel = EndShiftModel.fromJson(response.data);
      SharedPrefService.removeData(key: SharedPrefKeys.shiftId);

      emit(SuccessEndNewShiftCaptainAppState(endShiftModel: endShiftModel!));
    } on ServerException catch (error) {
      emit(
        ErrorEndNewShiftCaptainAppState(
          error: error.errorModel.errorMessage,
        ),
      );
    }
  }

  /// TODO:  Map Logic Section

  Future<List<dynamic>> getSuggestions(String place) async {
    try {
      Response response = await apiConsumer.get(
        // 'https://maps.googleapis.com/maps/api/place/autocomplete/json',
        'https://maps.googleapis.com/maps/api/place/textsearch/json',
        // 'https://maps.googleapis.com/maps/api/place/nearbysearch/json',
        queryParameters: {
          'query': place,
          'type': 'address',
          'components': 'country:eg',
          'key': 'AIzaSyBtpz1PYwlJoXX_OC4Mpi9-h4mDzyPZGvM',
          // 'sessiontoken': sessionToken,
        },
      );
      return response.data['results']
          .map((e) => PlacesSuggestion.fromJson(e))
          .toList();
    } catch (e) {
      return [];
    }
  }

  void emitSuggestions(String place) {
    getSuggestions(place).then((value) {
      emit(PlacesLoaded(value));
    });
  }

  // Future<List<PlaceResult>> searchPlaces(String query) async {
  //   const apiKey = 'AIzaSyBtpz1PYwlJoXX_OC4Mpi9-h4mDzyPZGvM';
  //   final url =
  //       'https://maps.googleapis.com/maps/api/place/textsearch/json?query=$query&key=$apiKey';
  //
  //   final response = await apiConsumer.get(
  //     url,
  //   );
  //   List<PlaceResult> searchResults = [];
  //   if (response.statusCode == 200) {
  //     final predictions = response.data['results'] as List<dynamic>;
  //     searchResults =
  //         predictions.map((result) => PlaceResult.fromJson(result)).toList();
  //   } else {
  //     searchResults = [];
  //   }
  //   return searchResults;
  // }
  //
  // void emitSuggestions(String place, String sessionToken) {
  //   searchPlaces(place).then((value) {
  //     emit(PlacesLoaded(value));
  //   });
  // }

  Future<dynamic> getPlaceLocation(String placeId) async {
    try {
      Response response = await apiConsumer.get(
        'https://maps.googleapis.com/maps/api/place/details/json',
        queryParameters: {
          'place_id': placeId,
          'fields': 'geometry',
          'key': 'AIzaSyBtpz1PYwlJoXX_OC4Mpi9-h4mDzyPZGvM',
        },
      );
      return Place.fromJson(response.data);
    } catch (e) {
      return Future.error(
        'Place error: ',
        StackTrace.fromString('this is trace'),
      );
    }
  }

  void emitPlaceLocation(String placeId) {
    getPlaceLocation(placeId).then((value) {
      emit(PlaceDetailsLoaded(value));
    });
  }

  /// TODO:  Reports Logic Section
  bool isDailyReport = true;
  var monthlyReportFromKey = GlobalKey<FormState>();
  var startMonthlyDateController = TextEditingController();
  var endMonthlyDateController = TextEditingController();

  GetDailyReportModel? getDailyReportModel;
  bool loadingDailyReportModel = false;
  DailyReportModel? lastDailyReportModel;
  DailyReportModel? lastAllReportModel;

  // el bahdala
  GetAllDailyReportModel? getAllDailyReportModel;
  bool loadingAllDailyReportModel = false;
  double totalRevenue = 0.0;
  double totalExpense = 0.0;

  // ReportFilterModel? reportFilterModel;
  // bool loadingReportFilterModel = false;
  SummaryRevenueModel? summaryRevenueModel;
  SummaryExpensesModel? summaryExpensesModel;

  ReportFilterModel? reportFilterModel;
  bool reportFilterCheck = false;

  getDailyReport() async {
    loadingDailyReportModel = true;
    emit(LoadingGetDailyReportAppState());

    try {
      final response = await apiConsumer.get(
        EndPoints.nowDailyReport,
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${SharedPrefService.getData(key: SharedPrefKeys.token)}',
          },
        ),
      );

      if (response.statusCode == 200) {
        getDailyReportModel = GetDailyReportModel.fromJson(response.data);
        lastDailyReportModel = getDailyReportModel?.body?.reduce((a, b) =>
            DateTime.parse(a.startDate.toString())
                    .isAfter(DateTime.parse(b.startDate.toString()))
                ? a
                : b);

        loadingDailyReportModel = false;
        emit(SuccessGetDailyReportAppState());
      } else {
        loadingDailyReportModel = false;
        emit(
          ErrorGetDailyReportAppState(
            error: 'لم يتم العثور علي تقارير',
          ),
        );
      }
    } on ServerException catch (error) {
      loadingDailyReportModel = false;
      emit(
        ErrorGetDailyReportAppState(
          error: error.errorModel.errorMessage,
        ),
      );
    }
  }

  getAllDailyReport() async {
    loadingAllDailyReportModel = true;
    emit(LoadingGetAllDailyReportAppState());

    try {
      final response = await apiConsumer.get(
        EndPoints.allDailyReport,
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${SharedPrefService.getData(key: SharedPrefKeys.token)}',
          },
        ),
      );
      getAllDailyReportModel = GetAllDailyReportModel.fromJson(response.data);
      lastAllReportModel = getAllDailyReportModel?.body?.reduce((a, b) =>
          DateTime.parse(a.startDate.toString())
                  .isAfter(DateTime.parse(b.startDate.toString()))
              ? a
              : b);

      loadingAllDailyReportModel = false;
      emit(SuccessGetAllDailyReportAppState());
    } on ServerException catch (error) {
      loadingAllDailyReportModel = false;
      emit(
        ErrorGetAllDailyReportAppState(
          error: error.errorModel.errorMessage,
        ),
      );
    }
  }

  filterReport() async {
    reportFilterCheck = true;
    emit(LoadingFilterReportAppState());

    try {
      final response = await apiConsumer.post(
        EndPoints.reportsFilter,
        data: {
          'start_date': startMonthlyDateController.text,
          'end_date': endMonthlyDateController.text,
        },
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${SharedPrefService.getData(key: SharedPrefKeys.token)}',
          },
        ),
      );
      reportFilterCheck = false;
      reportFilterModel = ReportFilterModel.fromJson(response.data);
      emit(SuccessFilterReportAppState());
    } on ServerException catch (error) {
      reportFilterCheck = false;
      emit(ErrorFilterReportAppState(error: error.toString()));
    }
  }


  getSummaryRevenue() async {
    emit(LoadingGetSummaryRevenueAppState());

    try {
      final response = await apiConsumer.get(
        EndPoints.summaryRevenue,
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${SharedPrefService.getData(key: SharedPrefKeys.token)}',
          },
        ),
      );

      summaryRevenueModel = SummaryRevenueModel.fromJson(response.data);
      emit(SuccessGetSummaryRevenueAppState());
    } on ServerException catch (error) {
      emit(
        ErrorGetSummaryRevenueAppState(
          error: error.errorModel.errorMessage,
        ),
      );
    }
  }

  getSummaryExpense() async {
    emit(LoadingGetSummaryExpenseAppState());

    try {
      final response = await apiConsumer.get(
        EndPoints.summaryExpense,
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${SharedPrefService.getData(key: SharedPrefKeys.token)}',
          },
        ),
      );

      summaryExpensesModel = SummaryExpensesModel.fromJson(response.data);
      emit(SuccessGetSummaryExpenseAppState());
    } on ServerException catch (error) {
      emit(
        ErrorGetSummaryExpenseAppState(
          error: error.errorModel.errorMessage,
        ),
      );
    }
  }

  double convertTimeToHours(String time) {
    List<String> parts = time.split(':');

    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    int seconds = int.parse(parts[2]);

    double totalHours = hours + (minutes / 60) + (seconds / 3600);

    return totalHours;
  }

  void changeBetweenDailyAndMonthlyStates(bool value) {
    isDailyReport = value;
    emit(ChangeBetweenDailyAndMonthlyAppState());
  }

  Future<void> selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? piked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (piked != null) {
      controller.text = piked.toString().split(" ")[0];
      emit(SelectDateOfMonthlyCaptainReportAppState());
    }
  }

  /// TODO: Personal Details Logic Section
  var personalFormKey = GlobalKey<FormState>();
  XFile? personalImage;
  PersonalModel? personalModel;
  var personalFirstNameController = TextEditingController();
  var personalLastNameController = TextEditingController();
  var personalEmailController = TextEditingController();
  var personalWhatsAppController = TextEditingController();
  var personalAnotherNumberController = TextEditingController();
  var personalAddressController = TextEditingController();
  var personalStatus = TextEditingController();

  getPersonalProfile() async {
    emit(LoadingGetProfilePersonalDetailsAppState());

    try {
      final response = await apiConsumer.get(
        EndPoints.getProfile,
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${SharedPrefService.getData(key: SharedPrefKeys.token)}',
          },
        ),
      );
      personalModel = PersonalModel.fromJson(response.data);

      personalFirstNameController.text = '${personalModel!.user!.firstName}';
      personalLastNameController.text = '${personalModel!.user!.lastName}';
      personalEmailController.text = '${personalModel!.user!.email}';
      personalWhatsAppController.text =
          '${personalModel!.user!.whatsappNumber}';
      personalAnotherNumberController.text =
          '${personalModel!.user!.anotherNumber}';
      personalAddressController.text = '${personalModel!.user!.address}';
      personalStatus.text = '${personalModel!.user!.status}';
      emit(SuccessGetProfilePersonalDetailsAppState(
          getPersonalModel: personalModel!));
    } on ServerException catch (error) {
      emit(ErrorGetProfilePersonalDetailsAppState(
          error: error.errorModel.errorMessage));
    }
  }

  updatePersonalData() async {
    emit(LoadingUpdateProfilePersonalDetailsAppState());

    try {
      File? personalImageFile;
      if (personalImage != null) {
        personalImageFile = File(personalImage!.path);
      }

      final response = await apiConsumer.post(
        EndPoints.updateProfile,
        isFormData: true,
        data: {
          'first_name': personalFirstNameController.text,
          'last_name': personalLastNameController.text,
          'email': personalEmailController.text,
          'whatsapp_number': personalWhatsAppController.text,
          'another_number': personalAnotherNumberController.text,
          'address': personalAddressController.text,
          if (personalImageFile != null)
            'ProfileImage': await MultipartFile.fromFile(
              personalImageFile.path,
              filename: path.basename(personalImageFile.path),
            ),
        },
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${SharedPrefService.getData(key: SharedPrefKeys.token)}',
          },
        ),
      );
      personalModel = PersonalModel.fromJson(response.data);
      emit(SuccessUpdateProfilePersonalDetailsAppState(
          getPersonalModel: personalModel!));
    } on ServerException catch (error) {
      emit(ErrorUpdateProfilePersonalDetailsAppState(
          error: error.errorModel.errorMessage));
    }
  }
}
