import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({
    super.key,
    required this.banners,
  });

  final List<Image> banners;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: CarouselSlider(
                items: banners,
                options: CarouselOptions(
                 
                  aspectRatio: 14 / 9,
                  viewportFraction: 1,
                  enlargeFactor: 0.15,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayCurve: Curves.linear,
                )),
          )
        ],
      ),
    );
  }
}