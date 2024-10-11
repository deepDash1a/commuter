import 'package:commuter/core/network/api/dio_consumer.dart';
import 'package:commuter/core/routing/app_router.dart';
import 'package:commuter/core/routing/routes.dart';
import 'package:commuter/core/shared/logic/shared_pref.dart';
import 'package:commuter/core/shared/logic/shared_pref_keys.dart';
import 'package:commuter/core/theme/colors/colors.dart';
import 'package:commuter/features/authentication/logic/cubit.dart';
import 'package:commuter/features/captain/logic/cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//ignore: must_be_immutable
class Commuter extends StatelessWidget {
  Commuter({
    super.key,
    required this.appRouter,
  });

  AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationAppCubit(
              DioConsumer(
                dio: Dio(),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => CaptainAppCubit(
              DioConsumer(
                dio: Dio(),
              ),
            )
              ..getAllMessages()
              ..getAllDailyReport()
              ..getPersonalProfile()
              ..getAllSuppliers(),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale(
              "ar",
            ),
          ],
          locale: const Locale(
            "ar",
          ),
          title: 'Commuter',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: ColorsManager.mainAppColor,
            ),
            scaffoldBackgroundColor: ColorsManager.white,
            colorScheme:
                ColorScheme.fromSeed(seedColor: ColorsManager.mainAppColor),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: getLoggedInitial(),
          onGenerateRoute: appRouter.generateRoute,
        ),
      ),
    );
  }

  String getLoggedInitial() {
    if (SharedPrefService.getData(key: SharedPrefKeys.token) != null) {
      return Routes.captainDashBoardScreen;
    }
    return Routes.loginScreen;
  }
}
