import 'package:commuter/core/shared/widgets/texts.dart';
import 'package:commuter/core/theme/colors/colors.dart';
import 'package:flutter/material.dart';

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const RegularText16dark(text: 'لديّ حساب بالفعل'),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const BoldText14dark(
            text: 'سجل الآن',
            color: ColorsManager.secondaryAppColor,
          ),
        ),
      ],
    );
  }
}
