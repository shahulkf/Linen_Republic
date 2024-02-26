import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linen_republic/constants/colors/colors.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final banners = [
    Image.asset(
      'assets/banner1.jpeg',
      fit: BoxFit.cover,
    ),
    Image.asset(
      'assets/banner2.jpeg',
      fit: BoxFit.cover,
    ),
    Image.asset(
      'assets/banner3.jpeg',
      fit: BoxFit.fitWidth,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: textColors,
              ),
            ),
            actions: [
              Container(
                height: 45,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: textColors),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Search your Product',
                      style: TextStyle(color: Colors.white70),
                    ),
                    Icon(
                      CupertinoIcons.search,
                      color: Colors.white70,
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 60,
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_border,
                    size: 30,
                  ))
            ]),
        body: Padding(
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
                      // viewportFraction: 1,
                      // autoPlay: true,
                      // // height: 280,
                      // enlargeCenterPage: true,
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
        ));
  }
}
