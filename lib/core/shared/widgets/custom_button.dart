import 'package:commuter/core/theme/colors/colors.dart';
import 'package:commuter/core/theme/fonts/font_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.prefixIcon,
  });

  final String text;
  final Function onPressed;
  Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(ColorsManager.mainAppColor),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 50.00.w,
          vertical: 12.00.h,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            prefixIcon == null
                ? const SizedBox()
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.00.w),
                    child: prefixIcon,
                  ),
            Text(
              text,
              style: TextStyle(
                fontSize: 16.00.sp,
                fontFamily: FontNamesManager.bold,
                color: ColorsManager.white,
              ),
            ),
          ],
        ),
      ),
      onPressed: () {
        onPressed();
      },
    );
  }
}
