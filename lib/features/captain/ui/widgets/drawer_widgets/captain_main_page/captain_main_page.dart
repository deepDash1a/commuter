import 'package:commuter/core/shared/widgets/texts.dart';
import 'package:commuter/core/theme/colors/colors.dart';
import 'package:commuter/core/theme/fonts/font_names.dart';
import 'package:commuter/core/theme/images/images.dart';
import 'package:commuter/features/captain/data/captain_shift/suppliers_model.dart';
import 'package:commuter/features/captain/data/dash_board_model/dash_board_messages_model.dart';
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                titleContainer(
                    text: 'الرسائل',
                    image: ImagesManager.captainMainPageMessages),
                SizedBox(
                  height: 20.00.h,
                ),
                cubit.dashBoardMessageModel == null
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : SizedBox(
                        height: 100.00.h,
                        child: ListView.separated(
                          itemBuilder: (context, index) => MessageItems(
                              messages: cubit
                                  .dashBoardMessageModel!.messages![index]),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 20.00.h),
                          itemCount:
                              cubit.dashBoardMessageModel!.messages!.length,
                        ),
                      ),
                SizedBox(
                  height: 30.00.h,
                ),
                titleContainer(
                    text: 'التعليمات',
                    image: ImagesManager.captainMainPageInstructions),
                SizedBox(
                  height: 5.00.h,
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
                titleContainer(
                    text: 'ملاحظاتك',
                    image: ImagesManager.captainMainPageNotes),
                SizedBox(
                  height: 20.00.h,
                ),
                titleContainer(
                    text: 'توريداتك',
                    image: ImagesManager.captainMainPageSupply),
                SizedBox(
                  height: 20.00.h,
                ),
                cubit.getAllSuppliersModel == null
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : SizedBox(
                        height: 200.00.h,
                        child: ListView.separated(
                          itemBuilder: (context, index) => SupplyItems(
                              suppliersModel:
                                  cubit.getAllSuppliersModel!.body![index]),
                          separatorBuilder: (context, index) => SizedBox(height: 10.00.h,),
                          itemCount: cubit.getAllSuppliersModel!.body!.length,
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget titleContainer({
  required String text,
  required String image,
}) =>
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
              image,
            ),
            SizedBox(
              width: 15.00.w,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 18.00.sp,
                fontFamily: FontNamesManager.extraBold,
                color: ColorsManager.white,
              ),
            ),
          ],
        ),
      ),
    );

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

class SupplyItems extends StatelessWidget {
  const SupplyItems({
    super.key,
    required this.suppliersModel,
  });

  final SuppliersModel suppliersModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.00.w, vertical: 10.00.h),
      padding: EdgeInsets.symmetric(horizontal: 10.00.w, vertical: 10.00.h),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BoldText18dark(text: 'الاسم: ${suppliersModel.supplierName}'),
          SizedBox(height: 10.00.h),
          BoldText18dark(text: 'القيمة: ${suppliersModel.price}'),
          SizedBox(height: 10.00.h),
          BoldText18dark(text: 'طريقة الدفع: ${suppliersModel.wayPay}'),
          SizedBox(height: 10.00.h),
          Align(
            alignment: Alignment.centerLeft,
            child: BoldText18dark(
              text: '${suppliersModel.createdAt}'.substring(0, 10),
              color: ColorsManager.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class MessageItems extends StatelessWidget {
  const MessageItems({
    super.key,
    required this.messages,
  });

  final Messages messages;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10.00.w,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.00.w, vertical: 10.00.h),
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
      child: BoldText14dark(text: '${messages.content}'),
    );
  }
}
