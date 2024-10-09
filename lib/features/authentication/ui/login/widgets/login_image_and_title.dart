import 'package:commuter/core/shared/widgets/texts.dart';
import 'package:commuter/core/theme/images/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginImageAndTitle extends StatelessWidget {
  const LoginImageAndTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          height: 200.00.h,
          width: double.infinity.w,
          ImagesManager.baseLogo,
        ),
        const ExtraBoldText25dark(
          text: 'تسجيل الدخول',
        ),
        SizedBox(
          height: 20.00.h,
        ),
      ],
    );
  }
}
