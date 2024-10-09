import 'package:commuter/core/shared/extensions/nav_extension.dart';
import 'package:commuter/core/shared/functions/shared_functions.dart';
import 'package:commuter/core/shared/widgets/custom_button.dart';
import 'package:commuter/core/shared/widgets/custom_text_button.dart';
import 'package:commuter/core/shared/widgets/custom_text_form_field.dart';
import 'package:commuter/core/shared/widgets/texts.dart';
import 'package:commuter/core/theme/colors/colors.dart';
import 'package:commuter/core/theme/fonts/font_names.dart';
import 'package:commuter/core/theme/images/images.dart';
import 'package:commuter/features/authentication/logic/cubit.dart';
import 'package:commuter/features/authentication/logic/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationAppCubit, AuthenticationAppStates>(
      listener: (context, state) {
        if (state is SuccessRegisterAuthenticationAppState) {
          customSnackBar(
            context: context,
            text: 'تم إنشاء حساب جديد بنجاح',
            color: ColorsManager.green,
          );
          context.pop();
        }
        if (state is ErrorRegisterAuthenticationAppState) {
          customSnackBar(
            context: context,
            text: 'حدث خطأ ما أثناء فتح الحساب',
            color: ColorsManager.red,
          );
        }
      },
      builder: (context, state) {
        var cubit = context.read<AuthenticationAppCubit>();

        Widget buildPersonalDetails() {
          return Form(
            key: cubit.personalDetailsFormKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        controller: cubit.registrationFirstNameController,
                        textInputType: TextInputType.name,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'من فضلك أدخل الاسم الأول';
                          }
                          return null;
                        },
                        hint: 'الاسم الأول',
                      ),
                    ),
                    SizedBox(
                      width: 10.00.w,
                    ),
                    Expanded(
                      child: CustomTextFormField(
                        controller: cubit.registrationLastNameController,
                        textInputType: TextInputType.name,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'من فضلك أدخل الاسم الأول';
                          }
                          return null;
                        },
                        hint: 'الاسم الأخير',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.00.h),
                CustomTextFormField(
                  hint: 'رقم الواتساب',
                  controller: cubit.registrationWhatsAppController,
                  textInputType: TextInputType.phone,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'من فضلك أدخل رقم الواتساب';
                    } else if (!RegExp(r'^\d{11}$').hasMatch(value)) {
                      return 'من فضلك أدخل رقم الواتساب بشكل صحيح';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.00.h),
                CustomTextFormField(
                  hint: 'رقم آخر',
                  controller: cubit.registrationAnotherPhoneNumberController,
                  textInputType: TextInputType.phone,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'من فضلك أدخل رقم هاتف آخر';
                    } else if (!RegExp(r'^\d{11}$').hasMatch(value)) {
                      return 'من فضلك أدخل رقم هاتفك بشكل صحيح';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.00.h,
                ),
                CustomTextFormField(
                  controller: cubit.registrationEmailController,
                  textInputType: TextInputType.emailAddress,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'من فضلك أدخل بريدك الإلكتروني';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                        .hasMatch(value)) {
                      return 'من فضلك أدخل بريد إلكتروني صحيح';
                    }
                    return null;
                  },
                  hint: 'البريد الإلكتروني',
                ),
                SizedBox(height: 20.00.h),
                CustomTextFormField(
                  controller: cubit.registrationPasswordController,
                  hint: 'كلمة المرور',
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'من فضلك أدخل كلمة المرور';
                    } else if (!RegExp(r'^(?=.[a-zA-Z].[a-zA-Z]).{8,}$')
                        .hasMatch(value)) {
                      return 'يجب ألا تقل كلمة المرور عن ثمانية حروف وأن تحتوي على حروف أبجدية';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                SizedBox(height: 20.00.h),
                CustomTextFormField(
                  controller: cubit.registrationConfirmPasswordController,
                  hint: 'تأكيد كلمة المرور',
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'من فضلك أكد كلمة المرور';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                SizedBox(height: 20.00.h),
              ],
            ),
          );
        }

        Widget buildIDCardDetails() {
          return Column(
            children: [
              Container(
                width: double.infinity.w,
                decoration: BoxDecoration(
                  color: ColorsManager.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10.00.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.00.w,
                    vertical: 15.00.h,
                  ),
                  child: CustomTextButton(
                    text: cubit.registrationIdCardFaceImage == null
                        ? 'قم بإدراج وجه البطاقة الشخصية'
                        : '✅ تم إدراج وجه البطاقة الشخصية بنجاح',
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
                                      cubit.registrationIdCardFaceImage =
                                          cubit.pickImageFromDevice(
                                        cubit.registrationIdCardFaceImage,
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
                                      imageQuality: 50,
                                    )
                                        .then((value) {
                                      cubit.registrationIdCardFaceImage =
                                          cubit.pickImageFromDevice(
                                        cubit.registrationIdCardFaceImage,
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
              ),
              SizedBox(height: 20.00.h),
              Container(
                width: double.infinity.w,
                decoration: BoxDecoration(
                  color: ColorsManager.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10.00.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.00.w,
                    vertical: 15.00.h,
                  ),
                  child: CustomTextButton(
                    text: cubit.registrationIdCardBackImage == null
                        ? 'قم بإدراج خلفية البطاقة الشخصية'
                        : '✅ تم إدراج خلفية البطاقة الشخصية بنجاح',
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
                                      cubit.registrationIdCardBackImage =
                                          cubit.pickImageFromDevice(
                                        cubit.registrationIdCardBackImage,
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
                                      imageQuality: 50,
                                    )
                                        .then((value) {
                                      cubit.registrationIdCardBackImage =
                                          cubit.pickImageFromDevice(
                                        cubit.registrationIdCardBackImage,
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
              ),
              SizedBox(height: 20.00.h),
            ],
          );
        }

        Widget buildDrivingLicenseDetails() {
          return Column(
            children: [
              Container(
                width: double.infinity.w,
                decoration: BoxDecoration(
                  color: ColorsManager.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10.00.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.00.w,
                    vertical: 15.00.h,
                  ),
                  child: CustomTextButton(
                    text: cubit.registrationDrivingLicenseFaceImage == null
                        ? 'قم بإدراج وجه رخصة القيادة'
                        : '✅ تم إدراج وجه رخصة القيادة بنحاح',
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
                                      cubit.registrationDrivingLicenseFaceImage =
                                          cubit.pickImageFromDevice(
                                        cubit
                                            .registrationDrivingLicenseFaceImage,
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
                                      imageQuality: 50,
                                    )
                                        .then((value) {
                                      cubit.registrationDrivingLicenseFaceImage =
                                          cubit.pickImageFromDevice(
                                        cubit
                                            .registrationDrivingLicenseFaceImage,
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
              ),
              SizedBox(height: 20.00.h),
              Container(
                width: double.infinity.w,
                decoration: BoxDecoration(
                  color: ColorsManager.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10.00.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.00.w,
                    vertical: 15.00.h,
                  ),
                  child: CustomTextButton(
                    text: cubit.registrationDrivingLicenseBackImage == null
                        ? 'قم بإدراج خلفية رخصة القيادة'
                        : '✅ تم إدراج خلفية رخصة القيادة بنجاح',
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
                                      cubit.registrationDrivingLicenseBackImage =
                                          cubit.pickImageFromDevice(
                                        cubit
                                            .registrationDrivingLicenseBackImage,
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
                                      imageQuality: 50,
                                    )
                                        .then((value) {
                                      cubit.registrationDrivingLicenseBackImage =
                                          cubit.pickImageFromDevice(
                                        cubit
                                            .registrationDrivingLicenseBackImage,
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
              ),
              SizedBox(height: 20.00.h),
            ],
          );
        }

        Widget buildDetailedResidenceAddress() {
          return Form(
            key: cubit.detailedResidenceAddressFormKey,
            child: Column(
              children: [
                CustomTextFormField(
                  controller: cubit.registrationGovernorateController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'من فضلك ادخل المحافظة';
                    }
                    return null;
                  },
                  hint: 'المحافظة',
                ),
                SizedBox(height: 20.00.h),
                CustomTextFormField(
                  controller: cubit.registrationCityController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'من فضلك ادخل المدينة';
                    }
                    return null;
                  },
                  hint: 'المدينة',
                ),
                SizedBox(height: 20.00.h),
                CustomTextFormField(
                  controller: cubit.registrationRegionController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'من فضلك ادخل المنطقة';
                    }
                    return null;
                  },
                  hint: 'المنطقة',
                ),
                SizedBox(height: 20.00.h),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CustomTextFormField(
                        controller: cubit.registrationBuildingController,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'من فضلك ادخل العمارة';
                          }
                          return null;
                        },
                        hint: 'العمارة',
                      ),
                    ),
                    SizedBox(width: 10.00.w),
                    Expanded(
                      flex: 1,
                      child: CustomTextFormField(
                        controller: cubit.registrationFloorController,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'من فضلك ادخل الدور';
                          }
                          return null;
                        },
                        hint: 'الدور',
                      ),
                    ),
                    SizedBox(width: 10.00.w),
                    Expanded(
                      flex: 1,
                      child: CustomTextFormField(
                        controller: cubit.registrationFlatController,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'من فضلك ادخل الشقة';
                          }
                          return null;
                        },
                        hint: 'الشقة',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.00.h),
              ],
            ),
          );
        }

        Widget buildPersonalGovernmentCertificates() {
          return Column(
            children: [
              Container(
                width: double.infinity.w,
                decoration: BoxDecoration(
                  color: ColorsManager.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset:
                          const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10.00.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.00.w,
                    vertical: 15.00.h,
                  ),
                  child: CustomTextButton(
                    text: cubit.registrationBirthCertificateImage == null
                        ? 'قم بإدراج شهادة الميلاد'
                        : '✅ تم إدراج شهادة الميلاد بنجاح',
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
                                      cubit.registrationBirthCertificateImage =
                                          cubit.pickImageFromDevice(
                                        cubit
                                            .registrationBirthCertificateImage,
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
                                      imageQuality: 50,
                                    )
                                        .then((value) {
                                      cubit.registrationBirthCertificateImage =
                                          cubit.pickImageFromDevice(
                                        cubit
                                            .registrationBirthCertificateImage,
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
              ),
              SizedBox(height: 20.00.h),
              Container(
                width: double.infinity.w,
                decoration: BoxDecoration(
                  color: ColorsManager.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset:
                          const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10.00.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.00.w,
                    vertical: 15.00.h,
                  ),
                  child: CustomTextButton(
                    text: cubit.registrationCriminalCheckCertificateImage ==
                            null
                        ? 'قم بإدراج صورة الفيش الجنائي'
                        : '✅ تم إدراج صورة الفيش الجنائي بنجاح',
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
                                      cubit.registrationCriminalCheckCertificateImage =
                                          cubit.pickImageFromDevice(
                                        cubit
                                            .registrationCriminalCheckCertificateImage,
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
                                      imageQuality: 50,
                                    )
                                        .then((value) {
                                      cubit.registrationCriminalCheckCertificateImage =
                                          cubit.pickImageFromDevice(
                                        cubit
                                            .registrationCriminalCheckCertificateImage,
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
              ),
              SizedBox(height: 20.00.h),
              Container(
                width: double.infinity.w,
                decoration: BoxDecoration(
                  color: ColorsManager.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset:
                          const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10.00.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.00.w,
                    vertical: 15.00.h,
                  ),
                  child: CustomTextButton(
                    text: cubit.registrationGraduationCertificateImage == null
                        ? 'قم بإدراج صورة شهادة التخرج (إن وجدت)'
                        : '✅ تم إدراج صورة شهادة التخرج بنجاح',
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
                                      cubit.registrationGraduationCertificateImage =
                                          cubit.pickImageFromDevice(
                                        cubit
                                            .registrationGraduationCertificateImage,
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
                                      imageQuality: 50,
                                    )
                                        .then((value) {
                                      cubit.registrationGraduationCertificateImage =
                                          cubit.pickImageFromDevice(
                                        cubit
                                            .registrationGraduationCertificateImage,
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
              ),
              SizedBox(height: 20.00.h),
              Container(
                width: double.infinity.w,
                decoration: BoxDecoration(
                  color: ColorsManager.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset:
                          const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10.00.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.00.w,
                    vertical: 15.00.h,
                  ),
                  child: CustomTextButton(
                    text: cubit.registrationArmyCertificateImage == null
                        ? 'قم بإدراج صورة شهادة الجيش'
                        : '✅ تم إدراج صورة شهادة الجيش بنجاح',
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
                                      cubit.registrationArmyCertificateImage =
                                          cubit.pickImageFromDevice(
                                        cubit
                                            .registrationArmyCertificateImage,
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
                                      imageQuality: 50,
                                    )
                                        .then((value) {
                                      cubit.registrationArmyCertificateImage =
                                          cubit.pickImageFromDevice(
                                        cubit
                                            .registrationArmyCertificateImage,
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
              ),
              SizedBox(height: 20.00.h),
            ],
          );
        }

        Widget buildSomeOtherPersonalDetails() {
          return Form(
            key: cubit.someOtherPersonalDetailsFormKey,
            child: Column(
              children: [
                CustomTextFormField(
                  controller: cubit.registrationWalletNumberController,
                  validator: (String? value) {
                    return null;
                  },
                  hint: 'رقم المحفظة',
                ),
                SizedBox(height: 20.00.h),
                CustomTextFormField(
                  controller: cubit.registrationBankAccountController,
                  validator: (String? value) {
                    return null;
                  },
                  hint: 'الحساب البنكي',
                ),
                SizedBox(height: 20.00.h),
                Container(
                  width: double.infinity.w,
                  decoration: BoxDecoration(
                    color: ColorsManager.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10.00.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.00.w,
                      vertical: 15.00.h,
                    ),
                    child: CustomTextButton(
                      text: cubit.registrationPersonalImage == null
                          ? 'قم بإدراج صورة شخصية لك (إن وجدت)'
                          : '✅ تم إدراج صورة شخصية لك بنجاح',
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
                                        cubit.registrationPersonalImage =
                                            cubit.pickImageFromDevice(
                                          cubit.registrationPersonalImage,
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
                                        imageQuality: 50,
                                      )
                                          .then((value) {
                                        cubit.registrationPersonalImage =
                                            cubit.pickImageFromDevice(
                                          cubit.registrationPersonalImage,
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
                ),
                SizedBox(height: 20.00.h),
                TextFormField(
                  controller: cubit.registrationLicenseExpiryController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'من فضلك اختر التاريخ';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'اختر تاريخ انتهاء رخصة القيادة',
                    hintStyle: TextStyle(
                      fontSize: 16.00.sp,
                      fontFamily: FontNamesManager.regular,
                    ),
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.date_range_outlined,
                      color: ColorsManager.mainAppColor,
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    errorStyle: TextStyle(
                      fontSize: 12.00.sp,
                      color: ColorsManager.red,
                      fontFamily: FontNamesManager.bold,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10.00.h,
                      horizontal: 20.00.w,
                    ),
                  ),
                  readOnly: true,
                  onTap: () {
                    cubit.selectFutureDate(
                        context, cubit.registrationLicenseExpiryController);
                  },
                ),
                SizedBox(height: 20.00.h),
              ],
            ),
          );
        }

        Widget buildStepContent() {
          switch (cubit.registerCurrentStep) {
            case 0:
              return buildPersonalDetails();
            case 1:
              return buildIDCardDetails();
            case 2:
              return buildDrivingLicenseDetails();
            case 3:
              return buildDetailedResidenceAddress();
            case 4:
              return buildPersonalGovernmentCertificates();
            case 5:
              return buildSomeOtherPersonalDetails();

            default:
              return const Center(
                child: BoldText12dark(
                  text: "Unknown Step",
                ),
              );
          }
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: BoldText20dark(
                  text: 'المرحلة رقم ${cubit.registerCurrentStep + 1}'),
            ),
            SizedBox(height: 20.00.h),
            LinearProgressIndicator(
              value: cubit.progressValue(),
            ),
            SizedBox(height: 40.00.h),
            buildStepContent(),
            Row(
              children: [
                cubit.registerCurrentStep == 0
                    ? const SizedBox()
                    : Expanded(
                        flex: 1,
                        child: CustomTextButton(
                          text: 'الرجوع',
                          function: () {
                            cubit.previousStep();
                          },
                        ),
                      ),
                cubit.registerCurrentStep == 0
                    ? const SizedBox()
                    : SizedBox(width: 20.00.w),
                cubit.registerCurrentStep == 5
                    ? const SizedBox()
                    : Expanded(
                        flex: 1,
                        child: CustomTextButton(
                          text: 'التالي',
                          function: () {
                            if (cubit.checkRegisterValid()) {
                              cubit.nextStep();
                            } else {
                              customSnackBar(
                                context: context,
                                text:
                                    'قم بإدخال الحقول المطلوبة كاملة بشرط أن تكون صحيحة',
                                color: ColorsManager.red,
                              );
                            }
                          },
                        ),
                      ),
              ],
            ),
            SizedBox(
              height: 20.00.h,
            ),
            cubit.registerCurrentStep == 5
                ? state is LoadingRegisterAuthenticationAppState
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          CustomButton(
                            text: 'تسجيل',
                            onPressed: () {
                              if (cubit.checkRegisterValid()) {
                                // register function
                                cubit.register();
                              } else {
                                customSnackBar(
                                  context: context,
                                  text:
                                      'قم بإدخال الحقول المطلوبة كاملة بشرط أن تكون صحيحة',
                                  color: ColorsManager.red,
                                );
                              }
                            },
                          ),
                          SizedBox(
                            height: 20.00.h,
                          ),
                        ],
                      )
                : const SizedBox(),
            Container(
              width: double.infinity.w,
              height: 1.00.h,
              color: ColorsManager.mainAppColor.withOpacity(0.3),
            ),
            SizedBox(
              height: 20.00.h,
            ),
          ],
        );
      },
    );
  }
}
