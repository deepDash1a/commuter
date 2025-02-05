import 'dart:io';

import 'package:commuter/core/shared/extensions/nav_extension.dart';
import 'package:commuter/core/shared/functions/shared_functions.dart';
import 'package:commuter/core/shared/logic/location_helper.dart';
import 'package:commuter/core/shared/logic/shared_pref.dart';
import 'package:commuter/core/shared/logic/shared_pref_keys.dart';
import 'package:commuter/core/shared/widgets/custom_button.dart';
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

// ignore: must_be_immutable
class EndShift extends StatelessWidget {
  EndShift({super.key});

  var endShiftFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Image.asset(
        width: 30.00.w,
        height: 30.00.h,
        ImagesManager.supply,
      ),
      title: const BoldText18dark(
        text: 'نهاية الوردية',
      ),
      backgroundColor: ColorsManager.offWhite,
      children: [
        BlocConsumer<CaptainAppCubit, CaptainAppStates>(
          listener: (context, state) {
            if (state is SuccessEndNewShiftCaptainAppState) {
              customSnackBar(
                context: context,
                text: state.endShiftModel.message!,
                color: ColorsManager.green,
              );
              context
                  .read<CaptainAppCubit>()
                  .endShiftCarMeterController
                  .clear();
              context.read<CaptainAppCubit>().endShiftCarMeterImage = null;
              context.pop();
            }
            if (state is ErrorEndNewShiftCaptainAppState) {
              customSnackBar(
                context: context,
                text: state.error,
                color: ColorsManager.red,
              );
            }
          },
          builder: (context, state) {
            var cubit = context.read<CaptainAppCubit>();
            return SharedPrefService.getData(key: SharedPrefKeys.shiftId) !=
                    null
                ? Form(
                    key: endShiftFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                            cubit.endShiftCarMeterImage =
                                                cubit.pickImageFromDevice(
                                              cubit.endShiftCarMeterImage,
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
                                            cubit.endShiftCarMeterImage =
                                                cubit.pickImageFromDevice(
                                              cubit.endShiftCarMeterImage,
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
                        cubit.endShiftCarMeterImage != null
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
                                        cubit.endShiftCarMeterImage!.path,
                                      ),
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        SizedBox(height: 10.00.h),
                        CustomTextFormField(
                          controller: cubit.endShiftCarMeterController,
                          textInputType: TextInputType.number,
                          hint: 'اكتب نهاية عداد السيارة',
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'من فضلك أدخل عداد السيارة';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.00.h),
                        // add car meter start
                        state is LoadingEndNewShiftCaptainAppState
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Center(
                                child: CustomButton(
                                  text: 'نهاية الوردية',
                                  onPressed: () {
                                    if (endShiftFormKey.currentState!
                                        .validate()) {
                                      if (cubit.endShiftCarMeterImage == null) {
                                        customSnackBar(
                                          context: context,
                                          text: 'من فضلك أدرِج صورة العداد',
                                          color: ColorsManager.red,
                                        );
                                      } else {
                                        cubit.endShift();
                                        LocationUtils.stopLocationTracking();
                                      }
                                    }
                                  },
                                ),
                              ),
                        SizedBox(height: 20.00.h),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 10.00.h,
                      ),
                      const BoldText16dark(text: 'يجب بدء الوردية أولًا'),
                      SizedBox(
                        height: 20.00.h,
                      ),
                    ],
                  );
          },
        )
      ],
    );
  }
}
