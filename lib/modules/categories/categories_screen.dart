import 'package:beauty_supplies_project/database/database_controller.dart';
import 'package:beauty_supplies_project/models/cart.dart';
import 'package:beauty_supplies_project/models/category.dart';
import 'package:beauty_supplies_project/shared/components/components.dart';
import 'package:beauty_supplies_project/utilities/app_routes.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import '../../shared/icon/icons.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          /// ListView
          Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: StreamBuilder<List<CategoryModel>>(
                  stream: FireStoreDataBase().getCategoryStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      var category = snapshot.data;
                      if (category == null || category.isEmpty) {
                        return Center(
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/sala.png',
                                height: 200,
                                width: double.infinity,
                              ),
                              Text(
                                'No Products founded yet!',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(fontSize: 25),
                              ),
                            ],
                          ),
                        );
                      }
                      return Wrap(
                        alignment: WrapAlignment.center,
                        children: List.generate(
                          category.length,
                          (index) => Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: DefaultCategoryPageCard(
                              color: Colors.green,
                              icon: Icons.add,
                              title: category[index].name,
                              onTap: () {},
                            ),
                          ),
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    DefaultIconButton(
                      onTap: () {},
                      iconData: IconBroken.setting,
                      size: 12,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const BlurTheStatusCard(),
        ],
      ),
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

class DefaultTwoCategoryInRow extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final Color color2;
  final IconData icon2;
  final String title2;
  final GestureTapCallback onTap;
  final GestureTapCallback onTap2;

  const DefaultTwoCategoryInRow({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    required this.icon2,
    required this.title2,
    required this.color2,
    required this.onTap,
    required this.onTap2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(bottom: w / 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          DefaultCategoryPageCard(
            color: color,
            icon: icon,
            title: title,
            onTap: onTap,
          ),
          DefaultCategoryPageCard(
            color: color2,
            icon: icon2,
            title: title2,
            onTap: onTap2,
          ),
        ],
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
