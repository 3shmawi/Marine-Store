import 'package:beauty_supplies_project/modules/home/cubit/home_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/color/colors.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/icon/icons.dart';
import '../../../utilities/app_routes.dart';
import '../../home/cubit/home_state.dart';

class CategoriesOne extends StatelessWidget {
  const CategoriesOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: defaultAppBarWithoutAnything(context),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 30),
              child: Column(
                children: List.generate(
                  productImages.length,
                      (index) => InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.productDetailPageRoute,
                          arguments: productImages[index]);
                    },
                    child: Card(
                      elevation: 5,
                      margin: const EdgeInsets.all(10),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image(
                            image: CachedNetworkImageProvider(
                              productImages[index],
                            ),
                            width: double.infinity,
                            fit: BoxFit.cover,

                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'New product',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: defaultColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    const Spacer(),
                                    DefaultIconButton(
                                      backgroundColor:
                                      cubit.fav.contains(productImages[index])
                                          ? Colors.redAccent
                                          : Colors.black.withOpacity(.09),
                                      color: cubit.fav.contains(productImages[index])
                                          ? Colors.white
                                          : Colors.red,
                                      onTap: () {
                                        cubit.changeFavoriteState(
                                            productImages[index]);
                                      },
                                      iconData: IconBroken.heart,
                                      size: 15,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
