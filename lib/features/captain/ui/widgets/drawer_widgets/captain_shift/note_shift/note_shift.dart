import 'package:commuter/core/shared/extensions/nav_extension.dart';
import 'package:commuter/core/shared/functions/shared_functions.dart';
import 'package:commuter/core/shared/logic/shared_pref.dart';
import 'package:commuter/core/shared/logic/shared_pref_keys.dart';
import 'package:commuter/core/shared/widgets/custom_button.dart';
import 'package:commuter/core/shared/widgets/texts.dart';
import 'package:commuter/core/theme/colors/colors.dart';
import 'package:commuter/core/theme/fonts/font_names.dart';
import 'package:commuter/core/theme/images/images.dart';
import 'package:commuter/features/captain/logic/cubit.dart';
import 'package:commuter/features/captain/logic/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotesShiftTile extends StatelessWidget {
  const NotesShiftTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CaptainAppCubit, CaptainAppStates>(
      listener: (context, state) {
        if (state is SuccessSendNoteCaptainAppState) {
          customSnackBar(
            context: context,
            text: 'تم إرسال ملاحظاتك بنجاح',
            color: Colors.green,
          );
          context.read<CaptainAppCubit>().writeNoteController.clear();
          context.pop();
        }
        if (state is ErrorSendNoteCaptainAppState) {
          customSnackBar(
            context: context,
            text: state.error,
            color: Colors.red,
          );
        }
      },
      builder: (context, state) {
        var cubit = context.read<CaptainAppCubit>();

        return ExpansionTile(
          leading: Image.asset(
            width: 30.00.w,
            height: 30.00.h,
            ImagesManager.note,
          ),
          title: const BoldText18dark(
            text: 'الملاحظات',
          ),
          backgroundColor: ColorsManager.offWhite,
          children: [
            SharedPrefService.getData(key: SharedPrefKeys.shiftId) != null
                ? Form(
                    key: cubit.noteShiftFormKey,
                    child: Column(
                      children: [
                        const BoldText18dark(text: 'اكتب ملاحظاتك:'),
                        SizedBox(height: 10.00.h),
                        TextFormField(
                          style: TextStyle(
                            fontSize: 16.00.sp,
                            fontFamily: FontNamesManager.regular,
                            color: ColorsManager.mainAppColor,
                          ),
                          controller: cubit.writeNoteController,
                          maxLines: 5,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'من فضلك لا يمكن إرسال ملاحظات فارغة';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            errorStyle: TextStyle(
                              fontSize: 12.00.sp,
                              color: ColorsManager.red,
                              fontFamily: FontNamesManager.bold,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.00.r),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.00.h),
                        state is LoadingSendNoteCaptainAppState
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : CustomButton(
                                text: 'إرسال',
                                onPressed: () {
                                  if (cubit.noteShiftFormKey.currentState!
                                      .validate()) {
                                    cubit.sendNote();
                                  }
                                },
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
                      const BoldText16dark(
                          text:
                              'لا يمكن إضافة أي ملاحظات ، يجب بدء الوردية أولًا'),
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
