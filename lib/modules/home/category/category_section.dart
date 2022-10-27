import 'package:beauty_supplies_project/database/database_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../models/category.dart';
import '../../../shared/color/colors.dart';
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
              return const Center(
                child: Text(
                  'No Category Available yet!',
                ),
              );
            }
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  CategoryItem(category: category, index: index),
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

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.category,
    required this.index,
  }) : super(key: key);

  final List<CategoryModel> category;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.categoryOnePageRoute,
            arguments: category[index].name);
      },
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Image(
              image: CachedNetworkImageProvider(
                category[index].imgUrl,
              ),
              height: 120.0,
              width: 150.0,
              fit: BoxFit.cover,
            ),
            Container(
              padding: const EdgeInsets.all(5),
              alignment: AlignmentDirectional.centerEnd,
              color: Colors.white,
              width: 150.0,
              child: Text(
                category[index].name,
                maxLines: 1,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                  color: defaultColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
