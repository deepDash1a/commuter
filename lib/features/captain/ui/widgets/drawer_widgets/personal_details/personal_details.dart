import 'dart:io';

import 'package:commuter/core/routing/routes.dart';
import 'package:commuter/core/shared/extensions/nav_extension.dart';
import 'package:commuter/core/shared/functions/shared_functions.dart';
import 'package:commuter/core/shared/widgets/custom_text_button.dart';
import 'package:commuter/core/shared/widgets/custom_text_form_field.dart';
import 'package:commuter/core/shared/widgets/texts.dart';
import 'package:commuter/core/theme/colors/colors.dart';
import 'package:commuter/core/theme/fonts/font_names.dart';
import 'package:commuter/core/theme/images/images.dart';
import 'package:commuter/features/captain/logic/cubit.dart';
import 'package:commuter/features/captain/logic/states.dart';
import 'package:commuter/features/captain/ui/screens/captain_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

//ignore: must_be_immutable
class PersonalDetails extends StatelessWidget {
  PersonalDetails({super.key});

  var personalFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CaptainAppCubit>();
    return BlocConsumer<CaptainAppCubit, CaptainAppStates>(
      listener: (context, state) {
        if (state is SuccessUpdateProfilePersonalDetailsAppState) {
          customSnackBar(
            context: context,
            text: 'تم تغيير البيانات الشخصية بنجاح',
            color: ColorsManager.green,
          );
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const CaptainDashboardScreen()));
        }
        if (state is SuccessLogoutAppState) {
          customSnackBar(
            context: context,
            text: 'تم تسجيل الخروج بنجاح',
            color: ColorsManager.green,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: ColorsManager.white,
                size: 20.00,
              ),
            ),
            title: Text(
              'الصفحة الشخصية',
              style: TextStyle(
                  fontSize: 18.00.sp,
                  fontFamily: FontNamesManager.bold,
                  color: ColorsManager.white),
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.00.w,
                  vertical: 16.00.h,
                ),
                child: Form(
                  key: personalFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              radius: 63.5.r,
                              backgroundColor: ColorsManager.green,
                            ),
                            CircleAvatar(
                              radius: 60.00.r,
                              backgroundColor: ColorsManager.mainAppColor,
                              backgroundImage: cubit.personalImage != null
                                  ? FileImage(File(cubit.personalImage!.path))
                                  : const NetworkImage(
                                      'https://img.freepik.com/free-photo/bohemian-man-with-his-arms-crossed_1368-3542.jpg?t=st=1727959977~exp=1727963577~hmac=6f403b7098c561ccf9bd6fa35823f8a48ec35ed49cd24fffc41f7dfc3365f93a&w=826',
                                    ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: CustomTextButton(
                          text: 'تعديل الصورة',
                          function: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const BoldText16dark(text: 'اختر'),
                                content: Row(
                                  children: [
                                    Expanded(
                                      child: IconButton(
                                        onPressed: () {
                                          ImagePicker()
                                              .pickImage(
                                            source: ImageSource.camera,
                                            imageQuality: 50,
                                          )
                                              .then((value) {
                                            cubit.personalImage =
                                                cubit.pickImageFromDevice(
                                              cubit.personalImage,
                                              value!,
                                            );
                                          });
                                          context.pop();
                                        },
                                        icon: Image.asset(
                                          width: 40.00.w,
                                          height: 40.00.h,
                                          ImagesManager.camera,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: IconButton(
                                        onPressed: () {
                                          ImagePicker()
                                              .pickImage(
                                            source: ImageSource.gallery,
                                          )
                                              .then((value) {
                                            cubit.personalImage =
                                                cubit.pickImageFromDevice(
                                              cubit.personalImage,
                                              value!,
                                            );
                                          });
                                          context.pop();
                                        },
                                        icon: Image.asset(
                                          width: 40.00.w,
                                          height: 40.00.h,
                                          ImagesManager.gallery,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.00.h,
                      ),
                      const Center(
                          child: ExtraBoldText20dark(text: 'البيانات الشخصية')),
                      SizedBox(
                        height: 30.00.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                const BoldText14dark(text: 'الاسم الأول'),
                                SizedBox(
                                  height: 10.00.h,
                                ),
                                CustomTextFormField(
                                  controller: cubit.personalFirstNameController,
                                  validator: (String? value) {
                                    return null;
                                  },
                                  hint: '',
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 8.00.w,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const BoldText14dark(text: 'الاسم الأخير'),
                                SizedBox(
                                  height: 10.00.h,
                                ),
                                CustomTextFormField(
                                  controller: cubit.personalLastNameController,
                                  validator: (String? value) {
                                    return null;
                                  },
                                  hint: '',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.00.h,
                      ),
                      const BoldText14dark(text: 'البريد الإلكتروني'),
                      SizedBox(
                        height: 10.00.h,
                      ),
                      CustomTextFormField(
                        controller: cubit.personalEmailController,
                        validator: (String? value) {
                          return null;
                        },
                        hint: 'البريد الإلكتروني',
                        readOnly: true,
                      ),
                      SizedBox(
                        height: 20.00.h,
                      ),
                      const BoldText14dark(text: 'رقم الواتساب'),
                      SizedBox(
                        height: 10.00.h,
                      ),
                      CustomTextFormField(
                        controller: cubit.personalWhatsAppController,
                        validator: (String? value) {
                          return null;
                        },
                        hint: '',
                      ),
                      SizedBox(
                        height: 20.00.h,
                      ),
                      const BoldText14dark(text: 'رقم الآخر'),
                      SizedBox(
                        height: 10.00.h,
                      ),
                      CustomTextFormField(
                        controller: cubit.personalAnotherNumberController,
                        validator: (String? value) {
                          return null;
                        },
                        hint: '',
                      ),
                      SizedBox(
                        height: 20.00.h,
                      ),
                      const BoldText14dark(text: 'العنوان بالتفصيل'),
                      SizedBox(
                        height: 10.00.h,
                      ),
                      CustomTextFormField(
                        controller: cubit.personalAddressController,
                        validator: (String? value) {
                          return null;
                        },
                        hint: '',
                      ),
                      SizedBox(
                        height: 20.00.h,
                      ),
                      const BoldText14dark(text: 'حالة الحساب'),
                      SizedBox(
                        height: 10.00.h,
                      ),
                      CustomTextFormField(
                        controller: cubit.personalStatus,
                        validator: (String? value) {
                          return null;
                        },
                        hint: '',
                        readOnly: true,
                      ),
                      SizedBox(
                        height: 20.00.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextButton(
                                text: 'تعديل',
                                function: () {
                                  if (personalFormKey.currentState!
                                      .validate()) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        content: const BoldText14dark(
                                            text:
                                                'هل أنت متأكد من تغيير بياناتك الشخصية ؟'),
                                        actions: [
                                          CustomTextButton(
                                            text: 'موافق',
                                            function: () {
                                              cubit.updatePersonalData();
                                            },
                                          ),
                                          CustomTextButton(
                                            text: 'إلغاء',
                                            function: () {
                                              context.pop();
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                }),
                          ),
                          Expanded(
                            child: CustomTextButton(
                              text: 'تسجيل الخروج',
                              function: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: const BoldText14dark(
                                        text:
                                            'هل أنت متأكد من رغبتك ف الخروج ؟'),
                                    actions: [
                                      CustomTextButton(
                                        text: 'موافق',
                                        function: () {
                                          context.pushNamedAndRemoveUntil(
                                            Routes.loginScreen,
                                            predicate: (Route<dynamic> route) => false,
                                          );
                                        },
                                      ),
                                      CustomTextButton(
                                        text: 'إلغاء',
                                        function: () {
                                          context.pop();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
