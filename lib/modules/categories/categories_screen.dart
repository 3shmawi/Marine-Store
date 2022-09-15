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
          ListView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(w / 17, w / 20, 0, w / 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '',
                      style: TextStyle(
                        fontSize: 27,
                        color: Colors.black.withOpacity(.6),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: w / 35),
                    Text(
                      'you can write something\nabout this app here',
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.black.withOpacity(.5),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              const DefaultTwoCategoryInRow(
                title: 'البويات',
                title2: 'كيماويات التنظيف',
                icon: IconBroken.swap,
                icon2: IconBroken.shieldFail,
                color: Color(0xfff37736),
                color2: Color(0xfff37736),
              ),
              const DefaultTwoCategoryInRow(
                title: 'مواتير',
                title2: 'قطع الغيارات',
                icon: IconBroken.swap,
                icon2: IconBroken.shieldFail,
                color: Color(0xfff37736),
                color2: Color(0xfff37736),
              ),
              const DefaultTwoCategoryInRow(
                title: 'الاكسسوارات',
                title2: 'مهمات الامان',
                icon: IconBroken.swap,
                icon2: IconBroken.shieldFail,
                color: Color(0xfff37736),
                color2: Color(0xfff37736),
              ),
              const DefaultTwoCategoryInRow(
                title: 'خامات البدن',
                title2: 'الاصلاح والبناء',
                icon: IconBroken.swap,
                icon2: IconBroken.shieldFail,
                color: Color(0xfff37736),
                color2: Color(0xfff37736),
              ),
              const DefaultTwoCategoryInRow(
                title: 'المراجعة',
                title2: 'الاستشارات',
                icon: IconBroken.wallet,
                icon2: IconBroken.shieldFail,
                color: Color(0xfff37736),
                color2: Color(0xfff37736),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w / 17),
                child: const DefaultCategoryPageCard(
                  title: 'خدمات',
                  icon: IconBroken.hide,
                  color: Color(0xfff37736),
                ),
              ),
              SizedBox(height: w / 20),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, w / 9.5, w / 15, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    // HapticFeedback.lightImpact();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) {
                    //       return const EditLocation();
                    //     },
                    //   ),
                    // );
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(99)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                      child: Container(
                        height: w / 8.5,
                        width: w / 8.5,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.05),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.settings,
                            size: w / 17,
                            color: Colors.black.withOpacity(.6),
                          ),
                        ),
                      ),
                    ),
                  ),
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

  const DefaultCategoryPageCard({
    Key? key,
    required this.color,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        // HapticFeedback.lightImpact();
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) {
        //       return route!;
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

  const DefaultTwoCategoryInRow({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    required this.icon2,
    required this.title2,
    required this.color2,
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
          ),
          DefaultCategoryPageCard(
            color: color2,
            icon: icon2,
            title: title2,
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
