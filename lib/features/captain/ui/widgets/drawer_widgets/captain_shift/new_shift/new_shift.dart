//ignore: must_be_immutable
import 'dart:io';

import 'package:commuter/core/shared/extensions/nav_extension.dart';
import 'package:commuter/core/shared/functions/shared_functions.dart';
import 'package:commuter/core/shared/logic/location_helper.dart';
import 'package:commuter/core/shared/logic/shared_pref.dart';
import 'package:commuter/core/shared/logic/shared_pref_keys.dart';
import 'package:commuter/core/shared/widgets/custom_button.dart';
import 'package:commuter/core/shared/widgets/custom_drop_down.dart';
import 'package:commuter/core/shared/widgets/custom_text_button.dart';
import 'package:commuter/core/shared/widgets/custom_text_form_field.dart';
import 'package:commuter/core/shared/widgets/texts.dart';
import 'package:commuter/core/theme/colors/colors.dart';
import 'package:commuter/core/theme/images/images.dart';
import 'package:commuter/features/captain/logic/cubit.dart';
import 'package:commuter/features/captain/logic/states.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class NewShift extends StatelessWidget {
  const NewShift({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CaptainAppCubit, CaptainAppStates>(
      listener: (context, state) {
        if (state is SuccessStartNewShiftCaptainAppState) {
          customSnackBar(
            context: context,
            text: state.newShiftModel.message!,
            color: ColorsManager.green,
          );
          context.read<CaptainAppCubit>().selectedCarTypeValue = null;
          context.read<CaptainAppCubit>().newShiftImage = null;
          context.read<CaptainAppCubit>().carMeterNewShiftController.clear();
          SharedPrefService.saveData(
            key: SharedPrefKeys.checkBreakOrResume,
            value: 0,
          );
          context.read<CaptainAppCubit>().getAllRevenueCourse();
          context.read<CaptainAppCubit>().getDailyReport();
        }
        if (state is ErrorStartNewShiftCaptainAppState) {
          customSnackBar(
            context: context,
            text: state.error,
            color: ColorsManager.red,
          );
        }
      },
      builder: (context, state) {
        var cubit = context.read<CaptainAppCubit>();
        return ExpansionTile(
          leading: Image.asset(
            width: 30.00.w,
            height: 30.00.h,
            ImagesManager.cars,
          ),
          title: const BoldText18dark(
            text: 'بداية الوردية',
          ),
          backgroundColor: ColorsManager.offWhite,
          children: [
            SharedPrefService.getData(key: SharedPrefKeys.shiftId) != null
                ? Column(
                    children: [
                      SizedBox(
                        height: 10.00.h,
                      ),
                      const BoldText16dark(text: 'تم بدء الوردية'),
                      SizedBox(
                        height: 20.00.h,
                      ),
                    ],
                  )
                : Form(
                    key: cubit.newShiftFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // choose type of car
                        cubit.getAllCarsLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : CustomDropDownButton<int>(
                                hint: const BoldText16dark(
                                  text: 'اختر السيارة',
                                ),
                                value: cubit.selectedCarTypeValue,
                                items:
                                    cubit.getAllCarTypesModel?.body?.map((e) {
                                  return DropdownMenuItem<int>(
                                    value: e.carTypeId,
                                    child: RegularText16dark(
                                      text: e.carType.toString(),
                                    ),
                                  );
                                }).toList(),
                                validatorText: 'من فضلك اختر السيارة',
                                onChanged: (value) {
                                  cubit.selectedCarTypeValue = value;
                                  if (kDebugMode) {
                                    print(cubit.selectedCarTypeValue);
                                  }
                                },
                              ),
                        SizedBox(height: 10.00.h),
                        // add car meter start
                        CustomTextButton(
                          text: 'إدراج صورة العداد',
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
                                            cubit.newShiftImage =
                                                cubit.pickImageFromDevice(
                                              cubit.newShiftImage,
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
                                            cubit.newShiftImage =
                                                cubit.pickImageFromDevice(
                                              cubit.newShiftImage,
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
                        cubit.newShiftImage != null
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
                                        cubit.newShiftImage!.path,
                                      ),
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        SizedBox(height: 10.00.h),
                        CustomTextFormField(
                          controller: cubit.carMeterNewShiftController,
                          textInputType: TextInputType.number,
                          hint: 'اكتب بداية عداد السيارة',
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'من فضلك أدخل عداد السيارة';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.00.h),
                        SizedBox(height: 10.00.h),
                        state is LoadingStartNewShiftCaptainAppState
                            ? const Center(child: CircularProgressIndicator())
                            : Center(
                                child: CustomButton(
                                  text: 'بدء الوردية',
                                  onPressed: () {
                                    if (cubit.newShiftFormKey.currentState!
                                        .validate()) {
                                      if (cubit.newShiftImage == null) {
                                        customSnackBar(
                                          context: context,
                                          text: 'من فضلك أدرِج صورة العداد',
                                          color: ColorsManager.red,
                                        );
                                      } else {
                                        cubit.startShift();
                                        LocationUtils.streamLocation();
                                      }
                                    }
                                  },
                                ),
                              ),
                        SizedBox(height: 20.00.h),
                      ],
                    ),
                  ),
          ],
        );
      },
    );
  }
}
