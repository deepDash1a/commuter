import 'package:commuter/core/theme/colors/colors.dart';
import 'package:commuter/core/theme/fonts/font_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InstructionsDetails extends StatelessWidget {
  const InstructionsDetails({
    super.key,
    required this.title,
  });

  final String title;

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
          title,
          style: TextStyle(
              fontSize: 18.00.sp,
              fontFamily: FontNamesManager.bold,
              color: ColorsManager.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.00.w, vertical: 16.00.h),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
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
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.00.w,
                    vertical: 20.00.h,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          getInstructionsDetails(title),
                          maxLines: 200,
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getInstructionsDetails(String text) {
    switch (text) {
      case 'الركاب':
        return '- عدم المحادثة مع الركاب إلا في الضرورة، وغير ذلك يتم الالتزام بالطريق فقط.\n- عدم السماح للركاب بالتدخين.';
      case 'التعليمات':
        return '- البدأ والانتهاء في الموعد المخصص للشيفت وفي حالة التأخير يتم التنسيق مع الادارة/الكابتن الاخر. \n - استلام وتسليم السيارة في المكان المتفق عليه مع الادارة وفي حالة التغيير يتم التنسيق مع الادارة/الكابتن الاخر. \n - ممنوع التحدث في الهاتف المحمول اثناء السير. \n - الالتزام بحزام الامان. \n - ممنوع التدخين في السيارة.';
      case 'السيارة':
        return 'المحافظة على نظافة السيارة. \n - تنظيف السيارة بالفوطة داخلياً وخارجياً في بداية كل شيفت. \n - غسيل السيارة في مغسلة مرة أسبوعياً من الداخل والخارج. \n - تعامل مع السيارة كأنها سيارتك.';
      case 'العامة':
        return '- اربط حزام الأمان دائمًا: لضمان سلامتك وسلامة الآخرين، تأكد من ربط حزام الأمان في جميع الأوقات أثناء القيادة. \n - التأكد من ضغط الإطارات: قبل كل رحلة، افحص ضغط الإطارات لضمان قيادة آمنة وسلسة. \n - استخدام إشارات الانعطاف: تأكد دائمًا من تشغيل إشارات الانعطاف قبل تغيير الاتجاهات أو المسار. \n - احترام قوانين المرور: اتبع الإشارات والقواعد المرورية بانتظام لضمان سلامتك وسلامة الآخرين. \n - حافظ على مسافة أمان: اترك مسافة آمنة بينك وبين السيارة التي أمامك لتجنب الحوادث المفاجئة. \n - استخدام المرآة الجانبية والوسطى: تحقق دائمًا من المرايا قبل تغيير المسار أو الانعطاف. \n - هذه التعليمات يمكن استخدامها كإرشادات عامة لتعزيز السلامة والكفاءة';
      case 'حزام الآمان':
        return 'الالتزام بحزام الأمان من بداية الشيفت لآخره وممنوع خلعه.';
      case 'السرعات':
        return 'الالتزام بالسرعات المقررة كالآتي: \n - داخل القاهرة والجيزة السرعة ٦٠ كم/س \n - الطريق الدائري السرعة ٩٠ كم/س \n - طريق السويس والإسماعيلية السرعة ١٢٠ كم/س \n - محور المشير طنطاوي السرعة ٩٠ كم/س \n - غير ذلك (أي طريق آخر يرجى التحقق جيدًا من سرعته وحتى ذلك لا نتجاوز ٦٠ كم/س) \n المخالفات المرورية تكون على الكابتن ويتحملها كاملة.';
    }
    return '';
  }
}
