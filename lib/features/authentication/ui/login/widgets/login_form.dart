import 'package:commuter/core/routing/routes.dart';
import 'package:commuter/core/shared/extensions/nav_extension.dart';
import 'package:commuter/core/shared/functions/shared_functions.dart';
import 'package:commuter/core/shared/logic/shared_pref.dart';
import 'package:commuter/core/shared/logic/shared_pref_keys.dart';
import 'package:commuter/core/shared/widgets/custom_button.dart';
import 'package:commuter/core/shared/widgets/custom_text_button.dart';
import 'package:commuter/core/shared/widgets/custom_text_form_field.dart';
import 'package:commuter/core/shared/widgets/texts.dart';
import 'package:commuter/core/theme/colors/colors.dart';
import 'package:commuter/features/authentication/logic/cubit.dart';
import 'package:commuter/features/authentication/logic/states.dart';
import 'package:commuter/features/authentication/ui/waiting/waiting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationAppCubit, AuthenticationAppStates>(
      listener: (context, state) {
        if (state is SuccessLoginAuthenticationAppState) {
          customSnackBar(
            context: context,
            text: 'تم تسجيل الدخول بنجاح',
            color: ColorsManager.green,
          );

          context.read<AuthenticationAppCubit>().loginEmailController.clear();
          context.read<AuthenticationAppCubit>().loginPasswordController.clear();
          context.read<AuthenticationAppCubit>().loginIsRemembered = false;
          if (SharedPrefService.getData(key: SharedPrefKeys.captainStatus) ==
              'تم الموافقة') {
            context.pushReplacementNamed(Routes.captainDashBoardScreen);
          } else {
            SharedPrefService.removeData(key: SharedPrefKeys.token);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const WaitingScreen(),
              ),
              (route) => false,
            );
          }
        }
        if (state is ErrorLoginAuthenticationAppState) {
          customSnackBar(
            context: context,
            text: 'حدث خطأ ما، يرجى إعادة المحاولة',
            color: ColorsManager.red,
          );
          context.read<AuthenticationAppCubit>().changeLoginRememberMe(false);
        }
        if (state is ErrorRememberMeAuthenticationAppState) {
          customSnackBar(
            context: context,
            text: state.error,
            color: ColorsManager.red,
          );
          context.read<AuthenticationAppCubit>().changeLoginRememberMe(false);
        }
        if (state is SuccessForgetPasswordAuthenticationAppState) {
          context.pop();
          customSnackBar(
            context: context,
            text:
                'لقد أرسلنا لك رابط إعادة تعيين كلمة المرور عبر البريد الإلكتروني!',
            color: ColorsManager.green,
          );
        }
        if (state is ErrorForgetPasswordAuthenticationAppState) {
          context.pop();
          customSnackBar(
            context: context,
            text: 'لم نتمكن من العثور على مستخدم بهذا العنوان الإلكتروني.',
            color: ColorsManager.red,
          );
          context
              .read<AuthenticationAppCubit>()
              .forgetPasswordEmailController
              .clear();
        }
      },
      builder: (context, state) {
        var cubit = context.read<AuthenticationAppCubit>();
        return Form(
          key: cubit.loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormField(
                controller: cubit.loginEmailController,
                hint: 'البريد الإلكتروني',
                textInputType: TextInputType.emailAddress,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'من فضلك أدخل بريدك الإلكتروني';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'من فضلك أدخل بريد إلكتروني صحيح';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20.00.h,
              ),
              CustomTextFormField(
                controller: cubit.loginPasswordController,
                hint: 'كلمة المرور',
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'من فضلك أدخل كلمة المرور';
                  }
                  return null;
                },
                obscureText: cubit.isLoginObscureTextPassword,
                textInputType: TextInputType.visiblePassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    cubit.changeLoginPasswordVisibility();
                  },
                  icon: cubit.isLoginObscureTextPassword
                      ? const Icon(
                          Icons.visibility_outlined,
                          color: ColorsManager.mainAppColor,
                        )
                      : const Icon(
                          Icons.visibility_off_outlined,
                          color: ColorsManager.mainAppColor,
                        ),
                ),
              ),
              SizedBox(
                height: 10.00.h,
              ),
              Row(
                children: [
                  Checkbox(
                    value: cubit.loginIsRemembered,
                    onChanged: cubit.changeLoginRememberMe,
                  ),
                  const RegularText16dark(text: 'تذكرني'),
                ],
              ),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const BoldText16dark(text: 'قم بتغير كلمة المرور'),
                      content: Form(
                        key: cubit.forgetPasswordFormKey,
                        child: CustomTextFormField(
                          controller: cubit.forgetPasswordEmailController,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'من فضلك أدخل بريدك الإلكتروني';
                            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return 'من فضلك أدخل بريد إلكتروني صحيح';
                            }
                            return null;
                          },
                          hint: 'أدخل بريدك الإلكتروني',
                        ),
                      ),
                      actions: [
                        state is LoadingForgetPasswordAuthenticationAppState
                            ? const CircularProgressIndicator()
                            : CustomTextButton(
                                text: 'إرسال',
                                function: () {
                                  if (cubit.forgetPasswordFormKey.currentState!
                                      .validate()) {
                                    cubit.forgetPassword();
                                    context.pop();
                                    cubit.forgetPasswordEmailController.clear();
                                  }
                                },
                              )
                      ],
                    ),
                  );
                },
                child: const BoldText16dark(
                  text: 'هل نسيت كلمة المرور؟',
                  color: ColorsManager.secondaryAppColor,
                ),
              ),
              SizedBox(
                height: 8.00.h,
              ),
              state is LoadingLoginAuthenticationAppState
                  ? const Center(child: CircularProgressIndicator())
                  : Center(
                      child: CustomButton(
                        text: 'تسجيل الدخول',
                        onPressed: () {
                          if (cubit.loginFormKey.currentState!.validate()) {
                            cubit.login();
                          }
                        },
                      ),
                    ),
              SizedBox(
                height: 40.00.h,
              ),
              Container(
                width: double.infinity.w,
                height: 1.00.h,
                color: ColorsManager.mainAppColor.withOpacity(0.3),
              ),
              SizedBox(
                height: 20.00.h,
              ),
            ],
          ),
        );
      },
    );
  }
}
