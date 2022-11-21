import 'dart:io';

import 'package:beauty_supplies_project/models/database_model.dart';
import 'package:beauty_supplies_project/modules/search/cubit/search_cubit.dart';
import 'package:beauty_supplies_project/modules/search/cubit/search_state.dart';
import 'package:beauty_supplies_project/shared/color/colors.dart';

import 'package:beauty_supplies_project/shared/components/components.dart';
import 'package:beauty_supplies_project/shared/icon/icons.dart';
import 'package:beauty_supplies_project/shared/sqflite_cubit/database_cubit.dart';
import 'package:beauty_supplies_project/shared/sqflite_cubit/database_state.dart';
import 'package:beauty_supplies_project/utilities/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      extendBodyBehindAppBar: true,
      appBar: defaultAppBarWithoutAnything(context,
          show: false, search: 'cartSearch'),
      body: BlocBuilder<DatabaseCubit, DatabaseState>(
        buildWhen: (previous, current) =>
            current is GetAllDataFromCartLocalDatabaseSuccessState,
        builder: (context, state) {
          var cubit = context.read<DatabaseCubit>();
          if (cubit.cart.isNotEmpty) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, count) {
                      int index = cubit.cart.length - count - 1;

                      CartProductModel product = cubit.cart[index];
                      return Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          DefaultFavoriteCard(
                            onTap: () {},
                            image: product.imgUrl,
                            title: product.title,
                            price:
                                '${getTwoDecimalDouble((cubit.getPriceAfterDiscount(product.price.toDouble(), product.discountValue!.toDouble()) * product.count).toString())} E.g',
                            category: product.category,
                            rate: product.rate!,
                            id: product.id,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10.0, right: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor:
                                          Colors.black.withOpacity(0.1),
                                      radius: 14,
                                      child: Text(
                                        '${product.count}',
                                        style: TextStyle(
                                          color: defaultColor,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                    BlocBuilder<SearchCubit, SearchState>(
                                      buildWhen: (_, current) =>
                                          current is GetCartProductsSearchState,
                                      builder: (context, state) {
                                        context
                                            .read<SearchCubit>()
                                            .getCartProducts(cubit.cart);
                                        return const SizedBox(
                                          width: 5,
                                        );
                                      },
                                    ),
                                    DefaultIconButton(
                                      onTap: () {
                                        cubit.deleteFromCartDataBase(
                                          product.dbId!,
                                        );
                                      },
                                      iconData: IconBroken.delete,
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 30.0, right: 5),
                                    child: DefaultIconButton(
                                      onTap: () {
                                        if (product.count > 1) {
                                          cubit.updateCartDataBase(
                                            product.copy(
                                              count: product.count - 1,
                                            ),
                                          );
                                        }
                                      },
                                      iconData: Icons.remove,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 30.0, right: 30),
                                    child: DefaultIconButton(
                                      onTap: () {
                                        cubit.updateCartDataBase(
                                          product.copy(
                                            count: product.count + 1,
                                          ),
                                        );
                                      },
                                      iconData: Icons.add,
                                      color: defaultColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                    itemCount: cubit.cart.length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: BlocBuilder<DatabaseCubit, DatabaseState>(
                    buildWhen: (_, current) =>
                        current is GetSumOfAllCartProductsPriceState,
                    builder: (context, state) {
                      return DefaultElevatedButton(
                        header: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              IconBroken.buy,
                            ),
                            Text(
                              '    Total ${getTwoDecimalDouble(cubit.allCartProductsPrice.toString())} E.g',
                              style: Theme.of(context)
                                  .textTheme
                                  .button!
                                  .copyWith(color: Colors.white),
                            )
                          ],
                        ),
                        onPressed: () async {
                          final Uri url = Uri.parse(
                              "whatsapp://send?phone=+201124576463&text=${cubit.whatsAppMessage}");
                          if (!await launchUrl(url)) {
                            throw 'Could not launch $url';
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const DefaultNotFoundItems(
              image: 'assets/images/cart.png',
              title: 'The Cart is empty!',
            );
          }
        },
      ),
    );
  }
}
