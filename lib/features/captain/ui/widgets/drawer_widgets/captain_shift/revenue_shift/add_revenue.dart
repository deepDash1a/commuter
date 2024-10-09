import 'dart:io';

import 'package:commuter/core/shared/extensions/nav_extension.dart';
import 'package:commuter/core/shared/functions/shared_functions.dart';
import 'package:commuter/core/shared/widgets/custom_button.dart';
import 'package:commuter/core/shared/widgets/custom_drop_down.dart';
import 'package:commuter/core/shared/widgets/custom_text_button.dart';
import 'package:commuter/core/shared/widgets/custom_text_form_field.dart';
import 'package:commuter/core/shared/widgets/texts.dart';
import 'package:commuter/core/theme/colors/colors.dart';
import 'package:commuter/core/theme/images/images.dart';
import 'package:commuter/features/captain/logic/cubit.dart';
import 'package:commuter/features/captain/logic/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class AddRevenue extends StatelessWidget {
  const AddRevenue({super.key});

  @override
  Widget build(BuildContext context) {
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
        title: const BoldText18dark(
          text: 'أضِف إيراد',
          color: ColorsManager.white,
        ),
      ),
      body: BlocConsumer<CaptainAppCubit, CaptainAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = context.read<CaptainAppCubit>();
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.00.w,
                vertical: 16.00.h,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextButton(
                          text: 'تطبيقات',
                          function: () {
                            cubit.changeAddRevenue(0);
                          },
                        ),
                      ),
                      Expanded(
                        child: CustomTextButton(
                          text: 'رحلات خارجية',
                          function: () {
                            cubit.changeAddRevenue(1);
                          },
                        ),
                      ),
                      // Expanded(
                      //   child: CustomTextButton(
                      //     text: 'دورات',
                      //     function: () {
                      //       cubit.changeAddRevenue(2);
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: 15.00.h,
                  ),
                  Container(
                    width: double.infinity.w,
                    height: 1.00.h,
                    color: ColorsManager.mainAppColor.withOpacity(0.2),
                  ),
                  SizedBox(
                    height: 15.00.h,
                  ),
                  if (cubit.addRevenueNavAppBar == 0)
                    const AddApplicationTripRevenue(),
                  if (cubit.addRevenueNavAppBar == 1)
                    const AddOutSideTripRevenue(),
                  // if (cubit.addRevenueNavAppBar == 2) const AddShiftsRevenue(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class AddApplicationTripRevenue extends StatelessWidget {
  const AddApplicationTripRevenue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CaptainAppCubit, CaptainAppStates>(
      listener: (context, state) {
        if (state is SuccessAddApplicationTripRevenueCaptainAppState) {
          customSnackBar(
            context: context,
            text: 'تم إضافة الإيراد بنجاح',
            color: ColorsManager.green,
          );

          context.read<CaptainAppCubit>().revenueAppNameSelectedValue = null;
          context.read<CaptainAppCubit>().revenueAppTripNumController.clear();
          context
              .read<CaptainAppCubit>()
              .revenueAppTripPaymentValueController
              .clear();
          context.read<CaptainAppCubit>().revenueAppTripPaymentValueImage =
              null;
          context.pop();
          context.read<CaptainAppCubit>().getDailyReport();
        }
        if (state is ErrorAddApplicationTripRevenueCaptainAppState) {
          customSnackBar(
            context: context,
            text: state.message,
            color: ColorsManager.red,
          );
        }
      },
      builder: (context, state) {
        var cubit = context.read<CaptainAppCubit>();
        return Form(
          key: cubit.revenueAppFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: BoldText20dark(
                  text: 'إضافة تطبيقات',
                ),
              ),
              SizedBox(
                height: 25.00.h,
              ),
              CustomDropDownButton(
                hint: const BoldText16dark(
                  text: 'اسم التطبيق',
                ),
                value: cubit.revenueAppNameSelectedValue,
                items: cubit.revenueAppNameList,
                validatorText: 'من فضلك اختر اسم التطبيق',
                onChanged: (value) {
                  cubit.revenueAppNameSelectedValue = value;
                },
              ),
              SizedBox(
                height: 15.00.h,
              ),
              CustomTextButton(
                text: 'إدراج صورة',
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
                                  cubit.revenueAppTripPaymentValueImage =
                                      cubit.pickImageFromDevice(
                                    cubit.revenueAppTripPaymentValueImage,
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
                                  cubit.revenueAppTripPaymentValueImage =
                                      cubit.pickImageFromDevice(
                                    cubit.revenueAppTripPaymentValueImage,
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
              cubit.revenueAppTripPaymentValueImage != null
                  ? Container(
                      width: double.infinity.w,
                      height: 500.00.h,
                      decoration: BoxDecoration(
                        color: ColorsManager.mainAppColor,
                        borderRadius: BorderRadius.circular(
                          16.00.r,
                        ),
                        image: DecorationImage(
                          image: FileImage(
                            File(
                              cubit.revenueAppTripPaymentValueImage!.path,
                            ),
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  : const SizedBox(),
              SizedBox(
                height: 15.00.h,
              ),
              CustomTextFormField(
                controller: cubit.revenueAppTripNumController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'من فضلك أدخل عدد الرحلات';
                  }
                  return null;
                },
                textInputType: TextInputType.number,
                hint: 'عدد رحلات التطبيق',
              ),
              SizedBox(
                height: 15.00.h,
              ),
              CustomTextFormField(
                controller: cubit.revenueAppTripPaymentValueController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'من فضلك أدخل القيمة المالية';
                  }
                  return null;
                },
                textInputType: TextInputType.number,
                hint: 'القيمة المالية',
              ),
              SizedBox(
                height: 30.00.h,
              ),
              state is LoadingAddApplicationTripRevenueCaptainAppState
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Center(
                      child: CustomButton(
                        text: 'إرسال',
                        onPressed: () {
                          if (cubit.revenueAppFormKey.currentState!
                              .validate()) {
                            if (cubit.revenueAppTripPaymentValueImage == null) {
                              customSnackBar(
                                context: context,
                                text:
                                    'من فضلك أدرج صورة الرحلة من التطبيق المُختار',
                                color: ColorsManager.red,
                              );
                            } else {
                              cubit.addApplicationTripRevenue();
                            }
                          }
                        },
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}

class AddOutSideTripRevenue extends StatelessWidget {
  const AddOutSideTripRevenue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CaptainAppCubit, CaptainAppStates>(
      listener: (context, state) {
        if (state is SuccessShiftsRevenueTripCaptainAppState) {
          customSnackBar(
            context: context,
            text: 'تم إضافة الإيراد بنجاح',
            color: ColorsManager.green,
          );

          context
              .read<CaptainAppCubit>()
              .revenueOutsideTripNumController
              .clear();
          context
              .read<CaptainAppCubit>()
              .revenueOutsidePaymentValueController
              .clear();
          context.pop();
          context.read<CaptainAppCubit>().getDailyReport();
        }
        if (state is ErrorShiftsRevenueTripCaptainAppState) {
          customSnackBar(
            context: context,
            text: state.error,
            color: ColorsManager.red,
          );
        }
      },
      builder: (context, state) {
        var cubit = context.read<CaptainAppCubit>();
        return Form(
          key: cubit.revenueOutsideFormKey,
          child: Column(
            children: [
              const Center(
                child: BoldText20dark(
                  text: 'إضافة رحلات خارجية',
                ),
              ),
              SizedBox(
                height: 25.00.h,
              ),
              CustomTextFormField(
                controller: cubit.revenueOutsideTripNumController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'من فضلك أدخل عدد الرحلات الخارجية';
                  }
                  return null;
                },
                textInputType: TextInputType.number,
                hint: 'عدد الرحلات الخارجية',
              ),
              SizedBox(
                height: 15.00.h,
              ),
              CustomTextFormField(
                controller: cubit.revenueOutsidePaymentValueController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'من فضلك أدخل القيمة المالية';
                  }
                  return null;
                },
                textInputType: TextInputType.number,
                hint: 'القيمة المالية',
              ),
              SizedBox(
                height: 30.00.h,
              ),
              state is LoadingShiftsRevenueTripCaptainAppState
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : CustomButton(
                      text: 'إرسال',
                      onPressed: () {
                        if (cubit.revenueOutsideFormKey.currentState!
                            .validate()) {
                          cubit.addRevenueTrip();
                        }
                      },
                    ),
            ],
          ),
        );
      },
    );
  }
}

// class AddShiftsRevenue extends StatelessWidget {
//   const AddShiftsRevenue({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<CaptainAppCubit, CaptainAppStates>(
//       listener: (context, state) {
//         if (state is SuccessAddShiftsRevenueCaptainAppState) {
//           customSnackBar(
//             context: context,
//             text: 'تم إضافة الإيراد بنجاح',
//             color: ColorsManager.green,
//           );
//           context.read<CaptainAppCubit>().revenueNumberSelectedValue = null;
//           context.read<CaptainAppCubit>().revenueTripTypeSelectedValue = null;
//           context.read<CaptainAppCubit>().revenuePaymentSelectedValue = null;
//           context.read<CaptainAppCubit>().revenuePaymentValueController.clear();
//           context.pop();
//           context.read<CaptainAppCubit>().getDailyReport();
//         }
//         if (state is ErrorAddShiftsRevenueCaptainAppState) {
//           customSnackBar(
//             context: context,
//             text: state.error,
//             color: ColorsManager.red,
//           );
//         }
//       },
//       builder: (context, state) {
//         var cubit = context.read<CaptainAppCubit>();
//         return Form(
//           key: cubit.addRevenueFormKey,
//           child: Column(
//             children: [
//               const Center(
//                 child: BoldText20dark(
//                   text: 'إضافة دورات',
//                 ),
//               ),
//               SizedBox(
//                 height: 25.00.h,
//               ),
//               cubit.getAllRevenueCourseLoading
//                   ? const Center(
//                       child: CircularProgressIndicator(),
//                     )
//                   : CustomDropDownButton<RevenueCourseModel>(
//                       hint: const BoldText16dark(
//                         text: 'رقم الدورة',
//                       ),
//                       value: cubit.revenueNumberSelectedValue,
//                       items: cubit.getAllRevenueCourseModel?.body?.map((e) {
//                         return DropdownMenuItem<RevenueCourseModel>(
//                           value: e,
//                           child: RegularText16dark(
//                             text: e.courseNumber.toString(),
//                           ),
//                         );
//                       }).toList(),
//                       validatorText: 'من فضلك اختر رقم الدورة',
//                       onChanged: (value) {
//                         cubit.revenueNumberSelectedValue = value;
//                       },
//                     ),
//               SizedBox(
//                 height: 15.00.h,
//               ),
//               CustomDropDownButton(
//                 hint: const BoldText16dark(
//                   text: 'نوع الرحلة',
//                 ),
//                 value: cubit.revenueTripTypeSelectedValue,
//                 items: cubit.revenueTripTypeList,
//                 validatorText: 'من فضلك اختر نوع الرحلة',
//                 onChanged: (value) {
//                   cubit.revenueTripTypeSelectedValue = value;
//                 },
//               ),
//               SizedBox(
//                 height: 15.00.h,
//               ),
//               CustomDropDownButton(
//                 hint: const BoldText16dark(
//                   text: 'دفع نقدي',
//                 ),
//                 value: cubit.revenuePaymentSelectedValue,
//                 items: cubit.revenuePaymentList,
//                 validatorText: 'من فضلك هذا الحقل مطلوب',
//                 onChanged: (value) {
//                   cubit.revenuePaymentSelectedValue = value;
//                 },
//               ),
//               SizedBox(
//                 height: 15.00.h,
//               ),
//               CustomTextFormField(
//                 controller: cubit.revenuePaymentValueController,
//                 validator: (String? value) {
//                   if (value == null || value.isEmpty) {
//                     return 'من فضلك أدخل القيمة المالية';
//                   }
//                   return null;
//                 },
//                 textInputType: TextInputType.number,
//                 hint: 'القيمة المالية',
//               ),
//               SizedBox(
//                 height: 30.00.h,
//               ),
//               state is LoadingAddShiftsRevenueCaptainAppState
//                   ? const Center(
//                       child: CircularProgressIndicator(),
//                     )
//                   : CustomButton(
//                       text: 'إرسال',
//                       onPressed: () {
//                         if (cubit.addRevenueFormKey.currentState!.validate()) {
//                           cubit.addShiftsRevenue();
//                         }
//                       },
//                     ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
