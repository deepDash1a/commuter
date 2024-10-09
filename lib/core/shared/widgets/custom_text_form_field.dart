import 'package:commuter/core/theme/colors/colors.dart';
import 'package:commuter/core/theme/fonts/font_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomTextFormField<T> extends StatelessWidget {
  CustomTextFormField({
    super.key,
    required this.controller,
    required this.validator,
    this.obscureText = false,
    required this.hint,
    this.suffixIcon,
    this.textInputType,
    this.readOnly = false,
  });

  final TextEditingController controller;
  final String? Function(T?) validator;
  bool obscureText;
  bool readOnly;
  final String hint;
  Widget? suffixIcon;
  TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.00.r),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        obscureText: obscureText,
        validator: (value) => validator(value as T?),
        // Cast the value to T
        style: TextStyle(
          fontSize: 16.00.sp,
          fontFamily: FontNamesManager.regular,
          color: ColorsManager.mainAppColor,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 16.00.sp,
            fontFamily: FontNamesManager.bold,
            color: ColorsManager.mainAppColor,
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
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.00.r),
            borderSide: BorderSide(
              color: ColorsManager.mainAppColor,
              width: 1.00.w,
            ),
          ),
        ),
        readOnly: readOnly,
      ),
    );
  }
}
