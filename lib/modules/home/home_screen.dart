import 'package:beauty_supplies_project/modules/home/cubit/home_cubit.dart';
import 'package:beauty_supplies_project/shared/components/components.dart';
import 'package:beauty_supplies_project/utilities/app_routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/color/colors.dart';
import '../../shared/components/constants.dart';
import '../../shared/icon/icons.dart';
import 'cubit/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.grey[300],
          extendBodyBehindAppBar: true,
          appBar: defaultAppBar(
            context,
            title: 'Welcome',
            cubit,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                CarouselSlider(
                  items: List.generate(
                    images.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image(
                          image: CachedNetworkImageProvider(
                            images[index],
                          ),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ),
                  options: CarouselOptions(
                    height: 180,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Categories',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        height: 154,
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => InkWell(
                            onTap: (){Navigator.pushNamed(context, AppRoutes.categoryOnePageRoute);},
                            child: Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Image(
                                    image: CachedNetworkImageProvider(
                                      categoryImages[index],
                                    ),
                                    height: 120.0,
                                    width: 150.0,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    alignment: AlignmentDirectional.centerEnd,
                                    color: Colors.white,
                                    width: 150.0,
                                    child: Text(
                                      categoryNames[index],
                                      maxLines: 1,
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.end,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: defaultColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 10.0,
                          ),
                          itemCount: categoryImages.length,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'New Products',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      GridView.count(
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 1.0,
                        crossAxisSpacing: 1.0,
                        childAspectRatio: 1 / 1.067,
                        children: List.generate(
                          productImages.length,
                          (index) => InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.productDetailPageRoute,arguments: productImages[index]);
                            },
                            child: Card(
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
                                    height: 120,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                              backgroundColor: cubit.fav
                                                      .contains(
                                                          productImages[index])
                                                  ? Colors.redAccent
                                                  : Colors.black
                                                      .withOpacity(.09),
                                              color: cubit.fav.contains(
                                                      productImages[index])
                                                  ? Colors.white
                                                  : Colors.red,
                                              onTap: () {
                                                cubit.changeFavoriteState(
                                                    productImages[index]);
                                              },
                                              iconData: IconBroken.heart,
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
