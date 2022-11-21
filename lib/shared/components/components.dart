import 'dart:convert';
import 'dart:ui';

import 'package:beauty_supplies_project/models/database_model.dart';
import 'package:beauty_supplies_project/shared/color/colors.dart';
import 'package:beauty_supplies_project/shared/icon/icons.dart';
import 'package:beauty_supplies_project/shared/sqflite_cubit/database_cubit.dart';
import 'package:beauty_supplies_project/shared/sqflite_cubit/database_state.dart';
import 'package:beauty_supplies_project/utilities/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../database/remote_database_controller.dart';
import '../../models/category.dart';
import '../../models/product.dart';
import '../../models/rate.dart';
import '../../models/user.dart';
import '../../modules/admin_screens/upload_product/cubit/admin_upload_product_cubit.dart';
import '../../modules/admin_screens/upload_product/cubit/admin_upload_product_state.dart';
import '../../services/cache_helper_services.dart';
import '../../services/firebase_auth_services.dart';
import '../../utilities/app_routes.dart';
import '../../utilities/enums.dart';
import '../user_data_cubit/user_cubit.dart';
import '../user_data_cubit/user_state.dart';

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
                  Navigator.pushNamed(context, AppRoutes.search,
                      arguments: 'allProducts');
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
  required String search,
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
                Navigator.pushNamed(
                  context,
                  AppRoutes.search,
                  arguments: search,
                );
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
  final String category;
  final GestureTapCallback onTap;
  final String id;
  final String price;
  final int rate;

  const DefaultFavoriteCard({
    Key? key,
    required this.onTap,
    required this.image,
    required this.id,
    required this.title,
    required this.category,
    required this.rate,
    required this.price,
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
                        price,
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: defaultColor,
                          fontSize: w / 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        category,
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      DefaultRating(
                        size: 16,
                        id: id,
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
        height: w / 3,
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
            // const SizedBox(),
            // Container(
            //   height: w / 8,
            //   width: w / 8,
            //   decoration: BoxDecoration(
            //     color: color.withOpacity(.1),
            //     shape: BoxShape.circle,
            //   ),
            //   child: Icon(
            //     icon,
            //     color: color.withOpacity(.6),
            //   ),
            // ),
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
            // const SizedBox(),
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
    required this.id,
    this.size = 25,
    this.isShow= false,
  }) : super(key: key);
  final double size;
  final String id;
final bool isShow;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<RateModel>>(
      stream: FireStoreDataBase().getRateProductStream(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          var rate = snapshot.data;
          if (rate == null || rate.isEmpty) {
            return RatingBarIndicator(
              rating: 0,
              itemBuilder: (context, index) => const Icon(
                Icons.star_border,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: size,
              direction: Axis.horizontal,
            );
          }
          double rateSum = 0;
          for (var element in rate) {
            rateSum += element.rateValue;
          }
          return Row(
            children: [
              RatingBarIndicator(
                rating: rateSum / rate.length,
                itemBuilder: (context, index) => const Icon(
                  Icons.star_border,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: size,
                direction: Axis.horizontal,
              ),
              if(isShow)
              const Spacer(),
              if(isShow)
              Text(
                ' (${getTwoDecimalDouble((rateSum / rate.length).toString())})',
                style: Theme.of(context).textTheme.caption,
              ),
              Text(
                ' (${rate.length})',
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          );
        }
        return RatingBarIndicator(
          rating: 0,
          itemBuilder: (context, index) => const Icon(
            Icons.star_border,
            color: Colors.amber,
          ),
          itemCount: 5,
          itemSize: size,
          direction: Axis.horizontal,
        );
      },
    );
  }
}

class DefaultRatingFromUsr extends StatelessWidget {
  const DefaultRatingFromUsr({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<RateModel>>(
      stream: FireStoreDataBase().getRateProductStream(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          var rate = snapshot.data;
          if (rate == null || rate.isEmpty) {
            return BlocBuilder<UserCubit, UserState>(
              buildWhen: (_, current) => current is SetRateSuccessState,
              builder: (context, state) {
                var cubit = context.read<UserCubit>();
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
                  onRatingUpdate: (rateValue) {
                    cubit.setRate(
                      valueRate: RateModel(
                        id: id,
                        rateValue: rateValue,
                      ),
                      productId: id,
                    );
                  },
                );
              },
            );
          }
          return BlocBuilder<UserCubit, UserState>(
            // buildWhen: (_, current) => current is SetRateSuccessState,
            builder: (context, state) {
              var cubit = context.read<UserCubit>();
              double rateSum = 0;
              for (var element in rate) {
                rateSum += element.rateValue;
              }
              return RatingBar.builder(
                initialRating: rateSum / rate.length,
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
                onRatingUpdate: (rateValue) {
                  cubit.setRate(
                    valueRate: RateModel(
                      id: id,
                      rateValue: rateValue,
                    ),
                    productId: id,
                  );
                },
              );
            },
          );
        }
        return BlocBuilder<UserCubit, UserState>(
          buildWhen: (_, current) => current is SetRateSuccessState,
          builder: (context, state) {
            var cubit = context.read<UserCubit>();
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
              onRatingUpdate: (rateValue) {
                cubit.setRate(
                  valueRate: RateModel(
                    id: id,
                    rateValue: rateValue,
                  ),
                  productId: id,
                );
              },
            );
          },
        );
      },
    );
  }
}

