import 'package:beauty_supplies_project/models/database_model.dart';
import 'package:beauty_supplies_project/shared/sqflite_cubit/database_cubit.dart';
import 'package:beauty_supplies_project/shared/sqflite_cubit/database_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../database/remote_database_controller.dart';
import '../../../models/product.dart';
import '../../../shared/color/colors.dart';
import '../../../shared/components/components.dart';
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
            return const DefaultNotFoundItems(
              image: 'assets/images/buy.png',
              title: 'No Products founded yet!',
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
              (count) {
                int index = product.length - count - 1;
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, AppRoutes.productDetailPageRoute,
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
                        Expanded(
                          child: DefaultImageView(
                            image: product[index].imgUrl,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(color: defaultColor),
                                          ),
                                        if (product[index].discountValue != 0 &&
                                            product[index].discountValue !=
                                                null)
                                          Text(
                                            '${product[index].price * (product[index].discountValue!) / 100}\$   ',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(color: defaultColor),
                                          ),
                                        Row(
                                          children: [
                                            Text(
                                              '${product[index].price}\$    ',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                  ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              '${product[index].discountValue}%',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            ),
                                          ],
                                        ),
                                        DefaultRating(
                                          rate: product[index].rate!.toDouble(),
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  // const Spacer(),
                                  BlocBuilder<DatabaseCubit, DatabaseState>(
                                    builder: (context, state) {
                                      var cubit = context.read<DatabaseCubit>();
                                      var favProduct = FavProductModel(
                                        productId: product[index].id,
                                        title: product[index].title,
                                        category: product[index].category,
                                        imgUrl: product[index].imgUrl,
                                        description: product[index].description,
                                        price: product[index].price,
                                        discountValue:
                                            product[index].discountValue!,
                                        rate: product[index].rate!,
                                      );
                                      return DefaultIconButton(
                                        backgroundColor: cubit.isFav(favProduct)
                                            ? Colors.redAccent
                                            : Colors.black.withOpacity(.1),
                                        color: cubit.isFav(favProduct)
                                            ? Colors.white
                                            : defaultColor,
                                        onTap: () {
                                          cubit.favoriteButton(favProduct);
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
                );
              },
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
