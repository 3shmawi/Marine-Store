import 'package:beauty_supplies_project/modules/home/all_products/all_products_screen.dart';

import 'package:beauty_supplies_project/shared/components/components.dart';
import 'package:flutter/material.dart';

import 'carousel_slider_image/carousel_slider_image.dart';
import 'category/category_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      extendBodyBehindAppBar: true,
      appBar: defaultAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height / 9,
            ),
            const CarouselSliderImageScreen(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  TextHeader(
                    header: 'Categories',
                  ),
                  CategorySection(),
                  TextHeader(
                    header: 'All Products',
                  ),
                  AllProducts(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


