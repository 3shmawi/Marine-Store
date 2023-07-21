import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'dart:async';

import '../../../services/cache_helper_services.dart';
import '../../../utilities/enums/shared_pref.dart';
import '../../../utilities/routes/screens_route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  String userId = CacheHelper.getData(key: SharedPrefKeys.id) ?? '';
  bool isBoard = CacheHelper.getData(key: SharedPrefKeys.onBoarding) ?? false;

  Timer? _timer;
  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();

    _timer = Timer(const Duration(milliseconds: 400), () {
      setState(() {
        _a = true;
      });
    });
    _timer = Timer(const Duration(milliseconds: 400), () {
      setState(() {
        _b = true;
      });
    });
    _timer = Timer(const Duration(milliseconds: 1300), () {
      setState(() {
        _c = true;
      });
    });
    _timer = Timer(const Duration(milliseconds: 1700), () {
      setState(() {
        _e = true;
      });
    });
    _timer = Timer(const Duration(milliseconds: 3400), () {
      setState(() {
        _d = true;
      });
    });
    _timer = Timer(const Duration(milliseconds: 3850), () {
      setState(() {
        Navigator.of(context).pushReplacementNamed(
          !isBoard
              ? ScreenRoute.onBoardingScreenRoute
              : userId == ''
                  ? ScreenRoute.authScreenRoute
                  : ScreenRoute.landingScreenRoute,
        );
      });
    });
  }

  bool _a = false;
  bool _b = false;
  bool _c = false;
  bool _d = false;
  bool _e = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    if (kDebugMode) {
      print(userId);
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: _d ? 900 : 2500),
              curve: _d ? Curves.fastLinearToSlowEaseIn : Curves.elasticOut,
              height: _d
                  ? 0
                  : _a
                      ? h / 2
                      : 20,
              width: 20,
              // color: Colors.deepPurpleAccent,
            ),
            AnimatedContainer(
              duration: Duration(
                  seconds: _d
                      ? 1
                      : _c
                          ? 2
                          : 0),
              curve: Curves.fastLinearToSlowEaseIn,
              height: _d
                  ? h
                  : _c
                      ? 80
                      : 20,
              width: _d
                  ? w
                  : _c
                      ? 200
                      : 20,
              decoration: BoxDecoration(
                  color: _b ? Colors.white : Colors.transparent,
                  // shape: _c? BoxShape.rectangle : BoxShape.circle,
                  borderRadius: _d
                      ? const BorderRadius.only()
                      : BorderRadius.circular(30)),
              child: Center(
                child: _e
                    ? AnimatedTextKit(
                        totalRepeatCount: 1,
                        animatedTexts: [
                          FadeAnimatedText(
                            'رِوايتي',
                            duration: const Duration(milliseconds: 1700),
                            textStyle: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
