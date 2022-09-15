import 'package:beauty_supplies_project/shared/icon/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/layout_cubit.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        double displayWidth = MediaQuery.of(context).size.width;
        return Scaffold(
          backgroundColor: Colors.grey[300],

          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: Container(
            margin: EdgeInsets.only(
              //top: displayWidth * 0.01,
              bottom: 5,
              left: displayWidth * .02,
              right: displayWidth * .01,
            ),
            height: displayWidth * .12,
            width: displayWidth * .7,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.2),
                  blurRadius: 10,
                  spreadRadius: 5,
                  //offset: const Offset(0, 10),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(
                right: 1,
              ),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  cubit.changeBottom(index);
                  // setState(() {
                  //   cubit.currentIndex = index;
                  //   HapticFeedback.lightImpact();
                  // });
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: index == cubit.currentIndex
                        ? index == 3
                            ? 10
                            : 10.0
                        : index == 3
                            ? 8
                            : index == 2
                                ? 10
                                : 0,
                  ),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: index == cubit.currentIndex
                            ? displayWidth * .12
                            : 0,
                        width: index == cubit.currentIndex
                            ? index == 0
                                ? displayWidth * 0.25
                                : index == 3
                                    ? displayWidth * .28
                                    : displayWidth * .33
                            : 0,
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 2),
                          curve: Curves.fastLinearToSlowEaseIn,
                          alignment: Alignment.center,
                          child: AnimatedContainer(
                            duration: const Duration(seconds: 2),
                            curve: Curves.fastLinearToSlowEaseIn,
                            decoration: BoxDecoration(
                              color: index == cubit.currentIndex
                                  ? Colors.blueAccent.withOpacity(.2)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                        width: index == cubit.currentIndex
                            ? displayWidth * .3
                            : displayWidth * .2,
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  width: index == cubit.currentIndex
                                      ? displayWidth * .12
                                      : 0,
                                ),
                                AnimatedOpacity(
                                  opacity: index == cubit.currentIndex ? 1 : 0,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  child: Text(
                                    index == cubit.currentIndex
                                        ? cubit.listOfStrings[index]
                                        : '',
                                    style: const TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(seconds: 2),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  width: index == cubit.currentIndex
                                      ? displayWidth * .03
                                      : displayWidth * .05,
                                ),
                                Icon(
                                  cubit.listOfIcons[index],
                                  size: displayWidth * .07,
                                  color: index == cubit.currentIndex
                                      ? Colors.blueAccent
                                      : Colors.black26,
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
        );
      },
    );
  }
}
