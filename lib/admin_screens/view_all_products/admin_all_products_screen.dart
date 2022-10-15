import 'dart:convert';

import 'package:beauty_supplies_project/admin_screens/upload_product/edit_product.dart';
import 'package:beauty_supplies_project/admin_screens/view_all_products/cubit/admin_view_all_products_state.dart';
import 'package:beauty_supplies_project/models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/color/colors.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/icon/icons.dart';
import '../../utilities/app_routes.dart';
import 'cubit/admin_view_all_products_cubit.dart';

class AdminProductScreen extends StatelessWidget {
  const AdminProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: defaultAppBarWithoutAnything(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30),
          child:
              BlocBuilder<AdminViewAllProductsCubit, AdminViewAllProductsState>(
            builder: (context, state) {
              return StreamBuilder<List<ProductModel>>(
                stream: context
                    .read<AdminViewAllProductsCubit>()
                    .getAllProductsStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    final products = snapshot.data;
                    if (products == null || products.isEmpty) {
                      return const Center(
                        child: Text(
                          'No Products Available yet!',
                        ),
                      );
                    }

                    return Column(
                      children: List.generate(
                        products.length,
                        (index) => InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.productDetailPageRoute,
                                arguments: products[index].imgUrl);
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
                                Image.memory(
                                  base64Decode(products[index].imgUrl),
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
                                          Text(
                                            products[index].title,
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: defaultColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5.0,
                                          ),
                                          const Spacer(),
                                          DefaultIconButton(
                                            backgroundColor:
                                                Colors.black.withOpacity(.09),
                                            color: defaultColor,
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditUploadedProduct(
                                                    productModel: ProductModel(
                                                      id: products[index].id,
                                                      title:
                                                          products[index].title,
                                                      discountValue:
                                                          products[index]
                                                              .discountValue!,
                                                      description:
                                                          products[index]
                                                              .description,
                                                      category: products[index]
                                                          .category,
                                                      imgUrl: products[index]
                                                          .imgUrl,
                                                      price:
                                                          products[index].price,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            iconData: IconBroken.edit,
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
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
