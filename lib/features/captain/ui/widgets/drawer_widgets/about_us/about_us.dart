import 'package:commuter/core/shared/widgets/texts.dart';
import 'package:commuter/core/theme/colors/colors.dart';
import 'package:commuter/core/theme/fonts/font_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
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
        title: Text(
          'الأسئلة الشائعة',
          style: TextStyle(
              fontSize: 18.00.sp,
              fontFamily: FontNamesManager.bold,
              color: ColorsManager.white),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.00.w,
              vertical: 16.00.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExpansionTile(
                  title: const BoldText18dark(
                    text: 'كيف يتم احتساب المصروفات ؟',
                  ),
                  backgroundColor: ColorsManager.offWhite,
                  children: [
                    buildContainerMessages(
                        'مصروفات التشغيل (بنزين، زيت، وغاز): الكابتن لا يتحمل فيها أي نسبة'),
                    SizedBox(height: 20.00.h),
                    buildContainerMessages(
                        'مصروفات الصيانة: يتحمل الكابتن ٣٠٪ من اجمالي المصروف'),
                    SizedBox(height: 20.00.h),
                    buildContainerMessages(
                        'المصروفات الطارئة: يتحمل الكابتن ٧٠٪ من اجمالي المصروف'),
                    SizedBox(height: 20.00.h),
                  ],
                ),
                SizedBox(height: 10.00.h),
                ExpansionTile(
                  title: const BoldText18dark(
                    text: 'ما هي التعليمات/التنبيهات للشيفت اليومي ؟',
                  ),
                  backgroundColor: ColorsManager.offWhite,
                  children: [
                    buildContainerMessages(
                        'فحص السيارة اليومي(التأكد من الزيت والماء)'),
                    SizedBox(height: 20.00.h),
                    buildContainerMessages(
                        'تتضيف السيارة داخليا وخارجيًا بالفوطة'),
                    SizedBox(height: 20.00.h),
                    buildContainerMessages(
                        'يتم اخذ سكرين شوت من كل الابلكيشنز اللي تم العمل عليها خلال اليوم (ملخص اليوم عدد رحلات وقيمة) عشان بنحتاجه في الشيفت اليومي'),
                    SizedBox(height: 20.00.h),
                    buildContainerMessages(
                        'شحن البرامج بيتم اخذ سكرين شوت للشحن عشان بنحتاجه في الشيفت اليومي'),
                    SizedBox(height: 20.00.h),
                    buildContainerMessages(
                        'اي مصاريف خارجية(صيانات/قطع غيار/متطلبات للسيارة) يتم تصوير الفواتير وارسالها مع نهاية الشيفت حتى مقابلة المحاسب لتسليمه الفواتير'),
                    SizedBox(height: 20.00.h),
                    buildContainerMessages(
                        'في حالة التوقف عن العمل لأي ظرف يتم زر ال "راحة" وعند البدأ مره اخرى يتم استخدام زي ال "استئناف"'),
                    SizedBox(height: 20.00.h),
                  ],
                ),
                SizedBox(height: 10.00.h),
                ExpansionTile(
                  title: const BoldText18dark(
                    text: 'ما هي التعليمات/التنبيهات للشهر ؟',
                  ),
                  backgroundColor: ColorsManager.offWhite,
                  children: [
                    buildContainerMessages(
                        'الصيانات (الزيت خصوصاً) مسؤولية الكابتن وبمجرد وصول موعد تغييره يتم الابلاغ به في خانة الملاحظات الخاصة بالشيفت'),
                    SizedBox(height: 20.00.h),
                    buildContainerMessages(
                        'السيارة تغسل مرة أسبوعيا (جمعة او سبت)'),
                    SizedBox(height: 20.00.h),
                    buildContainerMessages(
                        'نسبة الكابتن من أي المشاوير الخارجية ٥٪ (كأنه ابلكيشن)'),
                    SizedBox(height: 20.00.h),
                    buildContainerMessages(
                        'الاجازات يتم الاعلام بها بما لا يقل عن ٥ ايام.'),
                    SizedBox(height: 20.00.h),
                    buildContainerMessages('يتم تسليم السيارة بها غاز وبنزين.'),
                    SizedBox(height: 20.00.h),
                    buildContainerMessages(
                        'اي مشوار داخلي (لاي احد من الادارة او اصحاب السيارات او الكباتن) يتم حسب الكيلو ب ٤ جنية وساعة الانتظار ب ٥٠ جنية.'),
                    SizedBox(height: 20.00.h),
                  ],
                ),
                SizedBox(height: 10.00.h),
                ExpansionTile(
                  title: const BoldText18dark(
                    text: 'ما هي المكافآت ؟',
                  ),
                  backgroundColor: ColorsManager.offWhite,
                  children: [
                    buildContainerMessages(
                        'في حالة ان صافي الشيفت كعهدة منه أكثر من ١٥٠٠ جنية يتم صرف ٧٥ جنية مكافأة يومية.'),
                    SizedBox(height: 20.00.h),
                    buildContainerMessages(
                        'في حالة تخطي السيارة ل ٢٠ الف شهريا يتم صرف ٥٠٠ جنية تقسم على الكباتن بنسبة كل كابتن من اجمالي الايراد على السيارة'),
                    SizedBox(height: 20.00.h),
                    buildContainerMessages(
                        'في حالة تخطي السيارة ل ٣٠ الف شهريا يتم صرف ٧٥٠ جنية تقسم على الكباتن بنسبة كل كابتن من اجمالي الايراد على السيارة'),
                    SizedBox(height: 20.00.h),
                    buildContainerMessages(
                        'في حالة تخطي السيارة ل ٤٠ الف شهريا يتم صرف ١٠٠٠ جنية تقسم على الكباتن بنسبة كل كابتن من اجمالي الايراد على السيارة'),
                    SizedBox(height: 20.00.h),
                    buildContainerMessages(
                        'في حالة عمل الكابتن لاكثر من١٠ ايام يتم صرف له ١٠٠ جنية حق باقة انترنت وفي حالة تخطى ٢٠ يوم يتم صرف له ٢٠٠ جنية'),
                    SizedBox(height: 20.00.h),
                  ],
                ),
                SizedBox(height: 10.00.h),
                ExpansionTile(
                  title: const BoldText18dark(
                    text: 'ما هي الغرامات ؟',
                  ),
                  backgroundColor: ColorsManager.offWhite,
                  children: [
                    buildContainerMessages(
                        'في حالة عدم غسل السيارة مره أسبوعيا (جمعة او سبت) بحيث كل كابتن يغسلها اسبوع يتم تغريم الكابتن ب ٥٠ جنية.'),
                    SizedBox(height: 20.00.h),
                    buildContainerMessages(
                        'في حالة تخطي العهدة مبلغ ٢٠٠٠ بدون توريد يتم تغريم الكابتن بغرامة يومية بقيمة ٥٠ج وفي حالة مرور ٣ ايام بدون التوريد يتم ايقاف الكابتن عن العمل وتسوية الحساب معه'),
                    SizedBox(height: 20.00.h),
                    buildContainerMessages(
                        'مسموح للكابتن التأخير عن موعد بدأه بمقدار ساعتين كحد اقصى ولكن غير مسموح بالتأخير عن موعد تسليمة للسيارة وفي حالة حدوث تأخير في التسليم لأكثر من مرتين يتم تغريم الكابتن غرامة بقدر ٥٠ جنية لمدة ٣ مرات وفي حالة تخطي ال ٣ غرامات يتم ايقاف الكابتن عن العمل وتسوية الحساب معه'),
                    SizedBox(height: 20.00.h),
                    buildContainerMessages(
                        'يتم تسليم السيارة بها غاز وبنزين وفي حالة عدم وجود اي منهما او كلاهما لاكثر من مرتين يتم انزال غرامة بقيمة ٥٠ جنية للمره وفي حالة تخطي ٣ غرامات يتم ايقاف الكابتن عن العمل وتسوية الحساب معه'),
                    SizedBox(height: 20.00.h),
                    buildContainerMessages(
                        'ممنوع التدخين بالسيارة ككابتن وكعميل وفي حالة تم اكتشاف ذلك وتكراره أكثر من مرتين يتم تغريم الكابتن غرامة بقيمة ٥٠ جنية عن كل مره وفي حالة تخطي ٣ مرات يتم ايقاف الكابتن عن العمل وتسوية الحساب معه'),
                    SizedBox(height: 20.00.h),
                    buildContainerMessages(
                        'في حالة مخالفات الطريق يتحمل الكابتن حق المخالفة + مصاريف الدفع الالكتروني الخاصه بها (يتم ارسال فاتورة الدفع للكابتن بقيمة المخالفة بعد السداد)'),
                    SizedBox(height: 20.00.h),
                  ],
                ),
                SizedBox(height: 10.00.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildContainerMessages(String text) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.00.w, vertical: 5.00),
      decoration: BoxDecoration(
        color: ColorsManager.white.withOpacity(0.7),
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
        padding: EdgeInsets.symmetric(
          horizontal: 15.00.w,
          vertical: 15.00.h,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                maxLines: 100,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  height: 2.2,
                  fontSize: 14.00.sp,
                  fontFamily: FontNamesManager.bold,
                  color: ColorsManager.mainAppColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
