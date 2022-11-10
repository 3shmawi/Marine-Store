import 'package:beauty_supplies_project/shared/components/components.dart';
import 'package:beauty_supplies_project/shared/icon/icons.dart';
import 'package:beauty_supplies_project/shared/sqflite_cubit/database_cubit.dart';
import 'package:beauty_supplies_project/shared/sqflite_cubit/database_state.dart';
import 'package:beauty_supplies_project/utilities/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                    var product = cubit.fav[index];
                    return Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        DefaultFavoriteCard(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.productDetailPageRoute,
                                arguments: cubit.fav[index]);
                          },
                          image: product.imgUrl,
                          title: product.title,
                          price: '${product.price} \$',
                          category: product.category,
                          rate: product.rate!,
                          id: product.id,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10.0, right: 30),
                                  child: CircleAvatar(
                                    radius: 14,
                                    backgroundColor:
                                        Colors.black.withOpacity(0.1),
                                    child: Center(
                                      child: Text(
                                        '${cubit.fav[index].discountValue}%',
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                    ),
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
      ),
    );
  }
}
