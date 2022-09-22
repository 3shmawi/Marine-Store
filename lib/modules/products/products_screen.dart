import 'package:beauty_supplies_project/models/cart.dart';
import 'package:beauty_supplies_project/modules/home/cubit/home_cubit.dart';
import 'package:beauty_supplies_project/shared/components/components.dart';
import 'package:beauty_supplies_project/shared/icon/icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../utilities/app_routes.dart';
import '../home/cubit/home_state.dart';

class ProductDetailsScreen extends StatelessWidget {
  final CartModel cartModel;

  const ProductDetailsScreen({
    Key? key,
    required this.cartModel,
  }) : super(key: key);

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
                            const Text(
                              'Yacht',
                              style: TextStyle(
                                fontSize: 42.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFF17532),
                              ),
                            ),
                            const SizedBox(height: 30.0),
                            Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Image(
                                image: CachedNetworkImageProvider(
                                  cartModel.image!,
                                ),
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            const Text(
                              'Lovers Boat',
                              style: TextStyle(
                                  color: Color(0xFF575E67), fontSize: 24.0),
                            ),
                            const SizedBox(height: 10.0),
                            RatingBarIndicator(
                              rating: 2.75,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star_border,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 25.0,
                              direction: Axis.horizontal,
                            ),
                            const SizedBox(height: 20.0),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 50.0,
                              child: const Text(
                                'Set your vacation to the tune of summery delight at Ramses Hilton. Rooted at the core of Egyptian’s metropolis, Cairo, on the east riverbank of the Nile, this majestic hotel is the perfect palatial re...',
                                textAlign: TextAlign.start,
                                style: TextStyle(
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
                          child: DefaultIconButton(
                            backgroundColor:
                                cubit.fav.contains(cartModel.image)
                                    ? Colors.redAccent
                                    : Colors.black.withOpacity(.09),
                            color: cubit.fav.contains(cartModel.image)
                                ? Colors.white
                                : Colors.red,
                            onTap: () {
                              cubit.changeFavoriteState(cartModel.image!);
                            },
                            iconData: IconBroken.heart,
                            size: 13,
                          ),
                        ),
                        Expanded(

                          child: DefaultElevatedButton(
                            header: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.add,
                                  size: 16,
                                ),
                                Text(
                                  'Add to Cart',
                                  style: Theme.of(context)
                                      .textTheme
                                      .button!
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                            onPressed: () {
                              cubit.changeCartState(cartModel);
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
                              child: Text(
                                ' ${cubit.cart.length} ',
                                style: Theme.of(context).textTheme.caption,
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
      },
    );
  }
}
