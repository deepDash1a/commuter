import 'package:commuter/core/theme/colors/colors.dart';
import 'package:commuter/core/theme/fonts/font_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDownButton<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>>? items;
  final void Function(T?)? onChanged;
  final T? value;
  final String? hintText;
  final String? validatorText;
  final Widget? hint;
  final Widget? prefixIcon;
  final TextStyle? style;

  const CustomDropDownButton({
    super.key,
    this.items,
    this.onChanged,
    this.value,
    this.hintText,
    this.validatorText,
    this.hint,
    this.prefixIcon,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    InputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.00.r),
      borderSide: BorderSide(
        color: ColorsManager.mainAppColor,
        width: 1.w,
      ),
    );
    InputBorder focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(
        color: ColorsManager.mainAppColor,
        width: 1.5.w,
      ),
    );
    InputBorder errorBorderColor = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(
        color: ColorsManager.mainAppColor,
        width: 1.5.w,
      ),
    );
    return DropdownButtonFormField(
      items: items,
      onChanged: onChanged,
      value: value,
      validator: (value) {
        if (value == null || value == '') {
          return validatorText;
        }
        return null;
      },
      isExpanded: true,
      hint: hint,
      style: style,
      padding: EdgeInsets.zero,
      alignment: AlignmentDirectional.centerStart,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        hintStyle: TextStyle(
          fontSize: 16.sp,
          fontFamily: FontNamesManager.regular,
        ),
        border: border,
        contentPadding: EdgeInsetsDirectional.only(
          start: 12.w,
          end: 4.w,
          // bottom: 4.h,
          // top: 4.h,
        ),
        focusedBorder: focusedBorder,
        enabledBorder: border,
        disabledBorder: border,
        errorBorder: errorBorderColor,
        errorStyle: TextStyle(
          fontFamily: FontNamesManager.bold,
          fontSize: 12.00.sp,
          color: ColorsManager.red,
        ),
      ),
      iconSize: 40.r,
    );
  }
}
