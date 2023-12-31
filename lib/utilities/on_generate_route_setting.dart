import 'package:beauty_supplies_project/layout/admin_layout/admin_layout_screen.dart';
import 'package:beauty_supplies_project/layout/usr_layout/usr_layout_screen.dart';
import 'package:beauty_supplies_project/models/product.dart';
import 'package:beauty_supplies_project/modules/auth/login/login_screen.dart';
import 'package:beauty_supplies_project/modules/auth/reset_password/reset_password_screen.dart';
import 'package:beauty_supplies_project/modules/auth/verify_email/verify_email_screen.dart';
import 'package:beauty_supplies_project/modules/cart/cart_screen.dart';
import 'package:beauty_supplies_project/modules/home/home_screen.dart';
import 'package:beauty_supplies_project/modules/product_detail/product_details_screen.dart';
import 'package:beauty_supplies_project/modules/search/search_screen.dart';

import 'package:flutter/cupertino.dart';
import '../modules/auth/register/register_screen.dart';
import '../modules/category_products/category_products_screen.dart';
import 'app_routes.dart';

Route<dynamic> onGenerate(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.productDetailPageRoute:
      return CupertinoPageRoute(
        builder: (_) {
          return ProductDetailsScreen(
            product: settings.arguments as ProductModel,
          );
        },
        settings: settings,
      );
    case AppRoutes.verify:
      return CupertinoPageRoute(
        builder: (_) {
          return const VerifyScreen();
        },
        settings: settings,
      );
    case AppRoutes.reset:
      return CupertinoPageRoute(
        builder: (_) {
          return const ResetScreen();
        },
        settings: settings,
      );
    case AppRoutes.adminLayout:
      return CupertinoPageRoute(
        builder: (_) {
          return const AdminLayoutScreen();
        },
        settings: settings,
      );
    case AppRoutes.loginPageRoute:
      return CupertinoPageRoute(
        builder: (_) => LoginScreen(),
        settings: settings,
      );
    case AppRoutes.categoryProducts:
      return CupertinoPageRoute(
        builder: (_) => CategoryProducts(
          category: settings.arguments as String,
        ),
        settings: settings,
      );
    case AppRoutes.cartPageRoute:
      return CupertinoPageRoute(
        builder: (_) => const CartScreen(),
        settings: settings,
      );
    case AppRoutes.registerPageRoute:
      return CupertinoPageRoute(
        builder: (_) => SignUpScreen(),
        settings: settings,
      );
    case AppRoutes.homePageRoute:
      return CupertinoPageRoute(
        builder: (_) => const HomeScreen(),
        settings: settings,
      );
    case AppRoutes.search:
      return CupertinoPageRoute(
        builder: (_) => SearchScreen(
          searchId: settings.arguments as String,
        ),
        settings: settings,
      );

    case AppRoutes.landingPageRoute:
    default:
      return CupertinoPageRoute(
        builder: (_) => const UsrLayoutScreen(),
        settings: settings,
      );
  }
}
