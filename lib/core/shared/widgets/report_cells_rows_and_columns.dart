import 'package:commuter/core/theme/colors/colors.dart';
import 'package:commuter/core/theme/fonts/font_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportRow extends StatelessWidget {
  const ReportRow({
    super.key,
    required this.cell1,
    required this.cell2,
    this.cell3 = '',
  });

  final String cell1;
  final String cell2;
  final String cell3;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.00.h),
        Row(
          children: [
            ReportCell(text: cell1),
            ReportCell(text: cell2),
            if (cell3 != '') ReportCell(text: cell3),
          ],
        ),
        SizedBox(height: 10.00.h),
        Container(
          height: 1.00.h,
          width: double.infinity.w,
          color: ColorsManager.mainAppColor.withOpacity(0.2),
        ),
      ],
    );
  }
}

class ReportCell extends StatelessWidget {
  const ReportCell({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.00.sp,
            fontFamily: FontNamesManager.bold,
          ),
        ),
      ),
    );
  }
}
