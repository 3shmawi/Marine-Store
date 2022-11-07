import 'dart:convert';
import 'dart:ui';

import 'package:beauty_supplies_project/models/database_model.dart';
import 'package:beauty_supplies_project/services/local_database.dart';
import 'package:beauty_supplies_project/shared/color/colors.dart';
import 'package:beauty_supplies_project/shared/icon/icons.dart';
import 'package:beauty_supplies_project/shared/sqflite_cubit/database_cubit.dart';
import 'package:beauty_supplies_project/shared/sqflite_cubit/database_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/category.dart';
import '../../utilities/app_routes.dart';

void showToast({
  required String text,
  required Color color,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0,
    );

class DefaultFormField extends StatelessWidget {
  final IconData prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final bool isPassword;
  final String hintText;

  const DefaultFormField({
    Key? key,
    required this.textInputType,
    required this.textEditingController,
    required this.prefixIcon,
    required this.hintText,
    this.suffixIcon,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.width / 8,
      width: size.width / 1.22,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: size.width / 30),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: textEditingController,
        style: TextStyle(color: Colors.black.withOpacity(.8)),
        obscureText: isPassword,
        keyboardType: textInputType,
        decoration: InputDecoration(
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.black.withOpacity(.7),
          ),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle:
              TextStyle(fontSize: 14, color: Colors.black.withOpacity(.5)),
        ),
      ),
    );
  }
}

class DefaultTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double width;

  const DefaultTextButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        height: size.width / 8,
        width: size.width / width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          // color: const Color(0xff4796ff),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text.toUpperCase(),
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class DefaultOutLineButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;

  const DefaultOutLineButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: OutlinedButton(
        onPressed: onPressed,
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
            fontFamily: 'MyFont',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class DefaultSignWithCard extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final bool isThereBackgroundColor;

  const DefaultSignWithCard(
      {this.isThereBackgroundColor = true,
      required this.text,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              15,
            ),
            border: Border.all(
                color: isThereBackgroundColor ? Colors.white : Colors.black)),
        child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              foregroundColor: MaterialStateProperty.all(
                  !isThereBackgroundColor ? Colors.white : Colors.black),
              padding: MaterialStateProperty.all(const EdgeInsets.all(18)),
              backgroundColor: MaterialStateProperty.all(
                  isThereBackgroundColor ? Colors.deepPurple : Colors.white),
              elevation: MaterialStateProperty.all(0)),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isThereBackgroundColor
                  ? Icon(
                      Icons.facebook,
                      color:
                          isThereBackgroundColor ? Colors.white : Colors.black,
                    )
                  : Icon(
                      Icons.g_mobiledata_outlined,
                      color:
                          isThereBackgroundColor ? Colors.white : Colors.black,
                    ),
              const SizedBox(
                width: 30,
              ),
              Text(
                text,
                style: TextStyle(
                    color:
                        isThereBackgroundColor ? Colors.white : Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DefaultDashLineWithTextOr extends StatelessWidget {
  const DefaultDashLineWithTextOr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 45,
        left: 45,
        top: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: 1,
              color: Colors.black,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'Or Sign with...',
              style: TextStyle(color: Color(0xff1A110E), fontSize: 11),
            ),
          ),
          Expanded(
            child: Container(
              height: 1,
              color: const Color(0xff1A110E),
            ),
          ),
        ],
      ),
    );
  }
}

class DefaultElevatedButton extends StatelessWidget {
  final Widget header;
  final VoidCallback? onPressed;
  final Color? color;

  const DefaultElevatedButton({
    Key? key,
    required this.header,
    required this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.width / 8,
      width: size.width / 1.22,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: color ?? defaultColor,
          fixedSize: const Size(1000, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: header,
      ),
    );
  }
}

