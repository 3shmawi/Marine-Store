import 'dart:convert';

import 'package:beauty_supplies_project/admin_screens/upload_product/cubit/admin_upload_product_cubit.dart';
import 'package:beauty_supplies_project/admin_screens/view_all_products/cubit/admin_view_all_products_state.dart';
import 'package:beauty_supplies_project/models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/database_controller.dart';
import '../../shared/color/colors.dart';
import '../../shared/components/components.dart';
import '../../shared/icon/icons.dart';
import '../../utilities/app_routes.dart';
import 'cubit/admin_view_all_products_cubit.dart';

class AdminProductScreen extends StatelessWidget {
  const AdminProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: defaultAppBar(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30),
          child: BlocBuilder<AdminViewAllProductsCubit,
              AdminViewAllProductsState>(
            builder: (context, state) {
              return StreamBuilder<List<ProductModel>>(
                stream: FireStoreDataBase().getAdminProductsStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    final products = snapshot.data;
                    if (products == null || products.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 250,),
                          Image.asset(
                            'assets/images/sala.png',
                            height: 200,
                            width: double.infinity,
                          ),
                          Text(
                            'No Products Available yet!',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 20),
                          ),Text(
                            'Upload now!',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 20),
                          ),
                        ],
                      );

                    }

                    return Padding(
                      padding: const EdgeInsets.only(top: 52.0),
                      child: Column(
                        children: List.generate(

                          products.length,
                          (index) => InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.productDetailPageRoute,
                                  arguments: products[index]);
                            },
                            child: Stack(
                              children: [
                                Card(
                                  elevation: 10,
                                  margin: const EdgeInsets.all(10),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      products[index]
                                              .imgUrl
                                              .startsWith('https://')
                                          ? Image(
                                              image: CachedNetworkImageProvider(
                                                products[index].imgUrl,
                                              ),
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                              height: 200,
                                            )
                                          : Image.memory(
                                              base64Decode(
                                                products[index].imgUrl,
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
                                                      products[index].title,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    if (products[index]
                                                            .discountValue ==
                                                        0)
                                                      Text(
                                                        '${products[index].price}\$',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption!
                                                            .copyWith(
                                                                color:
                                                                    defaultColor),
                                                      ),
                                                    if (products[index]
                                                                .discountValue !=
                                                            0 &&
                                                        products[index]
                                                                .discountValue !=
                                                            null)
                                                      Row(
                                                        children: [
                                                          Text(
                                                            '${products[index].price * (products[index].discountValue!) / 100}\$   ',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .caption!
                                                                .copyWith(
                                                                    color:
                                                                        defaultColor),
                                                          ),
                                                          Text(
                                                              '${products[index].price}\$',
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
                                                  backgroundColor: Colors.black
                                                      .withOpacity(.09),
                                                  color: Colors.red,
                                                  onTap: () {
                                                    context
                                                        .read<
                                                            AdminUploadProductViewCubit>()
                                                        .deleteProduct(
                                                          products[index].id,
                                                          products[index]
                                                              .category,
                                                        );
                                                  },
                                                  iconData: IconBroken.delete,
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
                                if (products[index].discountValue != 0)
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      height: 30,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(.4),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              ' Discount  ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                            Text(
                                              '${products[index].discountValue}%',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ),
                          growable: true,
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
