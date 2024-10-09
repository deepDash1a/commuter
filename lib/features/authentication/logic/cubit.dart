import 'dart:io';

import 'package:commuter/core/network/api/api_consumer.dart';
import 'package:commuter/core/network/api/end_points.dart';
import 'package:commuter/core/network/error/exceptions.dart';
import 'package:commuter/core/shared/logic/shared_pref.dart';
import 'package:commuter/core/shared/logic/shared_pref_keys.dart';
import 'package:commuter/features/authentication/data/login/forget_password_model.dart';
import 'package:commuter/features/authentication/data/login/login_model.dart';
import 'package:commuter/features/authentication/data/register/register_model.dart';
import 'package:commuter/features/authentication/logic/states.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class AuthenticationAppCubit extends Cubit<AuthenticationAppStates> {
  AuthenticationAppCubit(this.apiConsumer)
      : super(InitializeAuthenticationAppState());

  final ApiConsumer apiConsumer;

  // Login Logic Section
  var loginFormKey = GlobalKey<FormState>();
  var forgetPasswordFormKey = GlobalKey<FormState>();
  var loginEmailController = TextEditingController();
  var forgetPasswordEmailController = TextEditingController();
  var loginPasswordController = TextEditingController();
  bool isLoginObscureTextPassword = true;
  bool? loginIsRemembered = false;

  LoginModel? loginModel;

  login() async {
    emit(LoadingLoginAuthenticationAppState());

    try {
      final response = await apiConsumer.post(
        EndPoints.login,
        data: {
          'email': loginEmailController.text,
          'password': loginPasswordController.text,
        },
      );
      loginModel = LoginModel.fromJson(response.data);

      await SharedPrefService.saveData(
        key: SharedPrefKeys.captainStatus,
        value: loginModel!.body!.status,
      );
      await SharedPrefService.saveData(
        key: SharedPrefKeys.token,
        value: loginModel!.token!,
      );

      emit(SuccessLoginAuthenticationAppState(loginModel: loginModel!));
    } on ServerException catch (error) {
      emit(ErrorLoginAuthenticationAppState(
          error: error.errorModel.errorMessage));
    }
  }

  saveCredentials(String email, String password) async {
    emit(LoadingRememberMeAuthenticationAppState());
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await SharedPrefService.saveData(
            key: SharedPrefKeys.userEmail, value: email);
        await SharedPrefService.saveData(
            key: SharedPrefKeys.userPassword, value: password);

        emit(
          SuccessRememberMeAuthenticationAppState(
            email: email,
            password: password,
          ),
        );
      } else {
        emit(
          ErrorRememberMeAuthenticationAppState(
            error: 'من فضلك أدخل بياناتك كاملة',
          ),
        );
      }
    } on ServerException catch (error) {
      emit(
        ErrorRememberMeAuthenticationAppState(
          error: error.errorModel.errorMessage,
        ),
      );
    }
  }

  void changeLoginRememberMe(bool? value) {
    loginIsRemembered = value;

    if (loginIsRemembered == true) {
      saveCredentials(loginEmailController.text, loginPasswordController.text);
    }
    emit(ChangeLoginRememberMe());
  }

  forgetPassword() async {
    emit(LoadingForgetPasswordAuthenticationAppState());
    try {
      final response = await apiConsumer.post(EndPoints.forgotPassword, data: {
        'email': forgetPasswordEmailController.text,
      });
      final forgetPasswordModel = ForgetPasswordModel.fromJson(response.data);
      emit(SuccessForgetPasswordAuthenticationAppState(
        forgetPasswordModel: forgetPasswordModel,
      ));
    } on ServerException catch (error) {
      emit(
        ErrorForgetPasswordAuthenticationAppState(
          error: error.errorModel.errorMessage,
        ),
      );
    }
  }

  void changeLoginPasswordVisibility() {
    isLoginObscureTextPassword = !isLoginObscureTextPassword;
    emit(ChangeLoginPasswordVisibility());
  }

  // Register Logic Section
  // Registration keys
  var personalDetailsFormKey = GlobalKey<FormState>();
  var detailedResidenceAddressFormKey = GlobalKey<FormState>();
  var someOtherPersonalDetailsFormKey = GlobalKey<FormState>();

  // Personal Details Form' fields
  var registrationFirstNameController = TextEditingController();
  var registrationLastNameController = TextEditingController();
  var registrationWhatsAppController = TextEditingController();
  var registrationAnotherPhoneNumberController = TextEditingController();
  var registrationEmailController = TextEditingController();
  var registrationPasswordController = TextEditingController();
  var registrationConfirmPasswordController = TextEditingController();

  //iD Card Details Form' fields
  XFile? registrationIdCardFaceImage;
  XFile? registrationIdCardBackImage;

  // driving License Details Form' fields
  XFile? registrationDrivingLicenseFaceImage;
  XFile? registrationDrivingLicenseBackImage;

  // detailed Residence Address Form' fields
  var registrationGovernorateController = TextEditingController();
  var registrationCityController = TextEditingController();
  var registrationRegionController = TextEditingController();
  var registrationBuildingController = TextEditingController();
  var registrationFloorController = TextEditingController();
  var registrationFlatController = TextEditingController();

  // personal Government Certificates Form' fields
  XFile? registrationBirthCertificateImage;
  XFile? registrationCriminalCheckCertificateImage;
  XFile? registrationGraduationCertificateImage;
  XFile? registrationArmyCertificateImage;

  // some Other Personal Details Form' fields
  var registrationWalletNumberController = TextEditingController();
  var registrationBankAccountController = TextEditingController();
  XFile? registrationPersonalImage;
  var registrationLicenseExpiryController = TextEditingController();

  // logics
  int registerCurrentStep = 0;
  int registerTotalSteps = 6;
  RegistrationModel? registrationModel;

  XFile? pickImageFromDevice(XFile? imagePath, XFile newImage) {
    imagePath = newImage;
    emit(UploadImageState());
    return imagePath;
  }

  Future<void> selectFutureDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? piked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (piked != null) {
      controller.text = piked.toString().split(" ")[0];
      emit(SelectDateAppState());
    }
  }

  // Function to calculate progress value (0.0 to 1.0)
  double progressValue() {
    return (registerCurrentStep + 1) / registerTotalSteps;
  }

  // Navigate to the previous step
  void nextStep() {
    if (registerCurrentStep < registerTotalSteps - 1) {
      registerCurrentStep++;
      emit(IncreaseStepsRegistrationAppState());
    }
  }

  // Navigate to the previous step
  void previousStep() {
    if (registerCurrentStep > 0) {
      registerCurrentStep--;
      emit(DecreaseStepsRegistrationAppState());
    }
  }

  register() async {
    emit(LoadingRegisterAuthenticationAppState());

    try {
      final nationalIdFrontImageFile = File(registrationIdCardFaceImage!.path);
      final nationalIdBackImageFile = File(registrationIdCardBackImage!.path);
      final licenseFrontImageFile =
          File(registrationDrivingLicenseFaceImage!.path);
      final licenseBackImageFile =
          File(registrationDrivingLicenseBackImage!.path);
      final militaryCertificateImageFile =
          File(registrationArmyCertificateImage!.path);
      final birthCertificateFile =
          File(registrationBirthCertificateImage!.path);
      final feshTshbeehFile =
          File(registrationCriminalCheckCertificateImage!.path);

      File? profileImageFile;
      if (registrationPersonalImage != null) {
        profileImageFile = File(registrationPersonalImage!.path);
      }

      File? graduationCertificateImageFile;
      if (registrationGraduationCertificateImage != null) {
        graduationCertificateImageFile =
            File(registrationGraduationCertificateImage!.path);
      }

      await apiConsumer.post(
        EndPoints.register,
        isFormData: true,
        data: {
          'first_name': registrationFirstNameController.text,
          'last_name': registrationLastNameController.text,
          'email': registrationEmailController.text,
          'password': registrationPasswordController.text,
          'password_confirmation': registrationConfirmPasswordController.text,
          'whatsapp_number': registrationWhatsAppController.text,
          'another_number': registrationAnotherPhoneNumberController.text,
          'national_id_front_image': await MultipartFile.fromFile(
            nationalIdFrontImageFile.path,
            filename: path.basename(nationalIdFrontImageFile.path),
          ),
          'national_id_back_image': await MultipartFile.fromFile(
            nationalIdBackImageFile.path,
            filename: path.basename(nationalIdBackImageFile.path),
          ),
          'license_front_image': await MultipartFile.fromFile(
            licenseFrontImageFile.path,
            filename: path.basename(licenseFrontImageFile.path),
          ),
          'license_back_image': await MultipartFile.fromFile(
            licenseBackImageFile.path,
            filename: path.basename(licenseBackImageFile.path),
          ),
          'address':
              '${registrationGovernorateController.text}, ${registrationCityController.text}, ${registrationRegionController.text}, ${registrationBuildingController.text}, ${registrationFloorController.text}, ${registrationFlatController.text}',
          'birth_certificate': await MultipartFile.fromFile(
            birthCertificateFile.path,
            filename: path.basename(birthCertificateFile.path),
          ),
          if (profileImageFile != null)
            'ProfileImage': await MultipartFile.fromFile(
              profileImageFile.path,
              filename: path.basename(profileImageFile.path),
            ),
          'fesh_tshbeeh': await MultipartFile.fromFile(
            feshTshbeehFile.path,
            filename: path.basename(feshTshbeehFile.path),
          ),
          if (graduationCertificateImageFile != null)
            'graduation_certificate_image': await MultipartFile.fromFile(
              graduationCertificateImageFile.path,
              filename: path.basename(graduationCertificateImageFile.path),
            ),
          'military_certificate_image': await MultipartFile.fromFile(
            militaryCertificateImageFile.path,
            filename: path.basename(militaryCertificateImageFile.path),
          ),
          if (registrationWalletNumberController.text.isEmpty)
            'wallet_number': registrationWalletNumberController.text,
          if (registrationBankAccountController.text.isEmpty)
            'bank_account_number': registrationBankAccountController.text,
          'expiration_license_date': registrationLicenseExpiryController.text,
        },
      );
      emit(SuccessRegisterAuthenticationAppState());
    } on ServerException catch (error) {
      print(error.toString());
      emit(ErrorRegisterAuthenticationAppState(
          error: error.errorModel.errorMessage));
    }
  }

  checkRegisterValid() {
    switch (registerCurrentStep) {
      case 0:
        return personalDetailsFormKey.currentState!.validate() &&
            registrationPasswordController.text ==
                registrationConfirmPasswordController.text;

      case 1:
        return registrationIdCardFaceImage != null &&
            registrationIdCardBackImage != null;

      case 2:
        return registrationDrivingLicenseFaceImage != null &&
            registrationDrivingLicenseBackImage != null;

      case 3:
        return detailedResidenceAddressFormKey.currentState!.validate();

      case 4:
        return registrationBirthCertificateImage != null &&
            registrationCriminalCheckCertificateImage != null &&
            registrationArmyCertificateImage != null;

      case 5:
        return someOtherPersonalDetailsFormKey.currentState!.validate();
    }
  }
}
