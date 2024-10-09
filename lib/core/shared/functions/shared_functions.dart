import 'package:commuter/core/theme/colors/colors.dart';
import 'package:commuter/core/theme/fonts/font_names.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

void customSnackBar({
  required BuildContext context,
  required String text,
  required Color color,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14.00.sp,
          color: ColorsManager.white,
          fontFamily: FontNamesManager.bold,
        ),
      ),
    ),
  );
}

Future uploadImageToApi(XFile image) async {
  return MultipartFile.fromFile(
    image.path,
    filename: image.path.split('/').last,
  );
}
