import 'package:beauty_supplies_project/models/product.dart';
import 'package:beauty_supplies_project/models/rate.dart';
import 'package:beauty_supplies_project/shared/color/colors.dart';
import 'package:beauty_supplies_project/shared/components/components.dart';
import 'package:beauty_supplies_project/shared/icon/icons.dart';
import 'package:beauty_supplies_project/shared/sqflite_cubit/database_cubit.dart';

import 'package:beauty_supplies_project/shared/sqflite_cubit/database_state.dart';
import 'package:beauty_supplies_project/shared/user_data_cubit/user_cubit.dart';
import 'package:beauty_supplies_project/shared/user_data_cubit/user_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/remote_database_controller.dart';
import '../../models/database_model.dart';
import '../../utilities/app_routes.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30.0),
                        Text(
                          product.category,
                          style: const TextStyle(
                            fontSize: 42.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFF17532),
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: DefaultImageView(
                            image: product.imgUrl,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          children: [
                            Text(
                              product.title,
                              style: const TextStyle(
                                  color: Color(0xFF575E67), fontSize: 24.0),
                            ),
                            const Spacer(),
                            if (product.discountValue == 0)
                              Text(
                                '${product.price}\$',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                        color: defaultColor, fontSize: 24),
                              ),
                            if (product.discountValue != 0 &&
                                product.discountValue != null)
                              Text(
                                '${product.price * (product.discountValue!) / 100}\$   ',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                        color: defaultColor, fontSize: 24),
                              ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: DefaultRatingFromUsr(id: product.id),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 50.0,
                          child: Text(
                            product.description,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Color(0xFFB4B8B9),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 15.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: BlocBuilder<DatabaseCubit, DatabaseState>(
                        builder: (context, state) {
                          var cubit = context.read<DatabaseCubit>();
                          var productFav = FavProductModel(
                            productId: product.id,
                            title: product.title,
                            category: product.category,
                            imgUrl: product.imgUrl,
                            description: product.description,
                            price: product.price,
                            discountValue: product.discountValue!,
                            rate: product.rate!,
                          );
                          return DefaultIconButton(
                            backgroundColor: cubit.isFav(productFav)
                                ? Colors.redAccent
                                : Colors.white,
                            color: cubit.isFav(productFav)
                                ? Colors.white
                                : defaultColor,
                            onTap: () {
                              cubit.favoriteButton(productFav);
                            },
                            iconData: IconBroken.heart,
                            size: 13,
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: BlocBuilder<DatabaseCubit, DatabaseState>(
                        builder: (context, state) {
                          var cubit = context.read<DatabaseCubit>();
                          var cartProduct = CartProductModel(
                            productId: product.id,
                            title: product.title,
                            category: product.category,
                            imgUrl: product.imgUrl,
                            description: product.description,
                            price: product.price,
                            discountValue: product.discountValue!,
                            rate: product.rate!,
                          );
                          return DefaultElevatedButton(
                            header: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  cubit.isCart(cartProduct)
                                      ? Icons.check_circle_outline
                                      : Icons.add,
                                  size: 16,
                                ),
                                Text(
                                  cubit.isCart(cartProduct)
                                      ? '  Done'
                                      : 'Add to Cart',
                                  style: Theme.of(context)
                                      .textTheme
                                      .button!
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                            onPressed: () {
                              cubit.cartButton(cartProduct);
                            },
                            color: cubit.isCart(cartProduct)
                                ? Colors.green
                                : defaultColor,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0, right: 25),
            child: Row(
              children: [
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        DefaultIconButton(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.cartPageRoute);
                          },
                          iconData: IconBroken.buy,
                          size: 14,
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: BlocBuilder<DatabaseCubit, DatabaseState>(
                            builder: (context, state) {
                              var cubit = context.read<DatabaseCubit>();
                              return Text(
                                ' ${cubit.cart.length} ',
                                style: Theme.of(context).textTheme.caption,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    DefaultIconButton(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      iconData: IconBroken.arrowLeftSquare,
                      size: 14,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
