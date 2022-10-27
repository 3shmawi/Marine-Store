import 'dart:convert';

import 'package:beauty_supplies_project/modules/home/cubit/home_cubit.dart';
import 'package:beauty_supplies_project/modules/home/cubit/home_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../database/database_controller.dart';
import '../../../models/product.dart';
import '../../../shared/color/colors.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/icon/icons.dart';
import '../../../utilities/app_routes.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ProductModel>>(
      stream: FireStoreDataBase().getAllProductsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          var product = snapshot.data;
          if (product == null || product.isEmpty) {
            return Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/sala.png',
                    height: 200,
                    width: double.infinity,
                  ),
                  Text(
                    'No Products founded yet!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(fontSize: 25),
                  ),
                ],
              ),
            );
          }
          return GridView.count(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            childAspectRatio: 1 / 1.067,
            children: List.generate(
              product.length,
              (index) => InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.productDetailPageRoute,
                      arguments: product[index]);
                },
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      product[index].imgUrl.startsWith('https://')
                          ? Image(
                              image: CachedNetworkImageProvider(
                                product[index].imgUrl,
                              ),
                              width: double.infinity,
                              fit: BoxFit.cover,
                              height: 120,
                            )
                          : Image.memory(
                              base64Decode(
                                product[index].imgUrl,
                              ),
                              width: double.infinity,
                              fit: BoxFit.cover,
                              height: 120,
                            ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product[index].title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    if (product[index].discountValue == 0)
                                      Text(
                                        '${product[index].price}\$',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(color: defaultColor),
                                      ),
                                    if (product[index].discountValue != 0 &&
                                        product[index].discountValue != null)
                                      Row(
                                        children: [
                                          Text(
                                            '${product[index].price * (product[index].discountValue!) / 100}\$   ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(color: defaultColor),
                                          ),
                                          Text(
                                            '${product[index].price}\$',
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                const Spacer(),
                                BlocBuilder<HomeCubit, HomeState>(
                                  builder: (context, state) {
                                    var cubit = HomeCubit.get(context);
                                    return DefaultIconButton(
                                      backgroundColor:
                                          cubit.fav.contains(product[index])
                                              ? Colors.redAccent
                                              : Colors.black.withOpacity(.09),
                                      color: cubit.fav.contains(product[index])
                                          ? Colors.white
                                          : Colors.red,
                                      onTap: () {
                                        cubit.changeFavoriteState(
                                            product[index]);
                                      },
                                      iconData: IconBroken.heart,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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
    );
  }
}
