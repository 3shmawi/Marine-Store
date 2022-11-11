import 'package:beauty_supplies_project/database/remote_database_controller.dart';
import 'package:beauty_supplies_project/models/carousel_slider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../shared/components/components.dart';

class CarouselSliderImageScreen extends StatelessWidget {
  const CarouselSliderImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CarouselSliderModel>>(
      stream: FireStoreDataBase().getCarouselSliderImagesStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          var images = snapshot.data;
          if (images == null || images.isEmpty) {
            return const DefaultNotFoundItems(
              image: 'assets/images/buy.png',
              title: 'No Images Available yet!',
            );
          }
          return CarouselSlider(
            items: List.generate(
              images.length,
              (count) {
                int index = images.length - count - 1;

                return Padding(
                  padding: const EdgeInsets.only(top: 10.0,right: 10,left: 10),
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: DefaultImageView(
                      image: images[index].imgUrl,

                    ),
                  ),
                );
              },
            ),
            options: CarouselOptions(
              height: 180,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
