import 'package:beauty_supplies_project/modules/home/cubit/home_cubit.dart';

import 'package:beauty_supplies_project/shared/components/components.dart';
import 'package:beauty_supplies_project/shared/icon/icons.dart';
import 'package:beauty_supplies_project/utilities/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/cubit/home_state.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

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
          body: ListView.builder(
            itemBuilder: (context, index) => Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                DefaultFavoriteCard(
                  onTap: () {
                    Navigator.pushNamed(
                        context, AppRoutes.productDetailPageRoute,
                        arguments: cubit.fav[index]);
                  },
                  image: cubit.fav[index],
                  title: 'Title',
                  subTitle: 'subTitle',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 10.0, right: 30),
                          child: DefaultIconButton(
                            onTap: () {},
                            iconData: IconBroken.buy,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 30.0, right: 30),
                          child: DefaultIconButton(
                            onTap: () {
                              cubit.changeFavoriteState(cubit.fav[index]);
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
            ),
            itemCount: cubit.fav.length,
          ),
        );
      },
    );
  }
}
