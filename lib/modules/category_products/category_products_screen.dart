import 'package:beauty_supplies_project/database/remote_database_controller.dart';
import 'package:beauty_supplies_project/models/product.dart';
import 'package:flutter/material.dart';
import '../../../shared/components/components.dart';

class CategoryProducts extends StatelessWidget {
  const CategoryProducts({
    Key? key,
    required this.category,
  }) : super(key: key);
  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: defaultAppBarWithoutAnything(context),
      body: StreamBuilder<List<ProductModel>>(
        stream: FireStoreDataBase().getCategoryProductsStream(category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var product = snapshot.data;
            if (product == null || product.isEmpty) {
              return const DefaultNotFoundItems(
                image: 'assets/images/buy.png',
                title: 'No Products founded yet!',
              );
            }
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 80, 10, 30),
                child: Column(
                  children: List.generate(
                    product.length,
                    (index) => DefaultProductCard(product: product[index]),
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
  }
}
