import 'package:commuter/core/shared/logic/location_helper.dart';
import 'package:commuter/core/shared/logic/shared_pref.dart';
import 'package:commuter/core/shared/logic/shared_pref_keys.dart';
import 'package:commuter/core/shared/widgets/texts.dart';
import 'package:commuter/core/theme/colors/colors.dart';
import 'package:commuter/features/captain/logic/cubit.dart';
import 'package:commuter/features/captain/logic/states.dart';
import 'package:commuter/features/captain/ui/widgets/drawer_widgets/captain_shift/end_shift/end_shift.dart';
import 'package:commuter/features/captain/ui/widgets/drawer_widgets/captain_shift/expenses_shift/expenses_shift.dart';
import 'package:commuter/features/captain/ui/widgets/drawer_widgets/captain_shift/new_shift/new_shift.dart';
import 'package:commuter/features/captain/ui/widgets/drawer_widgets/captain_shift/note_shift/note_shift.dart';
import 'package:commuter/features/captain/ui/widgets/drawer_widgets/captain_shift/revenue_shift/revenue_shift.dart';
import 'package:commuter/features/captain/ui/widgets/drawer_widgets/captain_shift/supply_shift/supply_shift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//ignore: must_be_immutable
class CaptainShift extends StatelessWidget {
  const CaptainShift({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CaptainAppCubit, CaptainAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = context.read<CaptainAppCubit>();
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: ColorsManager.white,
                size: 20.00,
              ),
            ),
            title: const BoldText18dark(
              text: 'وردية جديدة',
              color: ColorsManager.white,
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.00.w,
                  vertical: 16.00.h,
                ),
                child: Column(
                  children: [
                    SharedPrefService.getData(key: SharedPrefKeys.shiftId) ==
                            null
                        ? Column(
                            children: [
                              const ExtraBoldText20dark(
                                text: 'أهلًا بك في بداية وردية جديدة',
                              ),
                              SizedBox(
                                height: 20.00.h,
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Container(
                                width: double.infinity.w,
                                decoration: BoxDecoration(
                                  color: ColorsManager.green,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(
                                        0,
                                        3,
                                      ), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10.00.r),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15.00.w,
                                    vertical: 15.00.h,
                                  ),
                                  child: Center(
                                    child: BoldText16dark(
                                      text:
                                          '📍 ${LocationUtils.currentAddress}',
                                      color: ColorsManager.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25.00.h,
                              ),
                            ],
                          ),
                    NewShift(),
                    RevenueShift(),
                    ExpensesShiftTile(),
                    SupplyShift(),
                    NotesShiftTile(),
                    EndShift(),
                    SizedBox(
                      height: 20.00.h,
                    ),
                    SharedPrefService.getData(key: SharedPrefKeys.shiftId) ==
                            null
                        ? Container(
                            width: double.infinity.w,
                            decoration: BoxDecoration(
                              color: ColorsManager.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10.00.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.00.w,
                                vertical: 15.00.h,
                              ),
                              child: const Center(
                                child: RegularText16dark(
                                  text: 'لم تبدء دورية اليوم حتي الان',
                                ),
                              ),
                            ),
                          )
                        : Container(
                            width: double.infinity.w,
                            decoration: BoxDecoration(
                              color: ColorsManager.mainAppColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10.00.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.00.w,
                                vertical: 15.00.h,
                              ),
                              child: Center(
                                child: Column(
                                  children: [
                                    const RegularText16dark(
                                      text: 'تم بدء الوردية بنجاح',
                                      color: ColorsManager.white,
                                    ),
                                    SizedBox(
                                      height: 10.00.h,
                                    ),
                                    ExtraBoldText16dark(
                                      text: cubit.resumeShiftModel == null
                                          ? ''
                                          : 'حالتك الآن : ${cubit.resumeShiftModel!.currentStatus}',
                                      color: cubit.checkBreakOrResume == 0
                                          ? ColorsManager.green
                                          : ColorsManager.amber,
                                    ),
                                    SizedBox(
                                      height: 20.00.h,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 40.00.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SharedPrefService.getData(
                                                      key: SharedPrefKeys
                                                          .checkBreakOrResume) ==
                                                  1
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.00.r),
                                                    color: ColorsManager.green,
                                                  ),
                                                  child: MaterialButton(
                                                    onPressed: () {
                                                      cubit
                                                          .checkIfResumeOrBreak(
                                                              0);
                                                      SharedPrefService.saveData(
                                                          key: SharedPrefKeys
                                                              .checkBreakOrResume,
                                                          value: 0);
                                                      cubit.resumeShiftTime();
                                                    },
                                                    child: const BoldText16dark(
                                                      text: 'استئناف',
                                                      color:
                                                          ColorsManager.white,
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.00.r),
                                                    color: ColorsManager.amber,
                                                  ),
                                                  child: MaterialButton(
                                                    onPressed: () {
                                                      cubit
                                                          .checkIfResumeOrBreak(
                                                              1);
                                                      SharedPrefService.saveData(
                                                          key: SharedPrefKeys
                                                              .checkBreakOrResume,
                                                          value: 1);
                                                      cubit.breakShiftTime();
                                                    },
                                                    child: const BoldText16dark(
                                                      text: 'استراحة',
                                                      color:
                                                          ColorsManager.white,
                                                    ),
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.00.h,
                                    ),
                                    BoldText18dark(
                                      text: cubit.resumeShiftModel == null
                                          ? ''
                                          : '${cubit.resumeShiftModel!.workHours}',
                                      color: ColorsManager.white,
                                    ),
                                    SizedBox(
                                      height: 10.00.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
