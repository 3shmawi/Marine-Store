import 'package:beauty_supplies_project/layout/cubit/layout_cubit.dart';
import 'package:beauty_supplies_project/shared/shared_prefrences/shared_prefrences.dart';
import 'package:beauty_supplies_project/shared/theme/theme_mode.dart';
import 'package:beauty_supplies_project/utilities/app_routes.dart';
import 'package:beauty_supplies_project/utilities/on_generate_route_setting.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    String id = CacheHelper.getData(key: SharedKeys.id) ?? '';
    if (kDebugMode) {
      print(id);
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LayoutCubit()),
      ],
      child: MaterialApp(
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        initialRoute:
            id == '' ? AppRoutes.registerPageRoute : AppRoutes.landingPageRoute,
        onGenerateRoute: onGenerate,
      ),
    );
  }
}
