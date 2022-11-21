import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../models/category.dart';
import '../../../../shared/color/colors.dart';

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
    return Container(
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
            alignment: AlignmentDirectional.centerStart,
            color: Colors.white,
            width: 150.0,height: 34,

            child: Text(
              category[index].name,
              maxLines: 1,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15.0,
                color: defaultColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}