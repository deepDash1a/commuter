import 'package:commuter/core/theme/colors/colors.dart';
import 'package:commuter/core/theme/fonts/font_names.dart';
import 'package:commuter/core/theme/images/images.dart';
import 'package:commuter/features/captain/logic/cubit.dart';
import 'package:commuter/features/captain/logic/states.dart';
import 'package:commuter/features/captain/ui/widgets/drawer_widgets/captain_main_page/instructions_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CaptainMainPage extends StatelessWidget {
  const CaptainMainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<InstructionItems> instructionItems = [
      const InstructionItems(
        image: ImagesManager.passengers,
        text: 'الركاب',
      ),
      const InstructionItems(
        image: ImagesManager.instructions,
        text: 'التعليمات',
      ),
      const InstructionItems(
        image: ImagesManager.cars,
        text: 'السيارة',
      ),
      const InstructionItems(
        image: ImagesManager.driver,
        text: 'حزام الآمان',
      ),
      const InstructionItems(
        image: ImagesManager.speed,
        text: 'السرعات',
      ),
      const InstructionItems(
        image: ImagesManager.note,
        text: 'العامة',
      ),
    ];
    return BlocConsumer<CaptainAppCubit, CaptainAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = context.read<CaptainAppCubit>();
        return SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity.w,
                height: 70.00.h,
                decoration: BoxDecoration(
                  color: ColorsManager.mainAppColor,
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
                        width: 40.00.w,
                        height: 40.00.h,
                        ImagesManager.captainMainPageMessages,
                      ),
                      SizedBox(
                        width: 15.00.w,
                      ),
                      Text(
                        'الرسائل',
                        style: TextStyle(
                          fontSize: 18.00.sp,
                          fontFamily: FontNamesManager.extraBold,
                          color: ColorsManager.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.00.h,
              ),
              Container(
                decoration: BoxDecoration(
                  color: ColorsManager.offWhite,
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
                child: cubit.getMessage
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.00.w,
                          vertical: 20.00.h,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                cubit.dashBoardMessageModel!.messages!.isEmpty
                                    ? 'لا توجد رسائل حاليًا لعرضها'
                                    : '${cubit.dashBoardMessageModel!.messages![0].content}',
                                maxLines: 100,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  height: 2.2,
                                  fontSize: 14.00.sp,
                                  fontFamily: FontNamesManager.bold,
                                  color: cubit.dashBoardMessageModel!.messages!
                                          .isEmpty
                                      ? ColorsManager.red
                                      : ColorsManager.mainAppColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
              SizedBox(
                height: 30.00.h,
              ),
              Container(
                width: double.infinity.w,
                height: 1.00.h,
                color: ColorsManager.mainAppColor.withOpacity(0.3),
              ),
              SizedBox(
                height: 30.00.h,
              ),
              Container(
                width: double.infinity.w,
                height: 70.00.h,
                decoration: BoxDecoration(
                  color: ColorsManager.mainAppColor,
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
                        width: 40.00.w,
                        height: 40.00.h,
                        ImagesManager.captainMainPageInstructions,
                      ),
                      SizedBox(
                        width: 15.00.w,
                      ),
                      Text(
                        'التعليمات',
                        style: TextStyle(
                          fontSize: 18.00.sp,
                          fontFamily: FontNamesManager.extraBold,
                          color: ColorsManager.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.00.h,
              ),
              SizedBox(
                height: 260.00.h,
                child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 25,
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  children: List.generate(
                    instructionItems.length,
                    (index) => Center(
                      // Center each item inside the grid
                      child: instructionItems[index],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class InstructionItems extends StatelessWidget {
  const InstructionItems({
    super.key,
    required this.image,
    required this.text,
  });

  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InstructionsDetails(
              title: text,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: ColorsManager.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(16.00.r),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            children: [
              Image.asset(
                width: 40.00.w,
                height: 40.00.h,
                image,
              ),
              SizedBox(height: 10.00.h),
              // Add some space between image and text
              Text(
                text,
                style: TextStyle(
                  fontSize: 18.00.sp,
                  fontFamily: FontNamesManager.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
