// Expenses
import 'package:commuter/core/shared/logic/shared_pref.dart';
import 'package:commuter/core/shared/logic/shared_pref_keys.dart';
import 'package:commuter/core/shared/widgets/custom_text_button.dart';
import 'package:commuter/core/shared/widgets/report_cells_rows_and_columns.dart';
import 'package:commuter/core/shared/widgets/texts.dart';
import 'package:commuter/core/theme/colors/colors.dart';
import 'package:commuter/core/theme/images/images.dart';
import 'package:commuter/features/captain/logic/cubit.dart';
import 'package:commuter/features/captain/logic/states.dart';
import 'package:commuter/features/captain/ui/widgets/drawer_widgets/captain_shift/expenses_shift/add_expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpensesShiftTile extends StatelessWidget {
  const ExpensesShiftTile({
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
            ImagesManager.expenses,
          ),
          title: const BoldText18dark(
            text: 'المصروفات',
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
                                cell1: 'مصروفات الوقود',
                                cell2:
                                    '${cubit.lastDailyReportModel?.totalExpensesFuel}',
                              ),
                              ReportRow(
                                cell1: 'مصروفات اضافية',
                                cell2:
                                    '${cubit.lastDailyReportModel?.totalExpensesTypeAdditional}',
                              ),
                              ReportRow(
                                cell1: 'مصروفات شحن التطبيقات',
                                cell2:
                                    '${cubit.lastDailyReportModel?.totalExpensesChargeTrips}',
                              ),
                              ReportRow(
                                cell1: 'اجمالي المصروفات',
                                cell2:
                                    '${cubit.lastDailyReportModel?.totalExpense}',
                              ),
                              SizedBox(height: 10.00.h),
                              CustomTextButton(
                                text: 'إضافة',
                                function: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const AddExpenses(),
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
                          text: 'لا توجد أي مصروفات ، يجب بدء الوردية أولًا'),
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
