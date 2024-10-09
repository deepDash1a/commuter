import 'package:commuter/features/authentication/ui/login/widgets/do_not_have_account.dart';
import 'package:commuter/features/authentication/ui/login/widgets/login_form.dart';
import 'package:commuter/features/authentication/ui/login/widgets/login_image_and_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.00.w,
                vertical: 16.00.h,
              ),
              child: const Column(
                children: [
                  LoginImageAndTitle(),
                  LoginForm(),
                  DoNotHaveAccount(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
