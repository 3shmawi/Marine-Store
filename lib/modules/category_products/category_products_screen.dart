import 'dart:convert';

import 'package:beauty_supplies_project/database/database_controller.dart';
import 'package:beauty_supplies_project/models/product.dart';
import 'package:beauty_supplies_project/modules/home/cubit/home_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/color/colors.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/icon/icons.dart';
import '../../../utilities/app_routes.dart';
import '../home/cubit/home_state.dart';

class CategoryProducts extends StatelessWidget {
  const CategoryProducts({
    Key? key,
    required this.category,
  }) : super(key: key);
  final String category;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: defaultAppBar(context),
          body: StreamBuilder<List<ProductModel>>(
            stream: FireStoreDataBase().getCategoryProductsStream(category),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                var product = snapshot.data;
                if (product == null || product.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30),
                    child: Column(
                      children: List.generate(
                        productImages.length,
                            (index) => InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.productDetailPageRoute,
                                arguments: product[index]);
                          },
                          child: Card(
                            elevation: 10,
                            margin: const EdgeInsets.all(10),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                product[index]
                                    .imgUrl
                                    .startsWith('https://')
                                    ? Image(
                                  image: CachedNetworkImageProvider(
                                    product[index].imgUrl,
                                  ),
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  height: 200,
                                )
                                    : Image.memory(
                                  base64Decode(
                                    product[index].imgUrl,
                                  ),
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  height: 200,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                product[index].title,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              if (product[index]
                                                  .discountValue ==
                                                  0)
                                                Text(
                                                  '${product[index].price}\$',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption!
                                                      .copyWith(
                                                      color:
                                                      defaultColor),
                                                ),
                                              if (product[index]
                                                  .discountValue !=
                                                  0 &&
                                                  product[index]
                                                      .discountValue !=
                                                      null)
                                                Row(
                                                  children: [
                                                    Text(
                                                      '${product[index].price * (product[index].discountValue!) / 100}\$   ',
                                                      style: Theme.of(
                                                          context)
                                                          .textTheme
                                                          .caption!
                                                          .copyWith(
                                                          color:
                                                          defaultColor),
                                                    ),
                                                    Text(
                                                      '${product[index].price}\$',
                                                      style: Theme.of(
                                                          context)
                                                          .textTheme
                                                          .caption!
                                                          .copyWith(
                                                        decoration:
                                                        TextDecoration
                                                            .lineThrough,
                                                      ),),
                                                  ],
                                                ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 5.0,
                                          ),
                                          const Spacer(),
                                          DefaultIconButton(
                                            backgroundColor: cubit.fav.contains(
                                                product[index])
                                                ? Colors.redAccent
                                                : Colors.black.withOpacity(.09),
                                            color: cubit.fav.contains(
                                                product[index])
                                                ? Colors.white
                                                : Colors.red,
                                            onTap: () {
                                              cubit.changeFavoriteState(
                                                  product[index]);
                                            },
                                            iconData: IconBroken.heart,
                                            size: 15,
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
                    ),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        );
      },
    );
  }
}
