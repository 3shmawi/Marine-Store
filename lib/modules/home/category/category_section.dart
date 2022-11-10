import 'package:beauty_supplies_project/database/remote_database_controller.dart';
import 'package:flutter/material.dart';

import '../../../models/category.dart';
import '../../../shared/components/components.dart';
import '../../../utilities/app_routes.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 154,
      child: StreamBuilder<List<CategoryModel>>(
        stream: FireStoreDataBase().getCategoryStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final category = snapshot.data;
            if (category == null || category.isEmpty) {
              return const DefaultNotFoundItems(
                image: 'assets/images/category.png',
                title: 'No, Categories available yes!',
              );
            }
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, count) {
                int index = category.length - count - 1;
                return InkWell(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.categoryProducts,
                      arguments: category[index].name,
                      (route) => true,
                    );
                  },
                  child: CategoryItem(category: category, index: index),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                width: 10.0,
              ),
              itemCount: category.length,
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
