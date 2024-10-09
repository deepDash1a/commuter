import 'package:commuter/core/shared/widgets/custom_button.dart';
import 'package:commuter/core/shared/widgets/custom_text_button.dart';
import 'package:commuter/core/shared/widgets/report_cells_rows_and_columns.dart';
import 'package:commuter/core/shared/widgets/texts.dart';
import 'package:commuter/core/theme/colors/colors.dart';
import 'package:commuter/core/theme/fonts/font_names.dart';
import 'package:commuter/features/captain/logic/cubit.dart';
import 'package:commuter/features/captain/logic/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CaptainReports extends StatelessWidget {
  const CaptainReports({super.key});

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
              text: 'التقارير',
              color: ColorsManager.white,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 16.00.w, vertical: 16.00.h),
              child: Center(
                child: Column(
                  children: [
                    const ExtraBoldText20dark(text: 'التقارير'),
                    SizedBox(height: 20.00.h),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextButton(
                            text: 'التقرير اليومي',
                            function: () {
                              cubit.isDailyReport = true;
                              cubit.changeBetweenDailyAndMonthlyStates(
                                cubit.isDailyReport,
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: CustomTextButton(
                            text: 'التقرير الشهري',
                            function: () {
                              cubit.isDailyReport = false;
                              cubit.changeBetweenDailyAndMonthlyStates(
                                cubit.isDailyReport,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.00.h),
                    cubit.isDailyReport
                        ? const DailyReport()
                        : const MonthlyReport(),
                    SizedBox(height: 20.00.h),
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

//ignore: must_be_immutable
class DailyReport extends StatelessWidget {
  const DailyReport({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CaptainAppCubit, CaptainAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = context.read<CaptainAppCubit>();

        return Column(
          children: [
            const ExtraBoldText18dark(text: 'التقرير اليومي بتاريخ'),
            SizedBox(height: 10.00.h),
            Container(
              width: double.infinity.w,
              height: 1.00.h,
              color: ColorsManager.mainAppColor.withOpacity(0.3),
            ),
            SizedBox(height: 20.00.h),
            cubit.getAllDailyReportModel == null
                ? const BoldText16dark(
                    text: 'لم يتم العثور على تقارير لهذا التاريخ')
                : cubit.loadingAllDailyReportModel == true
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ExtraBoldText18dark(
                              text: cubit.lastAllReportModel!.startDate
                                  .substring(0, 10)),
                          SizedBox(height: 10.00.h),
                          ReportRow(
                            cell1: 'اسم الكابتن',
                            cell2:
                                '${cubit.lastAllReportModel!.firstName} ${cubit.lastAllReportModel!.lastName}',
                          ),
                          ReportRow(
                            cell1: 'نوع السيارة',
                            cell2: cubit.lastAllReportModel!.carType,
                          ),
                          ReportRow(
                            cell1: 'ساعات العمل',
                            cell2: cubit.lastAllReportModel!.workHours,
                            cell3:
                                '${(cubit.lastAllReportModel!.poundPerHour).substring(0, 5)}  \n جنية / ساعة',
                          ),
                          ReportRow(
                            cell1: 'عدد الرحلات',
                            cell2:
                                '${int.parse(cubit.lastAllReportModel!.numTripsApps) + int.parse(cubit.lastAllReportModel!.numTripsExternal) + cubit.lastAllReportModel!.numCourseNumber}',
                            cell3:
                                '${(cubit.lastAllReportModel!.poundPerTrip).substring(0, 5)}  \n جنية / رحلة',
                          ),
                          ReportRow(
                            cell1: 'كيلومترات',
                            cell2: cubit.lastAllReportModel!
                                        .calculatedKilometers
                                        .toString() ==
                                    'null'
                                ? '0.00'
                                : cubit
                                    .lastAllReportModel!.calculatedKilometers,
                            cell3:
                                '${(cubit.lastAllReportModel!.poundPerKilometer).substring(0, 5)}  \n جنية / كيلومتر',
                          ),
                          ReportRow(
                            cell1: 'إيراد التطبيقات',
                            cell2: cubit.lastAllReportModel!
                                .totalFinancialValueApplication,
                          ),
                          ReportRow(
                            cell1: 'إيراد التوصيلات الخارجية',
                            cell2: cubit.lastAllReportModel!
                                .totalFinancialValueTripsExternal,
                          ),
                          ReportRow(
                            cell1: 'إيراد الدورات',
                            cell2: cubit
                                .lastAllReportModel!.totalFinancialValueCourses,
                          ),
                          ReportRow(
                            cell1: 'رصيد التوصلات الخارجية',
                            cell2: cubit.lastAllReportModel!
                                .balanceFinancialValueTripsExternal,
                          ),
                          ReportRow(
                            cell1: 'إجمالي إيراد اليوم',
                            cell2:
                                '${double.parse(cubit.lastAllReportModel!.totalFinancialValueApplication) + double.parse(cubit.lastAllReportModel!.totalFinancialValueTripsExternal) + double.parse(cubit.lastAllReportModel!.totalFinancialValueTripsExternal) + 0}',
                          ),
                          ReportRow(
                            cell1: 'إجمالي الإيراد',
                            cell2: cubit.lastAllReportModel!.totalRevenue,
                          ),
                          ReportRow(
                            cell1: 'إجمالي المصروفات',
                            cell2: cubit.lastAllReportModel!.totalExpense,
                          ),
                          ReportRow(
                            cell1: 'عهدة اليوم',
                            cell2: cubit.lastAllReportModel!.covenant,
                          ),
                          ReportRow(
                            cell1: 'إجمالي العهدة',
                            cell2: cubit.lastAllReportModel!.totalCovenant,
                          ),
                          ReportRow(
                            cell1: 'مصروفات تشغيل',
                            cell2: cubit.lastAllReportModel!.totalExpensesFuel,
                          ),
                          ReportRow(
                            cell1: 'مصروفات صيانة',
                            cell2: cubit.lastAllReportModel!
                                .totalExpensesTypeAdditional,
                          ),
                          ReportRow(
                            cell1: 'شحن تطبيقات',
                            cell2: cubit
                                .lastAllReportModel!.totalExpensesChargeTrips,
                          ),
                          ReportRow(
                            cell1: 'مصروفات طارئة',
                            cell2: cubit
                                .lastAllReportModel!.totalEmergencyExpenses,
                          ),
                          ReportRow(
                            cell1: 'إجمالي مصروفات اليوم',
                            cell2: cubit.lastAllReportModel!.totalExpense,
                          ),
                          ReportRow(
                            cell1: 'الغرامة',
                            cell2: cubit.lastAllReportModel!.totalPriceFine,
                          ),
                          ReportRow(
                            cell1: 'سبب الغرامة / المكافآة',
                            cell2: cubit.lastAllReportModel!.fine,
                          ),
                          ReportRow(
                            cell1: 'توريد النقدي',
                            cell2:
                                cubit.lastAllReportModel!.totalPriceSuppliers,
                          ),
                          ReportRow(
                            cell1: 'إجمالي التوريدات',
                            cell2:
                                cubit.lastAllReportModel!.totalMonthlySuppliers,
                          ),
                        ],
                      ),
          ],
        );
      },
    );
  }
}

//ignore: must_be_immutable
class MonthlyReport extends StatelessWidget {
  const MonthlyReport({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CaptainAppCubit, CaptainAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = context.read<CaptainAppCubit>();
        return Form(
          key: cubit.monthlyReportFromKey,
          child: Column(
            children: [
              const ExtraBoldText18dark(text: 'التقرير الشهري'),
              SizedBox(height: 20.00.h),
              TextFormField(
                controller: cubit.startMonthlyDateController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'من فضلك اختر التاريخ';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'اختر تاريخ البداية',
                  hintStyle: TextStyle(
                    fontSize: 16.00.sp,
                    fontFamily: FontNamesManager.regular,
                  ),
                  filled: true,
                  prefixIcon: const Icon(
                    Icons.date_range_outlined,
                    color: ColorsManager.mainAppColor,
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  errorStyle: TextStyle(
                    fontSize: 12.00.sp,
                    color: ColorsManager.red,
                    fontFamily: FontNamesManager.bold,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10.00.h,
                    horizontal: 20.00.w,
                  ),
                ),
                readOnly: true,
                onTap: () {
                  cubit.selectDate(context, cubit.startMonthlyDateController);
                },
              ),
              SizedBox(height: 20.00.h),
              TextFormField(
                controller: cubit.endMonthlyDateController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'من فضلك اختر التاريخ';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'اختر تاريخ الانتهاء',
                  hintStyle: TextStyle(
                    fontSize: 16.00.sp,
                    fontFamily: FontNamesManager.regular,
                  ),
                  filled: true,
                  prefixIcon: const Icon(
                    Icons.date_range_outlined,
                    color: ColorsManager.mainAppColor,
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  errorStyle: TextStyle(
                    fontSize: 12.00.sp,
                    color: ColorsManager.red,
                    fontFamily: FontNamesManager.bold,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10.00.h,
                    horizontal: 20.00.w,
                  ),
                ),
                readOnly: true,
                onTap: () {
                  cubit.selectDate(context, cubit.endMonthlyDateController);
                },
              ),
              SizedBox(height: 20.00.h),
              state is LoadingFilterReportAppState
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : CustomButton(
                      text: 'عرض',
                      onPressed: () {
                        if (cubit.monthlyReportFromKey.currentState!
                            .validate()) {
                          cubit.filterReport();
                        }
                      },
                    ),
              SizedBox(height: 30.00.h),
              state is SuccessFilterReportAppState
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ReportRow(
                          cell1: 'من  ${cubit.startMonthlyDateController.text}',
                          cell2: 'إلى  ${cubit.endMonthlyDateController.text}',
                        ),
                        ReportRow(
                          cell1: 'الرحلات',
                          cell2: cubit.reportFilterModel!.body!.numberOfTrips,
                        ),
                        ReportRow(
                          cell1: 'إيراد',
                          cell2: cubit.reportFilterModel!.body!.totalRevenues,
                        ),
                        ReportRow(
                          cell1: 'عدد ساعات العمل',
                          cell2: cubit.reportFilterModel!.body!.totalWorkHours,
                        ),
                        ReportRow(
                          cell1: 'إجمالي المصروفات',
                          cell2: cubit.reportFilterModel!.body!.totalExpenses,
                        ),
                        ReportRow(
                          cell1: 'متوسط قيمة الرحلة',
                          cell2: cubit.reportFilterModel!.body!.averageTripCost,
                        ),
                        ReportRow(
                          cell1: 'متوسط قيمة الساعة',
                          cell2: cubit.reportFilterModel!.body!.averageHourCost,
                        ),
                        ReportRow(
                          cell1: 'متوسط الإيراد اليومي',
                          cell2: cubit
                              .reportFilterModel!.body!.averageDailyRevenue,
                        ),
                        ReportRow(
                          cell1: 'عهدة الكابتن',
                          cell2: cubit.reportFilterModel!.body!.captainCovenant,
                        ),
                        ReportRow(
                          cell1: 'إجمالي أجر الكابتن',
                          cell2: cubit.reportFilterModel!.body!.totalSalary,
                        ),
                        ReportRow(
                          cell1: 'إجمالي الربح',
                          cell2: cubit.reportFilterModel!.body!.totalProfit,
                        ),
                        ReportRow(
                          cell1: 'مصروفات التشغيل',
                          cell2:
                              cubit.reportFilterModel!.body!.totalExpensesFuel,
                        ),
                        ReportRow(
                          cell1: 'مصروفات صيانة',
                          cell2: cubit.reportFilterModel!.body!
                              .totalExpensesTypeAdditional,
                        ),
                        ReportRow(
                          cell1: 'مصروفات طارئة',
                          cell2: cubit
                              .reportFilterModel!.body!.totalEmergencyExpenses,
                        ),
                        ReportRow(
                          cell1: 'متوسط مسافة الرحلة',
                          cell2: cubit
                              .reportFilterModel!.body!.averageTripDistance,
                        ),
                        ReportRow(
                          cell1: 'متوسط قيمة الكيلومتر',
                          cell2: cubit.reportFilterModel!.body!
                              .averageValueOfKilometers,
                        ),
                        ReportRow(
                          cell1: 'متوسط المصروفات اليومي',
                          cell2: cubit
                              .reportFilterModel!.body!.averageDailyExpenses,
                        ),
                        ReportRow(
                          cell1: 'التوريدات',
                          cell2:
                              cubit.reportFilterModel!.body!.totalSuppliesCost,
                        ),
                        ReportRow(
                          cell1: 'متوسط الأجر اليومي',
                          cell2:
                              cubit.reportFilterModel!.body!.averageDailySalary,
                        ),
                        ReportRow(
                          cell1: 'متوسط الربح اليومي',
                          cell2:
                              cubit.reportFilterModel!.body!.averageDailyProfit,
                        ),
                      ],
                    )
                  : const Center(
                      child: BoldText16dark(text: 'لا يوجد تقارير لعرضها'),
                    )
            ],
          ),
        );
      },
    );
  }
}
