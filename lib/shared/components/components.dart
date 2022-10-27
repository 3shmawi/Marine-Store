import 'dart:convert';

import 'package:beauty_supplies_project/modules/home/cubit/home_cubit.dart';
import 'package:beauty_supplies_project/modules/home/cubit/home_state.dart';
import 'package:beauty_supplies_project/shared/color/colors.dart';
import 'package:beauty_supplies_project/shared/icon/icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
                onTap: () {},
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
                  child: BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      return Text(
                        ' ${context.read<HomeCubit>().cart.length} ',
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
  context,
) {
  return AppBar(
    backgroundColor: Colors.transparent,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(0, 47, 108, 0),
      //systemNavigationBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarDividerColor: Colors.black,
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
  final bool isFavCart;
  final String price;

  const DefaultFavoriteCard({
    Key? key,
    required this.onTap,
    required this.image,
    required this.title,
    required this.subTitle,
    this.isFavCart = false,
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
                  child: image.startsWith('https://')
                      ? Image(
                          image: CachedNetworkImageProvider(
                            image,
                          ),
                          width: double.infinity,
                          fit: BoxFit.cover,
                          height: 200,
                        )
                      : Image.memory(
                          base64Decode(
                            image,
                          ),
                          width: double.infinity,
                          fit: BoxFit.cover,
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
                      const SizedBox(height: 5,),
                      Text(
                        isFavCart ? 'Tap to know more' : price,
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
