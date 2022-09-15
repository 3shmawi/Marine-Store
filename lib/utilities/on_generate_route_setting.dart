import 'package:beauty_supplies_project/layout/layout_screen.dart';
import 'package:beauty_supplies_project/modules/auth/login/login_screen.dart';
import 'package:beauty_supplies_project/modules/home/home_screen.dart';
import 'package:flutter/cupertino.dart';

import '../modules/auth/register/register_screen.dart';
import 'app_routes.dart';

Route<dynamic> onGenerate(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.loginPageRoute:
      return CupertinoPageRoute(
        builder: (_) => const LoginScreen(),
        settings: settings,
      );
    case AppRoutes.registerPageRoute:
      return CupertinoPageRoute(
        builder: (_) => const SignUpScreen(),
        settings: settings,
      );
    case AppRoutes.homePageRoute:
      return CupertinoPageRoute(
        builder: (_) => const HomeScreen(),
        settings: settings,
      );

    case AppRoutes.landingPageRoute:
    default:
      return CupertinoPageRoute(
        builder: (_) => const LayoutScreen(),
        settings: settings,
      );
  }
}