PreferredSize defaultAppBar(context) {
  return PreferredSize(
    preferredSize: const Size(double.infinity, kToolbarHeight),
    child: ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
      child: AppBar(
        // brightness: Brightness.light,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color.fromRGBO(0, 47, 108, 0),
          //systemNavigationBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.black,
          systemNavigationBarDividerColor: Colors.black,
        ),
        backgroundColor: Colors.white.withOpacity(.5),
        elevation: 0,

        title: Row(
          children: [
            Expanded(
              flex: 5,
              child: InkWell(
                onTap: () {
                  EcommerceCartDatabase.instance.close().then((value) {
                    debugPrint('deleted successfully');
                  });
                  EcommerceCartDatabase.instance
                      .insertDataToFavoriteDatabase(
                    product: FavProductModel(
                      title: 'title2',
                      imgUrl:
                          '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',
                      description: 'description',
                      category: 'category',
                      discountValue: 10,
                      price: 1000,
                      rate: 10,
                      productId: 'ProductId',
                    ),
                  )
                      .then((value) {
                    debugPrint('insert to database successfully');
                    debugPrint(value.imgUrl);
                  }).catchError((error) {
                    debugPrint('error => $error');
                  });
                },
                borderRadius: BorderRadius.circular(15),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(
                          IconBroken.search,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Search about you need',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 14,
                              ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                DefaultIconButton(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.cartPageRoute);
                  },
                  iconData: IconBroken.buy,
                  size: 12,
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: BlocBuilder<DatabaseCubit, DatabaseState>(
                    builder: (context, state) {
                      var cubit = context.read<DatabaseCubit>();
                      return Text(
                        ' ${cubit.cart.length} ',
                        style: Theme.of(context).textTheme.caption,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

AppBar defaultAppBarWithoutAnything(
  context, {
  bool show = true,
}) {
  return AppBar(
    titleSpacing: 0,
    backgroundColor: Colors.transparent,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(0, 47, 108, 0),
      //systemNavigationBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarDividerColor: Colors.black,
    ),
    leading: InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Icon(
          IconBroken.arrowLeftSquare,
          color: defaultColor,
          size: 30,
        ),
      ),
    ),
    title: Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: InkWell(
              onTap: () {
                // EcommerceCartDatabase.instance.close().then((value) {
                //   debugPrint('deleted successfully');
                // });
                // EcommerceCartDatabase.instance
                //     .insertDataToFavoriteDatabase(
                //   product: FavProductModel(
                //     title: 'title2',
                //     imgUrl:
                //     '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',
                //     description: 'description',
                //     category: 'category',
                //     discountValue: 10,
                //     price: 1000,
                //     rate: 10,
                //     productId: 'ProductId',
                //   ),
                // )
                //     .then((value) {
                //   debugPrint('insert to database successfully');
                //   debugPrint(value.imgUrl);
                // }).catchError((error) {
                //   debugPrint('error => $error');
                // });
              },
              borderRadius: BorderRadius.circular(15),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(
                        IconBroken.search,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Search about you need',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              fontSize: 14,
                            ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (show)
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                DefaultIconButton(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.cartPageRoute);
                  },
                  iconData: IconBroken.buy,
                  size: 12,
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: BlocBuilder<DatabaseCubit, DatabaseState>(
                    builder: (context, state) {
                      var cubit = context.read<DatabaseCubit>();
                      return Text(
                        ' ${cubit.cart.length} ',
                        style: Theme.of(context).textTheme.caption,
                      );
                    },
                  ),
                ),
              ],
            ),
        ],
      ),
    ),
  );
}

class DefaultCardCategory extends StatefulWidget {
  final IconData iconData;
  final String header;
  final Color color;

  const DefaultCardCategory({
    Key? key,
    required this.iconData,
    required this.header,
    required this.color,
  }) : super(key: key);

  @override
  State<DefaultCardCategory> createState() => _DefaultCardCategoryState();
}

class _DefaultCardCategoryState extends State<DefaultCardCategory>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _animation2;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });

    _animation2 = Tween<double>(begin: -30, end: 0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Opacity(
      opacity: _animation.value,
      child: Transform.translate(
        offset: Offset(0, _animation2.value),
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            // HapticFeedback.lightImpact();
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) {
            //       return null;
            //     },
            //   ),
            // );
          },
          child: Container(
            padding: const EdgeInsets.all(15),
            height: w / 2,
            width: w / 2.4,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff040039).withOpacity(.15),
                  blurRadius: 99,
                ),
              ],
              borderRadius: const BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(),
                Container(
                  height: w / 8,
                  width: w / 8,
                  decoration: BoxDecoration(
                    color: widget.color.withOpacity(.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.iconData,
                    color: widget.color.withOpacity(.6),
                  ),
                ),
                Text(
                  widget.header,
                  maxLines: 4,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black.withOpacity(.5),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DefaultFavoriteCard extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;
  final GestureTapCallback onTap;

  final String price;

  const DefaultFavoriteCard({
    Key? key,
    required this.onTap,
    required this.image,
    required this.title,
    required this.subTitle,

    this.price = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Container(
      height: w / 2.3,
      width: w,
      padding: EdgeInsets.fromLTRB(w / 20, 0, w / 20, w / 20),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            border: Border.all(color: Colors.white.withOpacity(.1), width: 1),
          ),
          child: Padding(
            padding: EdgeInsets.all(w / 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: w / 3,
                  width: w / 3,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.2),
                      borderRadius: BorderRadius.circular(15)),
                  child: DefaultImageView(
                    image: image,
                    height: 200,
                  ),
                ),
                SizedBox(width: w / 40),
                SizedBox(
                  width: w / 2.05,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: defaultColor,
                          fontSize: w / 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          wordSpacing: 1,
                        ),
                      ),
                      Text(
                        subTitle,
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: defaultColor,
                          fontSize: w / 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                       price,
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DefaultIconButton extends StatelessWidget {
  final IconData iconData;
  final GestureTapCallback onTap;
  final Color color;
  final Color? backgroundColor;
  final double size;

  const DefaultIconButton({
    Key? key,
    required this.onTap,
    required this.iconData,
    this.color = Colors.blueAccent,
    this.backgroundColor,
    this.size = 17,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return InkWell(
      borderRadius: BorderRadius.circular(99),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.black.withOpacity(.05),
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Center(
            child: Icon(
              iconData,
              size: w / size,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}

Future navigateAndFinish(context, route) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => route,
      ),
      (route) => false,
    );

class DefaultNotFoundItems extends StatelessWidget {
  const DefaultNotFoundItems({
    Key? key,
    required this.image,
    required this.title,
    this.height = 200,
  }) : super(key: key);
  final String image;
  final double height;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: height,
            width: double.infinity,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 25),
          ),
        ],
      ),
    );
  }
}

