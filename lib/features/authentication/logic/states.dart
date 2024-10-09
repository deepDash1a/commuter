import 'package:commuter/features/authentication/data/login/forget_password_model.dart';
import 'package:commuter/features/authentication/data/login/login_model.dart';
import 'package:commuter/features/authentication/data/register/register_model.dart';

abstract class AuthenticationAppStates {}

class InitializeAuthenticationAppState extends AuthenticationAppStates {}

// States of Login Section
class LoadingLoginAuthenticationAppState extends AuthenticationAppStates {}

class SuccessLoginAuthenticationAppState extends AuthenticationAppStates {
  final LoginModel loginModel;

  SuccessLoginAuthenticationAppState({required this.loginModel});
}

class ErrorLoginAuthenticationAppState extends AuthenticationAppStates {
  final String error;

  ErrorLoginAuthenticationAppState({required this.error});
}

// remember me
class LoadingRememberMeAuthenticationAppState extends AuthenticationAppStates {}

class SuccessRememberMeAuthenticationAppState extends AuthenticationAppStates {
  final String email;
  final String password;

  SuccessRememberMeAuthenticationAppState(
      {required this.email, required this.password});
}

class ErrorRememberMeAuthenticationAppState extends AuthenticationAppStates {
  final String error;

  ErrorRememberMeAuthenticationAppState({required this.error});
}

// forget password
class LoadingForgetPasswordAuthenticationAppState
    extends AuthenticationAppStates {}

class SuccessForgetPasswordAuthenticationAppState
    extends AuthenticationAppStates {
  final ForgetPasswordModel forgetPasswordModel;

  SuccessForgetPasswordAuthenticationAppState(
      {required this.forgetPasswordModel});
}

class ErrorForgetPasswordAuthenticationAppState
    extends AuthenticationAppStates {
  final String error;

  ErrorForgetPasswordAuthenticationAppState({required this.error});
}

class ChangeLoginPasswordVisibility extends AuthenticationAppStates {}

class ChangeLoginRememberMe extends AuthenticationAppStates {}

// States of Register Section
class LoadingRegisterAuthenticationAppState extends AuthenticationAppStates {}

class SuccessRegisterAuthenticationAppState extends AuthenticationAppStates {

}

class ErrorRegisterAuthenticationAppState extends AuthenticationAppStates {
  final String error;

  ErrorRegisterAuthenticationAppState({required this.error});
}

class IncreaseStepsRegistrationAppState extends AuthenticationAppStates {}

class UploadImageState extends AuthenticationAppStates {}
class SelectDateAppState extends AuthenticationAppStates {}

class DecreaseStepsRegistrationAppState extends AuthenticationAppStates {}

class ChangeRegisterPasswordVisibility extends AuthenticationAppStates {}

class ChangeRegisterConfirmPasswordVisibility extends AuthenticationAppStates {}
