import 'package:beauty_supplies_project/shared/components/components.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../shared/color/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      'https://img.yachtall.com/image-sale-boat/quicksilver-activ-905-weekend-inboard-diesel-huge-3975947b50812209.jpg',
      'https://cdn.boatinternational.com/bi_prd/bi/library_images/oHBmz3yQJC5CmNbYBJJf_lady-christine-helicopter-deck.jpg',
      'https://www.axopar.com/assets/Pages/1/65/axopar_facebook_adventures__FillWzEyMDAsNjMwXQ.jpg',
      'https://www.boatingmag.com/wp-content/uploads/sites/16/2021/09/BTG0420-BOTY-Axopar-3.jpg',
      'https://global.yamaha-motor.com/business/omdo/products/high-speed-boat/img/high-speed-boat_exteriors_004.jpg',
    ];

    List<String> categoryNames = [
      'البويات',
      'كيماويات التنظيف',
      'مواتير',
      'قطع الغيارات',
      'الاكسسوارات',
      'مهمات الامان',
      'خامات البدن',
      'الاصلاح والبناء',
      'المراجعة',
      'الاستشارات',
      'خدمات',
    ];
    List<String> categoryImages = [
      'https://orient-paints.com/wp-content/uploads/2018/07/select-color-swatch-to-paint-wall.jpg',
      'https://www.un.org/sites/un2.un.org/files/styles/large-article-image-style-16-9/public/field/image/emily_penn_1_crop_4.jpg?itok=hcl8c1Q2',
      'https://ia.eferrit.com/ia/42f9085d56bc389c.jpg',
      'https://mount-mal.com/zsefe/ihD_UKKC8mleJlAWztCtpQHaE6.jpg',
      'https://loozap.com/storage/files/eg/ooo_27-07-2019/thumb-816x460-v1_files_kfhhfp5xstry2-EG_listings360__1_.jpg',
      'https://www.ubuy.com.eg/productimg/?image=aHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0kvODFvUXYyMHV2ckwuX0FDX1NMMTUwMF8uanBn.jpg',
      'https://471004-1478099-raikfcquaxqncofqfm.stackpathdns.com/wp-content/uploads/2022/03/%D8%B5%D9%86%D8%A7%D8%B9%D8%A9-%D8%A7%D9%84%D8%B3%D9%81%D9%86-750x375.jpg',
      'https://www.nakilat.com/wp-content/uploads/2018/01/LNG-Carrier-Q-Flex-Al-Gharrafa-Dry-Docking-Services-Inspections-and-Repairs-1024x576.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAe0KIVnOVt4hE2iLZHEMIlFwhYGeSnK-OMw&usqp=CAU',
      'https://image.isu.pub/140105074138-7f347d11b63004295167c41aaea7cc9a/jpg/page_1.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsDMKNStGLIbv2qCfuQLu1qrkJcbQQ7EQHeQ&usqp=CAU',
    ];

    return Scaffold(
      backgroundColor: Colors.grey[300],
      extendBodyBehindAppBar: true,
      appBar: defaultAppBar(
        context,
        title: 'Welcome',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            CarouselSlider(
              items: List.generate(
                images.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image(
                      image: CachedNetworkImageProvider(
                        images[index],
                      ),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
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
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 154,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,

                          children: [
                             Image(
                              image: CachedNetworkImageProvider(
                                categoryImages[index],
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
                                categoryNames[index],
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
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10.0,
                      ),
                      itemCount: categoryImages.length,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'New Products',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  GridView.count(
                    padding: const EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    childAspectRatio: 1 / 1.067,
                    children: List.generate(
                      80,
                      (index) => Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Image(
                              image: CachedNetworkImageProvider(
                                'https://www.axopar.com/assets/Pages/1/65/axopar_facebook_adventures__FillWzEyMDAsNjMwXQ.jpg',
                              ),
                              width: double.infinity,
                              fit: BoxFit.cover,
                              height: 120,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Yakht',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: defaultColor,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        borderRadius: BorderRadius.circular(15),
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: CircleAvatar(
                                            radius: 15.0,
                                            backgroundColor: true
                                                ? defaultColor
                                                : Colors.grey,
                                            child: const Icon(
                                              Icons.favorite_border,
                                              size: 14.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
