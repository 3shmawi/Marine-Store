import 'package:flutter/material.dart';

import '../../../database/remote_database_controller.dart';
import '../../../models/product.dart';
import '../../../shared/components/components.dart';
import 'component/components.dart';

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

                return DefaultProductItem(
                  allProducts: products,
                  index: index,
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
