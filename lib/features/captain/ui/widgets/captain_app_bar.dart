import 'package:commuter/core/shared/widgets/texts.dart';
import 'package:commuter/core/theme/colors/colors.dart';
import 'package:commuter/features/captain/logic/cubit.dart';
import 'package:commuter/features/captain/logic/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//ignore: must_be_immutable
class CaptainAppBar extends StatelessWidget {
  const CaptainAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CaptainAppCubit>();
    return BlocConsumer<CaptainAppCubit, CaptainAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            Container(
              width: double.infinity.w,
              height: 50.00.h,
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
              child: Row(
                children: [
                  SizedBox(
                    width: 10.00.w,
                  ),
                  Builder(builder: (context) {
                    return IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: const Icon(
                        Icons.menu,
                        color: ColorsManager.white,
                      ),
                    );
                  }),
                  SizedBox(
                    width: 10.00.w,
                  ),
                  Expanded(
                    child: Center(
                      child: cubit.personalModel == null
                          ? const CircularProgressIndicator.adaptive()
                          : ExtraBoldText20dark(
                              text:
                                  '${cubit.personalModel!.user!.firstName} ${cubit.personalModel!.user!.lastName}',
                              color: ColorsManager.white,
                            ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
