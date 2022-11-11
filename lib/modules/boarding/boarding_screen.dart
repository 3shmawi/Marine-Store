import 'package:beauty_supplies_project/shared/color/colors.dart';
import 'package:beauty_supplies_project/shared/components/components.dart';
import 'package:beauty_supplies_project/shared/icon/icons.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../services/cache_helper_services.dart';
import '../../utilities/enums.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.title,
    required this.image,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  OnBoardingScreenState createState() => OnBoardingScreenState();
}

class OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/login.png',
      title: 'Join now',
      body: ' صنع في مصر',
    ),
    BoardingModel(
      image: 'assets/images/search_product.png',
      title: 'All you need is here',
      body: 'هيا نستكشف أكثر ',
    ),
    BoardingModel(
      image: 'assets/images/search_product.png',
      title: 'All you need is here',
      body: 'هيا نستكشف أكثر ',
    ),
    BoardingModel(
      image: 'assets/images/search_product.png',
      title: 'All you need is here',
      body: 'هيا نستكشف أكثر ',
    ),
    BoardingModel(
      image: 'assets/images/search_product.png',
      title: 'All you need is here',
      body: 'هيا نستكشف أكثر ',
    ),
    BoardingModel(
      image: 'assets/images/search_product.png',
      title: 'All you need is here',
      body: 'هيا نستكشف أكثر ',
    ),
    BoardingModel(
      image: 'assets/images/search_product.png',
      title: 'All you need is here',
      body: 'هيا نستكشف أكثر ',
    ),
    BoardingModel(
      image: 'assets/images/search_product.png',
      title: 'All you need is here',
      body: 'هيا نستكشف أكثر ',
    ),
    BoardingModel(
      image: 'assets/images/search_product.png',
      title: 'All you need is here',
      body: 'هيا نستكشف أكثر ',
    ),
  ];

  bool isLast = false;

  void submit() {
    CacheHelper.saveData(
      key: SharedKeys.onBoarding,
      value: true,
    ).then((value) {
      if (value) {
        // navigateTo(
        //   context,
        //   const RegisterScreen(),
        // );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: defaultAppBarWithoutAnything(context, search: 'boarding'),
      body: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          TextButton(
            onPressed: () {
              // navigateAndFinish(
              //   context,
              //   const RegisterScreen(),
              // );
              submit();
            },
            child: Container(
              margin: const EdgeInsets.only(top: 30, right: 10),
              height: 50,
              width: 50,
              child: DefaultIconButton(
                iconData: IconBroken.arrowRightSquare,
                onTap: () {},
                color: defaultColor,
                size: 10,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: boardController,
                    onPageChanged: (int index) {
                      if (index == boarding.length - 1) {
                        setState(() {
                          isLast = true;
                        });
                      } else {
                        setState(() {
                          isLast = false;
                        });
                      }
                    },
                    itemBuilder: (context, index) =>
                        buildBoardingItem(boarding[index]),
                    itemCount: boarding.length,
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Row(
                  children: [
                    SmoothPageIndicator(
                      controller: boardController,
                      effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: defaultColor,
                        dotHeight: 10,
                        expansionFactor: 4,
                        dotWidth: 10,
                        spacing: 5.0,
                      ),
                      count: boarding.length,
                    ),
                    const Spacer(),
                    FloatingActionButton(
                      backgroundColor: defaultColor,
                      onPressed: () {
                        if (isLast) {
                          submit();
                          // navigateAndFinish(context, const RegisterScreen());
                        } else {
                          boardController.nextPage(
                            duration: const Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn,
                          );
                        }
                      },
                      child: const Icon(
                        IconBroken.arrowRight2,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.asset(
              model.image,
              height: 2000,
              width: 1000,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Text(
            model.title,
            style: TextStyle(
              fontSize: 24.0,
              fontFamily: 'MyFont',
              color: defaultColor,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            model.body,
            style: TextStyle(
              fontSize: 14.0,
              color: defaultColor,
              fontFamily: 'MyFont',
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
        ],
      );
}
