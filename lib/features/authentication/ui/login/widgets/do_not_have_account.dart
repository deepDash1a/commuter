import 'package:commuter/core/routing/routes.dart';
import 'package:commuter/core/shared/extensions/nav_extension.dart';
import 'package:commuter/core/shared/widgets/texts.dart';
import 'package:commuter/core/theme/colors/colors.dart';
import 'package:flutter/material.dart';

class DoNotHaveAccount extends StatelessWidget {
  const DoNotHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const RegularText16dark(text: 'ليس لديّ حساب'),
        TextButton(
          onPressed: () {
            context.pushName(
              Routes.registerScreen,
            );
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
