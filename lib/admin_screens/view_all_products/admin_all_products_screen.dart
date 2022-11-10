import 'package:beauty_supplies_project/admin_screens/upload_product/cubit/admin_upload_product_cubit.dart';
import 'package:beauty_supplies_project/admin_screens/upload_product/cubit/admin_upload_product_state.dart';
import 'package:beauty_supplies_project/admin_screens/view_all_products/cubit/admin_view_all_products_state.dart';
import 'package:beauty_supplies_project/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/remote_database_controller.dart';
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
          child:
              BlocBuilder<AdminViewAllProductsCubit, AdminViewAllProductsState>(
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
                          const SizedBox(
                            height: 250,
                          ),
                          Image.asset(
                            'assets/images/buy.png',
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
                          ),
                          Text(
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
                          (count) {
                            int index = products.length - count - 1;
                            return DefaultProductCard(
                              product: products[index],
                              isAdmin: true,
                            );
                          },
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
