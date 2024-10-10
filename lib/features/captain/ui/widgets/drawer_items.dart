import 'package:commuter/core/shared/extensions/nav_extension.dart';
import 'package:commuter/core/shared/widgets/texts.dart';
import 'package:commuter/core/theme/colors/colors.dart';
import 'package:commuter/core/theme/images/images.dart';
import 'package:commuter/features/captain/logic/cubit.dart';
import 'package:commuter/features/captain/ui/widgets/drawer_widgets/about_us/about_us.dart';
import 'package:commuter/features/captain/ui/widgets/drawer_widgets/captain_map/map_screen.dart';
import 'package:commuter/features/captain/ui/widgets/drawer_widgets/captain_reports/captain_reports.dart';
import 'package:commuter/features/captain/ui/widgets/drawer_widgets/captain_shift/captain_shift.dart';
import 'package:commuter/features/captain/ui/widgets/drawer_widgets/personal_details/personal_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerItems extends StatelessWidget {
  const DrawerItems({super.key});

  @override
  Widget build(BuildContext context) {
    List<DrawerSingleItem> drawerSingleItemList = [
      DrawerSingleItem(
        function: () {
          context.pop();
        },
        icon: ImagesManager.captainMainPage,
        text: 'الصفحة الرئيسية',
      ),
      DrawerSingleItem(
        function: () {
          context.pop();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CaptainShift(),
            ),
          );
          context.read<CaptainAppCubit>().getAllCarTypes();
          // context.read<CaptainAppCubit>().getAllRevenueCourse();
        },
        icon: ImagesManager.captainNewShift,
        text: 'وردية جديدة',
      ),
      DrawerSingleItem(
        function: () {
          context.pop();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CaptainMap(),
            ),
          );
        },
        icon: ImagesManager.captainMap,
        text: 'الخريطة',
      ),
      DrawerSingleItem(
        function: () {
          context.pop();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CaptainReports(),
            ),
          );
        },
        icon: ImagesManager.captainReport,
        text: 'التقارير',
      ),
      DrawerSingleItem(
        function: () {
          context.pop();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AboutUs(),
            ),
          );
        },
        icon: ImagesManager.captainQuestions,
        text: 'الأسئلة الشائعة',
      ),
      DrawerSingleItem(
        function: () {
          context.pop();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PersonalDetails()));
        },
        icon: ImagesManager.person,
        text: 'الصفحة الشخصية',
      ),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.00.w,
        vertical: 16.00.h,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 10.00.h,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: CircleAvatar(
                  radius: 35.00.r,
                  backgroundColor: ColorsManager.mainAppColor,
                  backgroundImage: const AssetImage(
                    ImagesManager.commuterLogo,
                  ),
                ),
              ),
              const Expanded(
                child: Center(
                  child: ExtraBoldText20dark(
                    text: 'Commuter',
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 30.00.h,
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => drawerSingleItemList[index],
              separatorBuilder: (context, index) => SizedBox(
                height: 25.00.h,
              ),
              itemCount: drawerSingleItemList.length,
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerSingleItem extends StatelessWidget {
  const DrawerSingleItem({
    super.key,
    required this.function,
    required this.icon,
    required this.text,
  });

  final Function function;
  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        width: double.infinity.w,
        height: 60.00.h,
        decoration: BoxDecoration(
          color: ColorsManager.mainAppColor.withOpacity(0.8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(16.00.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.00.w),
          child: Row(
            children: [
              Image.asset(
                width: 30.00.w,
                height: 30.00.h,
                icon,
              ),
              SizedBox(
                width: 30.00.w,
              ),
              Expanded(
                child: BoldText16dark(
                  text: text,
                  color: ColorsManager.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
