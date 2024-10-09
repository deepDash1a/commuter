import 'package:commuter/features/authentication/ui/register/widgets/already_have_account.dart';
import 'package:commuter/features/authentication/ui/register/widgets/register_form.dart';
import 'package:commuter/features/authentication/ui/register/widgets/register_image_and_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
                  RegisterImageAndTitle(),
                  RegisterForm(),
                  AlreadyHaveAccount(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