class DefaultProductCard extends StatelessWidget {
  const DefaultProductCard({
    Key? key,
    required this.product,
    this.isAdmin = false,
  }) : super(key: key);
  final ProductModel product;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.productDetailPageRoute,
              arguments: product);
        },
        child: Card(
          elevation: 10,
          margin: const EdgeInsets.all(10),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                child: DefaultImageView(
                  image: product.imgUrl,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 220,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              if (product.discountValue == 0)
                                Row(
                                  children: [
                                    Text(
                                      '${getTwoDecimalDouble(product.price.toString())} E.g',
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(color: defaultColor),
                                    ),
                                    DefaultRating(
                                      id: product.id,
                                      size: 15,
                                    ),
                                  ],
                                ),
                              if (product.discountValue != 0 &&
                                  product.discountValue != null)
                                Row(
                                  children: [
                                    Text(
                                      '${getTwoDecimalDouble((product.price - (product.price * (product.discountValue!) / 100)).toString())} E.g   ',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(color: defaultColor),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${getTwoDecimalDouble(product.price.toString())} E.g',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                      ),
                                    ),
                                    Text(
                                      '   ${product.discountValue}%',
                                      style:
                                          Theme.of(context).textTheme.caption!,
                                    ),
                                    DefaultRating(
                                      id: product.id,
                                      size: 15,
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        const Spacer(),
                        isAdmin
                            ? BlocBuilder<AdminUploadProductViewCubit,
                                AdminUploadProductViewState>(
                                builder: (context, state) {
                                  var cubit = context
                                      .read<AdminUploadProductViewCubit>();
                                  return DefaultIconButton(
                                    backgroundColor:
                                        Colors.black.withOpacity(.09),
                                    color: Colors.red,
                                    onTap: () {
                                      cubit.deleteProduct(
                                        product.id,
                                        product.category,
                                      );
                                    },
                                    iconData: IconBroken.delete,
                                    size: 15,
                                  );
                                },
                              )
                            : BlocBuilder<DatabaseCubit, DatabaseState>(
                                builder: (context, state) {
                                  var cubit = context.read<DatabaseCubit>();
                                  var favProduct = FavProductModel(
                                    productId: product.id,
                                    title: product.title,
                                    category: product.category,
                                    imgUrl: product.imgUrl,
                                    description: product.description,
                                    price: product.price,
                                    discountValue: product.discountValue!,
                                    rate: product.rate!,
                                  );
                                  return DefaultIconButton(
                                    backgroundColor: cubit.isFav(favProduct)
                                        ? Colors.redAccent
                                        : Colors.black.withOpacity(.1),
                                    color: cubit.isFav(favProduct)
                                        ? Colors.white
                                        : defaultColor,
                                    onTap: () {
                                      cubit.favoriteButton(favProduct);
                                    },
                                    iconData: IconBroken.heart,
                                  );
                                },
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
    );
  }
}

class DefaultIconFavChangeState extends StatelessWidget {
  const DefaultIconFavChangeState({
    Key? key,
    required this.product,
  }) : super(key: key);
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatabaseCubit, DatabaseState>(
      builder: (context, state) {
        var cubit = context.read<DatabaseCubit>();
        var favProduct = FavProductModel(
          productId: product.id,
          title: product.title,
          category: product.category,
          imgUrl: product.imgUrl,
          description: product.description,
          price: product.price,
          discountValue: product.discountValue!,
          rate: product.rate!,
        );
        return DefaultIconButton(
          backgroundColor: cubit.isFav(favProduct)
              ? Colors.redAccent
              : Colors.black.withOpacity(.1),
          color: cubit.isFav(favProduct) ? Colors.white : defaultColor,
          onTap: () {
            cubit.favoriteButton(favProduct);
          },
          iconData: IconBroken.heart,
        );
      },
    );
  }
}


class DefaultUserNameAndEmail extends StatelessWidget {
  const DefaultUserNameAndEmail({super.key});


  @override
  Widget build(BuildContext context) {
    String userId =CacheHelper.getData(key: SharedKeys.id);
    return  Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        left: 10,
        bottom: 25,
      ),
      child: StreamBuilder<UserModel>(
        stream: FireStoreDataBase().getUserDataStream(userId),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.active){
            var data = snapshot.data;
            if(data == null)
            {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 40,
                    child: Icon(
                      IconBroken.profile,
                      size: 40,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User Name',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'User Email',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 40,
                  child: Icon(
                    IconBroken.profile,
                    size: 40,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          Auth().currentUser!.email ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator(),);
        },

      ),
    );
  }
}
