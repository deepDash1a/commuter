import 'package:commuter/core/routing/routes.dart';
import 'package:commuter/features/authentication/ui/login/screens/login.dart';
import 'package:commuter/features/authentication/ui/register/screens/register.dart';
import 'package:commuter/features/captain/ui/screens/captain_dashboard.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );

      case Routes.registerScreen:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );

      case Routes.captainDashBoardScreen:
        return MaterialPageRoute(
          builder: (_) => const CaptainDashboardScreen(),
        );
    }
    return null;
  }
}
