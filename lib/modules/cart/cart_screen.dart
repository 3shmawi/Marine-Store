
import 'package:beauty_supplies_project/shared/color/colors.dart';

import 'package:beauty_supplies_project/shared/components/components.dart';
import 'package:beauty_supplies_project/shared/icon/icons.dart';
import 'package:beauty_supplies_project/shared/sqflite_cubit/database_cubit.dart';
import 'package:beauty_supplies_project/shared/sqflite_cubit/database_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      extendBodyBehindAppBar: true,
      appBar: defaultAppBarWithoutAnything(context, show: false),
      body: BlocBuilder<DatabaseCubit, DatabaseState>(
        builder: (context, count) {
          var cubit = context.read<DatabaseCubit>();
          return cubit.cart.isNotEmpty
              ? ListView.builder(
                  itemBuilder: (context, count) {
                    int index = cubit.cart.length - count - 1;

                    return Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        DefaultFavoriteCard(
                          onTap: () {},
                          image: cubit.cart[index].imgUrl,
                          title: cubit.cart[index].title,
                          subTitle: cubit.cart[index].discountValue!
                                      .toDouble() >
                                  0
                              ? '${cubit.cart[index].price * cubit.cart[index].count * cubit.cart[index].discountValue!.toDouble() / 100} \$'
                              : '${cubit.cart[index].price * cubit.cart[index].count} \$',
                          price: cubit.cart[index].category,
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
                                      '${cubit.cart[index].count}',
                                      style: TextStyle(
                                        color: defaultColor,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  DefaultIconButton(
                                    onTap: () {
                                      cubit.deleteFromCartDataBase(
                                          cubit.cart[index].dbId!);
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
                                      if (cubit.cart[index].count > 1) {
                                        cubit.updateCartDataBase(
                                          cubit.cart[index].copy(
                                            count: cubit.cart[index].count - 1,
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
                                        cubit.cart[index].copy(
                                          count: cubit.cart[index].count + 1,
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
                )
              : const DefaultNotFoundItems(
                  image: 'assets/images/cart.png',
                  title: 'The  Cart  is  empty!',
                );
        },
      ),
    );
  }
}
