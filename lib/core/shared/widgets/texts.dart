import 'package:commuter/core/theme/colors/colors.dart';
import 'package:commuter/core/theme/fonts/font_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegularText14dark extends StatelessWidget {
  const RegularText14dark({
    super.key,
    required this.text,
    this.fontSize = 14,
    this.color = ColorsManager.mainAppColor,
    this.textAlign = TextAlign.center,
  });

  final String text;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize.sp,
        fontFamily: FontNamesManager.regular,
        color: color,
      ),
    );
  }
}

class RegularText16dark extends StatelessWidget {
  const RegularText16dark({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.color = ColorsManager.mainAppColor,
    this.textAlign = TextAlign.center,
  });

  final String text;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize.sp,
        fontFamily: FontNamesManager.regular,
        color: color,
      ),
    );
  }
}

class RegularText18dark extends StatelessWidget {
  const RegularText18dark({
    super.key,
    required this.text,
    this.fontSize = 18,
    this.color = ColorsManager.mainAppColor,
    this.textAlign = TextAlign.center,
  });

  final String text;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize.sp,
        fontFamily: FontNamesManager.regular,
        color: color,
      ),
    );
  }
}

class BoldText12dark extends StatelessWidget {
  const BoldText12dark({
    super.key,
    required this.text,
    this.fontSize = 12,
    this.color = ColorsManager.mainAppColor,
    this.textAlign = TextAlign.center,
  });

  final String text;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize.sp,
        fontFamily: FontNamesManager.bold,
        color: color,
      ),
    );
  }
}

class BoldText14dark extends StatelessWidget {
  const BoldText14dark({
    super.key,
    required this.text,
    this.fontSize = 14,
    this.color = ColorsManager.mainAppColor,
    this.textAlign = TextAlign.center,
  });

  final String text;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize.sp,
        fontFamily: FontNamesManager.bold,
        color: color,
      ),
    );
  }
}

class BoldText16dark extends StatelessWidget {
  const BoldText16dark({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.color = ColorsManager.mainAppColor,
    this.textAlign = TextAlign.center,
  });

  final String text;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize.sp,
        fontFamily: FontNamesManager.bold,
        color: color,
      ),
    );
  }
}

class BoldText18dark extends StatelessWidget {
  const BoldText18dark({
    super.key,
    required this.text,
    this.fontSize = 18,
    this.color = ColorsManager.mainAppColor,
    this.textAlign = TextAlign.center,
  });

  final String text;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize.sp,
        fontFamily: FontNamesManager.bold,
        color: color,
      ),
    );
  }
}

class BoldText20dark extends StatelessWidget {
  const BoldText20dark({
    super.key,
    required this.text,
    this.fontSize = 20,
    this.color = ColorsManager.mainAppColor,
    this.textAlign = TextAlign.center,
  });

  final String text;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize.sp,
        fontFamily: FontNamesManager.bold,
        color: color,
      ),
    );
  }
}

class ExtraBoldText12dark extends StatelessWidget {
  const ExtraBoldText12dark({
    super.key,
    required this.text,
    this.fontSize = 12,
    this.color = ColorsManager.mainAppColor,
    this.textAlign = TextAlign.center,
  });

  final String text;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize.sp,
        fontFamily: FontNamesManager.extraBold,
        color: color,
      ),
    );
  }
}

class ExtraBoldText14dark extends StatelessWidget {
  const ExtraBoldText14dark({
    super.key,
    required this.text,
    this.fontSize = 14,
    this.color = ColorsManager.mainAppColor,
    this.textAlign = TextAlign.center,
  });

  final String text;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize.sp,
        fontFamily: FontNamesManager.extraBold,
        color: color,
      ),
    );
  }
}

class ExtraBoldText16dark extends StatelessWidget {
  const ExtraBoldText16dark({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.color = ColorsManager.mainAppColor,
    this.textAlign = TextAlign.center,
  });

  final String text;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize.sp,
        fontFamily: FontNamesManager.extraBold,
        color: color,
      ),
    );
  }
}

class ExtraBoldText18dark extends StatelessWidget {
  const ExtraBoldText18dark({
    super.key,
    required this.text,
    this.fontSize = 18,
    this.color = ColorsManager.mainAppColor,
    this.textAlign = TextAlign.center,
  });

  final String text;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize.sp,
        fontFamily: FontNamesManager.extraBold,
        color: color,
      ),
    );
  }
}

class ExtraBoldText20dark extends StatelessWidget {
  const ExtraBoldText20dark({
    super.key,
    required this.text,
    this.fontSize = 20,
    this.color = ColorsManager.mainAppColor,
    this.textAlign = TextAlign.center,
  });

  final String text;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize.sp,
        fontFamily: FontNamesManager.extraBold,
        color: color,
      ),
    );
  }
}

class ExtraBoldText22dark extends StatelessWidget {
  const ExtraBoldText22dark({
    super.key,
    required this.text,
    this.fontSize = 22,
    this.color = ColorsManager.mainAppColor,
    this.textAlign = TextAlign.center,
  });

  final String text;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize.sp,
        fontFamily: FontNamesManager.extraBold,
        color: color,
      ),
    );
  }
}

class ExtraBoldText25dark extends StatelessWidget {
  const ExtraBoldText25dark({
    super.key,
    required this.text,
    this.fontSize = 25,
    this.color = ColorsManager.mainAppColor,
    this.textAlign = TextAlign.center,
  });

  final String text;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize.sp,
        fontFamily: FontNamesManager.extraBold,
        color: color,
      ),
    );
  }
}
