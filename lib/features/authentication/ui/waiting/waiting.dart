import 'package:commuter/core/routing/routes.dart';
import 'package:commuter/core/shared/extensions/nav_extension.dart';
import 'package:commuter/core/shared/widgets/custom_text_button.dart';
import 'package:commuter/core/shared/widgets/texts.dart';
import 'package:commuter/core/theme/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({super.key});

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity.w,
                decoration: BoxDecoration(
                  color: ColorsManager.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10.00.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.00.w,
                    vertical: 15.00.h,
                  ),
                  child: const Center(
                    child: RegularText16dark(
                      text: 'الانتظار لحين الانتهاء من مراجعة بياناتك',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.00.h,
              ),
              CustomTextButton(
                text: 'تسجيل الخروج',
                function: () {
                  context.pushNamedAndRemoveUntil(
                    Routes.loginScreen,
                    predicate: (Route<dynamic> route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