class DefaultImageView extends StatelessWidget {
  const DefaultImageView({
    Key? key,
    required this.image,
    this.height,
  }) : super(key: key);
  final String image;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return image.startsWith('https://')
        ? Image(
            image: CachedNetworkImageProvider(
              image,
            ),
            width: double.infinity,
            fit: BoxFit.cover,
            height: height,
          )
        : Image.memory(
            base64Decode(
              image,
            ),
            width: double.infinity,
            fit: BoxFit.cover,
            height: height,
          );
  }
}

class DefaultCategoryPageCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final GestureTapCallback onTap;

  const DefaultCategoryPageCard({
    Key? key,
    required this.color,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        height: w / 2,
        width: w / 2.4,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xff040039).withOpacity(.15),
              blurRadius: 99,
            ),
          ],
          borderRadius: const BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(),
            Container(
              height: w / 8,
              width: w / 8,
              decoration: BoxDecoration(
                color: color.withOpacity(.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color.withOpacity(.6),
              ),
            ),
            Text(
              title,
              maxLines: 4,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black.withOpacity(.5),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class BlurTheStatusCard extends StatelessWidget {
  const BlurTheStatusCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
        child: Container(
          height: w / 13,
          color: Colors.transparent,
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.category,
    required this.index,
  }) : super(key: key);

  final List<CategoryModel> category;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Image(
            image: CachedNetworkImageProvider(
              category[index].imgUrl,
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
              category[index].name,
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
    );
  }
}

class TextHeader extends StatelessWidget {
  const TextHeader({
    Key? key,
    required this.header,
  }) : super(key: key);
  final String header;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 10),
      child: Text(
        header,
        style: Theme.of(context).textTheme.headline5!.copyWith(
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class DefaultRating extends StatelessWidget {
  const DefaultRating({
    Key? key,
    required this.rate,
    this.size = 25,
  }) : super(key: key);
  final double rate;
  final double size;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rate,
      itemBuilder: (context, index) => const Icon(
        Icons.star_border,
        color: Colors.amber,
      ),
      itemCount: 5,
      itemSize: size,
      direction: Axis.horizontal,
    );
  }
}

class DefaultRatingFromUsr extends StatelessWidget {
  const DefaultRatingFromUsr({Key? key, required this.onRating})
      : super(key: key);
  final ValueChanged<double> onRating;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: 0,
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 30,
      unratedColor: Colors.grey[300],
      itemBuilder: (context, _) => const Icon(
        Icons.star_border,
        color: Colors.amber,
      ),
      onRatingUpdate: onRating,
    );
  }
}
