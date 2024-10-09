import 'package:commuter/core/shared/logic/shared_pref.dart';
import 'package:commuter/core/shared/logic/shared_pref_keys.dart';
import 'package:commuter/core/shared/widgets/custom_text_button.dart';
import 'package:commuter/core/shared/widgets/report_cells_rows_and_columns.dart';
import 'package:commuter/core/shared/widgets/texts.dart';
import 'package:commuter/core/theme/colors/colors.dart';
import 'package:commuter/core/theme/images/images.dart';
import 'package:commuter/features/captain/logic/cubit.dart';
import 'package:commuter/features/captain/logic/states.dart';
import 'package:commuter/features/captain/ui/widgets/drawer_widgets/captain_shift/revenue_shift/add_revenue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RevenueShift extends StatelessWidget {
  const RevenueShift({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CaptainAppCubit, CaptainAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = context.read<CaptainAppCubit>();

        return ExpansionTile(
          leading: Image.asset(
            width: 30.00.w,
            height: 30.00.h,
            ImagesManager.money,
          ),
          title: const BoldText18dark(
            text: 'الإيراد',
          ),
          backgroundColor: ColorsManager.offWhite,
          children: [
            SharedPrefService.getData(key: SharedPrefKeys.shiftId) != null
                ? cubit.loadingDailyReportModel == true
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : cubit.getDailyReportModel == null
                        ? Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.00.w,
                              vertical: 20.00.h,
                            ),
                            child: const BoldText14dark(
                              text:
                                  'يتم عرض التقارير علي حسب اليوم الحالي فقط للوردية ، لم يتم العثور على تقارير لهذا التاريخ',
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const ReportRow(cell1: 'البند', cell2: 'القيمة'),
                              ReportRow(
                                cell1: 'عدد رحلات التطبيقات',
                                cell2:
                                    '${cubit.lastDailyReportModel?.numTripsApps}',
                              ),
                              ReportRow(
                                cell1: 'ايراد التطبيقات',
                                cell2:
                                    '${cubit.lastDailyReportModel?.totalFinancialValueApplication}',
                              ),
                              ReportRow(
                                cell1: 'عدد التوصيلات الخارجية',
                                cell2:
                                    '${cubit.lastDailyReportModel?.numTripsExternal}',
                              ),
                              ReportRow(
                                cell1: 'ايراد التوصيلات الخارجية',
                                cell2:
                                    '${cubit.lastDailyReportModel?.totalFinancialValueTripsExternal}',
                              ),
                              // ReportRow(
                              //   cell1: 'عدد الدورات',
                              //   cell2:
                              //       '${cubit.lastDailyReportModel?.numCourseNumber}',
                              // ),
                              // ReportRow(
                              //   cell1: 'ايراد الدورات',
                              //   cell2:
                              //       '${cubit.lastDailyReportModel?.totalFinancialValueCourses}',
                              // ),
                              ReportRow(
                                cell1: 'اجمالي الايراد',
                                cell2:
                                    '${cubit.lastDailyReportModel?.totalRevenue}',
                              ),
                              SizedBox(height: 10.00.h),
                              CustomTextButton(
                                text: 'إضافة',
                                function: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const AddRevenue(),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 10.00.h),
                            ],
                          )
                : Column(
                    children: [
                      SizedBox(
                        height: 10.00.h,
                      ),
                      const BoldText16dark(
                          text: 'لا توجد أي إيرادات ، يجب بدء الوردية أولًا'),
                      SizedBox(
                        height: 20.00.h,
                      ),
                    ],
                  ),
          ],
        );
      },
    );
  }
}
