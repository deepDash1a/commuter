import 'package:commuter/core/shared/functions/shared_functions.dart';
import 'package:commuter/core/shared/logic/location_helper.dart';
import 'package:commuter/core/theme/colors/colors.dart';
import 'package:commuter/features/captain/logic/cubit.dart';
import 'package:commuter/features/captain/logic/states.dart';
import 'package:commuter/features/captain/ui/widgets/captain_app_bar.dart';
import 'package:commuter/features/captain/ui/widgets/drawer_items.dart';
import 'package:commuter/features/captain/ui/widgets/drawer_widgets/captain_main_page/captain_main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CaptainDashboardScreen extends StatelessWidget {
  const CaptainDashboardScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CaptainAppCubit, CaptainAppStates>(
      listener: (context, state) {
        if (state is SuccessMessagesCaptainAppState) {
          customSnackBar(
            context: context,
            text: '📍 ${LocationUtils.currentAddress}',
            color: ColorsManager.mainAppColor,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          drawer: const SafeArea(
            child: Drawer(
              child: DrawerItems(),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.00.w,
                vertical: 16.00.h,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.00.w),
                  child: Column(
                    children: [
                      const CaptainAppBar(),
                      SizedBox(height: 40.00.h),
                      const CaptainMainPage(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
