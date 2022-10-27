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
      stream: FireStoreDataBase().allProductsStream(),
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
                      arguments: productImages[index]);
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
                      Image(
                        image: CachedNetworkImageProvider(
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
                                Text(
                                  'New product',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: defaultColor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                const Spacer(),
                                BlocBuilder<HomeCubit, HomeState>(
                                  builder: (context, state) {
                                    var cubit = HomeCubit.get(context);
                                    return DefaultIconButton(
                                      backgroundColor: cubit.fav
                                              .contains(productImages[index])
                                          ? Colors.redAccent
                                          : Colors.black.withOpacity(.09),
                                      color: cubit.fav
                                              .contains(productImages[index])
                                          ? Colors.white
                                          : Colors.red,
                                      onTap: () {
                                        cubit.changeFavoriteState(
                                            productImages[index]);
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
