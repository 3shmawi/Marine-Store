import 'package:beauty_supplies_project/modules/home/cubit/home_cubit.dart';
import 'package:beauty_supplies_project/shared/color/colors.dart';

import 'package:beauty_supplies_project/shared/components/components.dart';
import 'package:beauty_supplies_project/shared/icon/icons.dart';
import 'package:beauty_supplies_project/utilities/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/cubit/home_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        double w = MediaQuery.of(context).size.width;

        return Scaffold(
          backgroundColor: Colors.grey[200],
          extendBodyBehindAppBar: true,
          appBar: defaultAppBarWithoutAnything(context),
          body: cubit.cart.isEmpty?Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/cart.png',
                ),

                Text(
                  'The  Cart  is  empty!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontSize: 25),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Add Some products.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontSize: 20),
                ),
              ],
            ),
          ):ListView.builder(
            itemBuilder: (context, index) {
              return Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  DefaultFavoriteCard(
                    onTap: () {
                      Navigator.pushNamed(
                          context, AppRoutes.productDetailPageRoute,arguments: cubit.cart[index].image);
                    },
                    image: cubit.cart[index].image!,
                    title: 'Title',
                    subTitle: '${cubit.cart[index].number}',
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            DefaultIconButton(
                              onTap: () {
                                cubit.changeCartState(cubit.cart[index]);
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
                            padding:
                                const EdgeInsets.only(bottom: 30.0, right: 5),
                            child: DefaultIconButton(
                              onTap: () {
                                if (cubit.cart[index].number > 1) {
                                  cubit.changeCountOfProductNumberDEc(index);
                                }
                              },
                              iconData: Icons.remove,
                              color: Colors.red,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 30.0, right: 30),
                            child: DefaultIconButton(
                              onTap: () {
                                cubit.changeCountOfProductNumberInc(index);
                              },
                              iconData: Icons.add,
                              color: defaultColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              );
            },
            itemCount: cubit.cart.length,
          ),
        );
      },
    );
  }
}
