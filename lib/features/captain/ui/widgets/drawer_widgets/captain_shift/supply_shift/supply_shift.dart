import 'dart:io';

import 'package:commuter/core/shared/extensions/nav_extension.dart';
import 'package:commuter/core/shared/functions/shared_functions.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class SupplyShift extends StatelessWidget {
  SupplyShift({super.key});

  var supplyFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CaptainAppCubit, CaptainAppStates>(
      listener: (context, state) {
        if (state is SuccessAddSuppliersCaptainAppState) {
          customSnackBar(
            context: context,
            text: 'تم إضافة المورد بنجاح!',
            color: ColorsManager.green,
          );
          context.read<CaptainAppCubit>().getAllSuppliersModel;
          context.read<CaptainAppCubit>().supplierNameController.clear();
          context.read<CaptainAppCubit>().suppliedAmountCostController.clear();
          context.read<CaptainAppCubit>().supplyMethodSelectedValue = null;
          context.read<CaptainAppCubit>().supplyMethodImage = null;
          context.pop();
        }
        if (state is ErrorAddSuppliersCaptainAppState) {
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
            ImagesManager.supply,
          ),
          title: const BoldText18dark(
            text: 'التوريد',
          ),
          backgroundColor: ColorsManager.offWhite,
          children: [
            SharedPrefService.getData(key: SharedPrefKeys.shiftId) != null
                ? Form(
                    key: supplyFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormField(
                          controller: cubit.supplierNameController,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'من فضلك أدخل اسم المورد إليه';
                            }
                            return null;
                          },
                          hint: ' اسم المورد إليه',
                          textInputType: TextInputType.name,
                        ),
                        SizedBox(
                          height: 15.00.h,
                        ),
                        CustomTextFormField(
                          controller: cubit.suppliedAmountCostController,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'من فضلك أدخل المبلغ المدفوع';
                            }
                            return null;
                          },
                          hint: 'المبلغ المورد',
                          textInputType: TextInputType.number,
                        ),
                        SizedBox(
                          height: 15.00.h,
                        ),
                        CustomDropDownButton(
                          hint: const BoldText16dark(
                            text: 'طريقة التوريد',
                          ),
                          value: cubit.supplyMethodSelectedValue,
                          items: cubit.supplyMethodList,
                          validatorText: 'من فضلك اختر طريقة التوريد',
                          onChanged: (value) {
                            cubit.changeSupplyMethodSelectedValue(value);
                          },
                        ),
                        SizedBox(
                          height: 15.00.h,
                        ),
                        if (cubit.supplyMethodSelectedValue != 'كاش' &&
                            cubit.supplyMethodSelectedValue != null)
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
                                            )
                                                .then((value) {
                                              cubit.supplyMethodImage =
                                                  cubit.pickImageFromDevice(
                                                cubit.supplyMethodImage,
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
                                              cubit.supplyMethodImage =
                                                  cubit.pickImageFromDevice(
                                                cubit.supplyMethodImage,
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
                        cubit.supplyMethodImage != null
                            ? Container(
                                width: double.infinity.w,
                                height: 400.00.h,
                                decoration: BoxDecoration(
                                  color: ColorsManager.mainAppColor,
                                  borderRadius: BorderRadius.circular(
                                    16.00.r,
                                  ),
                                  image: DecorationImage(
                                    image: FileImage(
                                      File(
                                        cubit.supplyMethodImage!.path,
                                      ),
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        SizedBox(
                          height: 20.00.h,
                        ),
                        state is LoadingAddSuppliersCaptainAppState
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Center(
                                child: CustomButton(
                                  text: 'إرسال',
                                  onPressed: () {
                                    if (supplyFormKey.currentState!
                                        .validate()) {
                                      if (cubit.supplyMethodSelectedValue ==
                                          'كاش') {
                                        cubit.addSuppliers();
                                      } else {
                                        if (cubit.supplyMethodImage == null) {
                                          customSnackBar(
                                            context: context,
                                            text:
                                                'من فضلك قم بإدراج صورة التوريد',
                                            color: ColorsManager.red,
                                          );
                                        } else {
                                          cubit.addSuppliers();
                                        }
                                      }
                                    }
                                  },
                                ),
                              ),
                        SizedBox(
                          height: 15.00.h,
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 10.00.h,
                      ),
                      const BoldText16dark(
                          text: 'لا توجد أي توريد ، يجب بدء الوردية أولًا'),
                      SizedBox(
                        height: 20.00.h,
                      ),
                    ],
                  ),
          ],
        );
      },
    );
  }
}
