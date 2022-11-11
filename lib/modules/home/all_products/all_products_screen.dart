import 'package:beauty_supplies_project/modules/search/cubit/search_cubit.dart';
import 'package:beauty_supplies_project/modules/search/cubit/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../database/remote_database_controller.dart';
import '../../../models/product.dart';
import '../../../shared/color/colors.dart';
import '../../../shared/components/components.dart';
import '../../../utilities/app_routes.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ProductModel>>(
      stream: FireStoreDataBase().getAllProductsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          var products = snapshot.data;
          if (products == null || products.isEmpty) {
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
              products.length,
              (count) {
                int index = products.length - count - 1;
                var product =products[index];
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, AppRoutes.productDetailPageRoute,
                        arguments: product);
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
                            image: product.imgUrl,
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
                                          product.title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                        BlocBuilder<SearchCubit, SearchState>(
                                            buildWhen: (_, current) => current
                                                is GetAllProductsSearchState,
                                            builder: (context, state) {
                                              context
                                                  .read<SearchCubit>()
                                                  .getAllProducts(products);
                                              return const SizedBox(
                                                height: 5,
                                              );
                                            }),
                                        if (product.discountValue == 0)
                                          Text(
                                            '${product.price} E.g',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(color: defaultColor),
                                          ),
                                        if (product.discountValue != 0 &&
                                            product.discountValue !=
                                                null)
                                          Text(
                                            '${product.price - (product.price * (product.discountValue!) / 100)} E.g   ',
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
                                              '${product.price} E.g    ',
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
                                              '${product.discountValue}%',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            ),
                                          ],
                                        ),
                                        DefaultRating(
                                          id: product.id,
                                          size: 17.5,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  // const Spacer(),
                                  DefaultIconFavChangeState(
                                      product: product),
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
