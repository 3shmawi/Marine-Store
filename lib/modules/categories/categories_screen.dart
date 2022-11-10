import 'package:beauty_supplies_project/database/remote_database_controller.dart';
import 'package:beauty_supplies_project/models/category.dart';
import 'package:beauty_supplies_project/shared/components/components.dart';
import 'package:flutter/material.dart';

import '../../utilities/app_routes.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          /// ListView
          StreamBuilder<List<CategoryModel>>(
            stream: FireStoreDataBase().getCategoryStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                var category = snapshot.data;
                if (category == null || category.isEmpty) {
                  return const DefaultNotFoundItems(
                    image: 'assets/images/buy.png',
                    title: 'No, Categories Available yet!',
                  );
                }
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: List.generate(
                          category.length,
                          (count) {
                            int index = category.length - count - 1;
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: DefaultCategoryPageCard(
                                color: Colors.green,
                                icon: Icons.add,
                                title: category[index].name,
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.categoryProducts,
                                      arguments: category[index].name);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          const BlurTheStatusCard(),
        ],
      ),
    );
  }
}
