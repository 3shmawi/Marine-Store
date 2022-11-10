import 'package:beauty_supplies_project/layout/admin_layout/cubit/admin_layout_cubit.dart';
import 'package:beauty_supplies_project/modules/categories/cubit/categories_cubit.dart';
import 'package:beauty_supplies_project/modules/home/all_products/cubit/all_products_cubit.dart';
import 'package:beauty_supplies_project/modules/home/cubit/home_cubit.dart';
import 'package:beauty_supplies_project/modules/search/cubit/search_cubit.dart';
import 'package:beauty_supplies_project/services/cache_helper_services.dart';
import 'package:beauty_supplies_project/shared/sqflite_cubit/database_cubit.dart';
import 'package:beauty_supplies_project/shared/theme/theme_mode.dart';
import 'package:beauty_supplies_project/shared/user_data_cubit/user_cubit.dart';
import 'package:beauty_supplies_project/task/cubit/cubit.dart';
import 'package:beauty_supplies_project/utilities/app_routes.dart';
import 'package:beauty_supplies_project/utilities/constants.dart';
import 'package:beauty_supplies_project/utilities/enums.dart';
import 'package:beauty_supplies_project/utilities/on_generate_route_setting.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'admin_screens/upload_product/cubit/admin_upload_product_cubit.dart';
import 'admin_screens/view_all_products/cubit/admin_view_all_products_cubit.dart';
import 'layout/usr_layout/cubit/usr_layout_cubit.dart';
import 'modules/home/carousel_slider_image/cubit/carousel_slider_images_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    userId = CacheHelper.getData(key: SharedKeys.id) ?? '';
    if (kDebugMode) {
      print(userId);
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AllProductsCubit()),
        BlocProvider(create: (_) => UsrLayoutCubit()),
        BlocProvider(create: (_) => UserCubit()),
        BlocProvider(create: (_) => SearchCubit()),
        BlocProvider(
            create: (_) => DatabaseCubit()
              ..getAllDataFromFavDataBase()
              ..getAllDataFromCartDataBase()),
        BlocProvider(create: (_) => CategoriesCubit()),
        BlocProvider(create: (_) => CarouselSliderImagesCubit()),
        BlocProvider(create: (_) => AdminUploadProductViewCubit()),
        BlocProvider(create: (_) => AdminViewAllProductsCubit()),
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider(create: (_) => AdminLayoutCubit()),
        BlocProvider(create: (_) => CounterTaskCubit()),
      ],
      child: MaterialApp(
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        initialRoute: userId == ''
            ? AppRoutes.registerPageRoute
            : AppRoutes.landingPageRoute,
        onGenerateRoute: onGenerate,
      ),
    );
  }
}
