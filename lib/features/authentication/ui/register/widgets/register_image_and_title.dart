import 'package:commuter/core/shared/widgets/texts.dart';
import 'package:commuter/core/theme/images/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterImageAndTitle extends StatelessWidget {
  const RegisterImageAndTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          height: 200.00.h,
          width: double.infinity.w,
          ImagesManager.baseLogo,
        ),
        const ExtraBoldText25dark(text: 'تسجيل حساب جديد'),
        SizedBox(
          height: 30.00.h,
        ),
      ],
    );
  }
}
