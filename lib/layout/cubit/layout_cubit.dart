import 'package:beauty_supplies_project/modules/home/home_screen.dart';
import 'package:beauty_supplies_project/modules/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/categories/categories_screen.dart';
import '../../modules/favorites/favorites_screen.dart';
import '../../modules/products/products_screen.dart';
import '../../shared/icon/icons.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitial());

  static LayoutCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<Widget> bottomScreens = [
    const HomeScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const SettingScreen(),
  ];

  List<IconData> listOfIcons = [
    IconBroken.home,
    IconBroken.category,
    IconBroken.heart,
    IconBroken.setting,
  ];

  List<String> listOfStrings = [
    'Home',
    'Categories',
    'Favorites',
    'Settings',
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }
}
