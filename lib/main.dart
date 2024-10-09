import 'package:commuter/commuter.dart';
import 'package:commuter/core/routing/app_router.dart';
import 'package:commuter/core/shared/logic/bloc_observer.dart';
import 'package:commuter/core/shared/logic/location_helper.dart';
import 'package:commuter/core/shared/logic/shared_pref.dart';
import 'package:commuter/core/theme/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefService.init();
  LocationUtils.currentPosition = await LocationUtils.getCurrentPosition();
  await LocationUtils.getCurrentAddress();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: ColorsManager.mainAppColor,
    ),
  );
  Bloc.observer = MyBlocObserver();
  runApp(Commuter(appRouter: AppRouter()));
}
