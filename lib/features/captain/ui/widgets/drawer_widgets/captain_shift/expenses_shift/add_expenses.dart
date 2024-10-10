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

class AddExpenses extends StatelessWidget {
  const AddExpenses({super.key});

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
          text: 'أضِف مصروفات',
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
                          text: 'التشغيل',
                          function: () {
                            cubit.changeAddExpenses(0);
                          },
                        ),
                      ),
                      Expanded(
                        child: CustomTextButton(
                          text: 'شحن تطبيقات',
                          function: () {
                            cubit.changeAddExpenses(1);
                          },
                        ),
                      ),
                      Expanded(
                        child: CustomTextButton(
                          text: 'مصروفات إضافية',
                          function: () {
                            cubit.changeAddExpenses(2);
                          },
                        ),
                      ),
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
                  if (cubit.addExpensesNavAppBar == 0) ExpensesGaz(),
                  if (cubit.addExpensesNavAppBar == 1) ExpensesAppCharging(),
                  if (cubit.addExpensesNavAppBar == 2) AdditionalExpenses(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class ExpensesGaz extends StatelessWidget {
  ExpensesGaz({
    super.key,
  });

  var expensesGazFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CaptainAppCubit, CaptainAppStates>(
      listener: (context, state) {
        if (state is SuccessExpensesFuelCaptainAppState) {
          customSnackBar(
            context: context,
            text: 'تم إضافة مصروف الوقود بنجاح',
            color: ColorsManager.green,
          );
          context.read<CaptainAppCubit>().expensesGazSelectedValue = null;
          context
              .read<CaptainAppCubit>()
              .expensesGazPaidValueController
              .clear();
          context.read<CaptainAppCubit>().expensesGazImage = null;
          context.pop();
          context.read<CaptainAppCubit>().getDailyReport();
        }
        if (state is ErrorExpensesFuelCaptainAppState) {
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
          key: expensesGazFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25.00.h,
              ),
              CustomDropDownButton(
                hint: const BoldText16dark(
                  text: 'الوقود',
                ),
                value: cubit.expensesGazSelectedValue,
                items: cubit.expensesGazList,
                validatorText: 'من فضلك اختر نوع الوقود',
                onChanged: (value) {
                  cubit.expensesGazSelectedValue = value;
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
                                  cubit.expensesGazImage =
                                      cubit.pickImageFromDevice(
                                    cubit.expensesGazImage,
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
                                  cubit.expensesGazImage =
                                      cubit.pickImageFromDevice(
                                    cubit.expensesGazImage,
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
              cubit.expensesGazImage != null
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
                              cubit.expensesGazImage!.path,
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
                controller: cubit.expensesGazPaidValueController,
                textInputType: TextInputType.number,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'من فضلك أدخل المبلغ المدفوع';
                  }
                  return null;
                },
                hint: 'المبلغ المدفوع',
              ),
              SizedBox(
                height: 30.00.h,
              ),
              state is LoadingExpensesFuelCaptainAppState
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Center(
                      child: CustomButton(
                        text: 'إرسال',
                        onPressed: () {
                          if (expensesGazFormKey.currentState!.validate()) {
                            cubit.addExpensesFuel();
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

// ignore: must_be_immutable
class ExpensesAppCharging extends StatelessWidget {
  ExpensesAppCharging({
    super.key,
  });

  var expensesAppChargeFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CaptainAppCubit, CaptainAppStates>(
      listener: (context, state) {
        if (state is SuccessAddExpensesChargeCaptainAppState) {
          customSnackBar(
            context: context,
            text: 'تم إضافة مصروف شحن بنجاح',
            color: ColorsManager.green,
          );
          context.read<CaptainAppCubit>().expensesAppChargeNameSelectedValue =
              null;
          context.read<CaptainAppCubit>().expensesAppChargePaidValue.clear();
          context.read<CaptainAppCubit>().expensesAppChargeImage = null;
          context.pop();
          context.read<CaptainAppCubit>().getDailyReport();
        }
        if (state is ErrorAddExpensesChargeCaptainAppState) {
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
          key: expensesAppChargeFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25.00.h,
              ),
              CustomDropDownButton(
                hint: const BoldText16dark(
                  text: 'اسم التطبيق',
                ),
                value: cubit.expensesAppChargeNameSelectedValue,
                items: cubit.expensesAppChargeNameList,
                validatorText: 'من فضلك اختر اسم التطبيق',
                onChanged: (value) {
                  cubit.expensesAppChargeNameSelectedValue = value;
                },
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
                                  cubit.expensesAppChargeImage =
                                      cubit.pickImageFromDevice(
                                    cubit.expensesAppChargeImage,
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
                                  cubit.expensesAppChargeImage =
                                      cubit.pickImageFromDevice(
                                    cubit.expensesAppChargeImage,
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
              cubit.expensesAppChargeImage != null
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
                              cubit.expensesAppChargeImage!.path,
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
                controller: cubit.expensesAppChargePaidValue,
                textInputType: TextInputType.number,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'من فضلك أدخل المبلغ المدفوع';
                  }

                  return null;
                },
                hint: 'المبلغ المدفوع',
              ),
              SizedBox(
                height: 30.00.h,
              ),
              state is LoadingAddExpensesChargeCaptainAppState
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Center(
                      child: CustomButton(
                        text: 'إرسال',
                        onPressed: () {
                          if (expensesAppChargeFormKey.currentState!
                              .validate()) {
                            if (cubit.expensesAppChargeImage == null) {
                              customSnackBar(
                                context: context,
                                text: 'من فضلك أدرج صورة الشحن',
                                color: ColorsManager.red,
                              );
                            } else {
                              cubit.addExpensesCharge();
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

// ignore: must_be_immutable
class AdditionalExpenses extends StatelessWidget {
  AdditionalExpenses({
    super.key,
  });

  var anotherExpensesFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CaptainAppCubit, CaptainAppStates>(
      listener: (context, state) {
        if (state is SuccessAddShiftsExpensesCaptainAppState) {
          customSnackBar(
            context: context,
            text: 'تم إضافة مصروف إضافي بنجاح',
            color: ColorsManager.green,
          );
          context.read<CaptainAppCubit>().expensesItemTypeController.clear();
          context.read<CaptainAppCubit>().expensesPaidCostController.clear();
          context.read<CaptainAppCubit>().expensesAnotherImage = null;
          context.pop();
          context.read<CaptainAppCubit>().getDailyReport();
        }
        if (state is ErrorAddShiftsExpensesCaptainAppState) {
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
          key: anotherExpensesFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25.00.h,
              ),
              CustomTextFormField(
                controller: cubit.expensesItemTypeController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'من فضلك أدخل نوع البند';
                  }

                  return null;
                },
                hint: 'نوع البند',
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
                                  cubit.expensesAnotherImage =
                                      cubit.pickImageFromDevice(
                                    cubit.expensesAnotherImage,
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
                                  cubit.expensesAnotherImage =
                                      cubit.pickImageFromDevice(
                                    cubit.expensesAnotherImage,
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
              cubit.expensesAnotherImage != null
                  ? Container(
                      width: double.infinity.w,
                      height: 150.00.h,
                      decoration: BoxDecoration(
                        color: ColorsManager.mainAppColor,
                        borderRadius: BorderRadius.circular(
                          16.00.r,
                        ),
                        image: DecorationImage(
                          image: FileImage(
                            File(
                              cubit.expensesAnotherImage!.path,
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
                controller: cubit.expensesPaidCostController,
                textInputType: TextInputType.number,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'من فضلك أدخل المبلغ المدفوع';
                  }

                  return null;
                },
                hint: 'المبلغ المدفوع',
              ),
              SizedBox(
                height: 30.00.h,
              ),
              state is LoadingAddShiftsExpensesCaptainAppState
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Center(
                      child: CustomButton(
                        text: 'إرسال',
                        onPressed: () {
                          if (anotherExpensesFormKey.currentState!.validate()) {
                            if (cubit.expensesAnotherImage == null) {
                              customSnackBar(
                                context: context,
                                text:
                                    'من فضلك أدرج صورة البند أو المبلغ المدفوع',
                                color: ColorsManager.red,
                              );
                            } else {
                              cubit.addAdditionalExpenses();
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
