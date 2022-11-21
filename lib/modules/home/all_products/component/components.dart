import 'package:beauty_supplies_project/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/product.dart';
import '../../../../shared/color/colors.dart';
import '../../../../shared/components/components.dart';
import '../../../../utilities/app_routes.dart';
import '../../../search/cubit/search_cubit.dart';
import '../../../search/cubit/search_state.dart';

class DefaultProductItem extends StatelessWidget {
  const DefaultProductItem({
    Key? key,
    required this.allProducts,
    required this.index,
  }) : super(key: key);
  final List<ProductModel> allProducts;
  final int index;

  @override
  Widget build(BuildContext context) {
    var product = allProducts[index];
    return Stack(
      alignment: AlignmentDirectional.centerEnd,
      children: [
        InkWell(
          onTap: () => Navigator.pushNamed(
            context,
            AppRoutes.productDetailPageRoute,
            arguments: product,
          ),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DefaultImageView(
                  image: product.imgUrl,
                  height: 88,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Expanded(
                          child: Text(
                          product.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium,
                      ),
                        ),

                        BlocBuilder<SearchCubit, SearchState>(
                            buildWhen: (_, current) =>
                            current is GetAllProductsSearchState,
                            builder: (context, state) {
                              context
                                  .read<SearchCubit>()
                                  .getAllProducts(allProducts);
                              return const SizedBox(
                                height: 5,
                              );
                            }),
                        if (product.discountValue == 0)
                          Text(
                            '${getTwoDecimalDouble(product.price.toString())} E.g',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: defaultColor),
                          ),
                        if (product.discountValue != 0 &&
                            product.discountValue != null)
                          Text(
                            '${getTwoDecimalDouble((product.price - (product.price * (product.discountValue!) / 100)).toString())} E.g   ',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: defaultColor),
                          ),
                        Row(
                          children: [
                            Text(
                              '${product.price} E.g    ',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${product.discountValue}%',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        DefaultRating(
                          id: product.id,
                          size: 17.5,
                          isShow: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 5.0,top: 35),
          child: SizedBox(
              width: 30,
              child: DefaultIconFavChangeState(product: product)),
        ),
      ],
    );
  }
}
