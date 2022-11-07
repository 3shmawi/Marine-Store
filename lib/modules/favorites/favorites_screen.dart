import 'package:beauty_supplies_project/modules/home/cubit/home_cubit.dart';

import 'package:beauty_supplies_project/shared/components/components.dart';
import 'package:beauty_supplies_project/shared/icon/icons.dart';
import 'package:beauty_supplies_project/shared/sqflite_cubit/database_cubit.dart';
import 'package:beauty_supplies_project/shared/sqflite_cubit/database_cubit.dart';
import 'package:beauty_supplies_project/shared/sqflite_cubit/database_state.dart';
import 'package:beauty_supplies_project/utilities/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/cubit/home_state.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: BlocBuilder<DatabaseCubit, DatabaseState>(
        builder: (context, state) {
          var cubit = context.read<DatabaseCubit>();
          return cubit.fav.isNotEmpty
              ? ListView.builder(
            itemBuilder: (context, count) {
              int index = cubit.fav.length - count - 1;
              return Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  DefaultFavoriteCard(
                    onTap: () {
                      Navigator.pushNamed(
                          context, AppRoutes.productDetailPageRoute,
                          arguments: cubit.fav[index]);
                    },
                    image: cubit.fav[index].imgUrl,
                    title: cubit.fav[index].title,
                    subTitle: cubit.fav[index].category,
                    price: '${cubit.fav[index].price}',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 10.0, right: 30),
                            child: DefaultIconButton(
                              onTap: () {},
                              iconData: IconBroken.buy,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 30.0, right: 30),
                            child: DefaultIconButton(
                              onTap: () {
                                cubit.deleteFromFavDataBase(
                                    cubit.fav[index].dbId!);
                              },
                              iconData: IconBroken.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              );
            },
            itemCount: cubit.fav.length,
          )
              : const DefaultNotFoundItems(
            image: 'assets/images/buy.png',
            title: 'No, Fav Products yet!',
          );
        },
      ),);
  }
}
