import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../admin_screens/admin_settings_screen/admin_settings_screen.dart';
import '../../../admin_screens/upload_product/admin_upload_product_view.dart';
import '../../../admin_screens/view_all_products/admin_all_products_screen.dart';
import '../../../shared/icon/icons.dart';
import 'admin_layout_state.dart';

class AdminLayoutCubit extends Cubit<AdminLayoutState> {
  AdminLayoutCubit() : super(AdminLayoutInitial());
  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(
        IconBroken.home,
      ),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        IconBroken.upload,
      ),
      label: 'New Product',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        IconBroken.setting,
      ),
      label: 'Profile',
    ),
  ];

  List<Widget> screens = [
    const AdminProductScreen(),
    AdminViewUploadProduct(),
    const AdminSettingScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;

    emit(AdminLayoutBottomNavState());
  }
}
