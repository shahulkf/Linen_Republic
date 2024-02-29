import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linen_republic/constants/colors/colors.dart';
import 'package:linen_republic/constants/constants.dart';
import 'package:linen_republic/features/home/widgets/banner_widget.dart';
import 'package:linen_republic/features/home/widgets/product_view_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: const Padding(
              padding: EdgeInsets.all(8.0),
            ),
            actions: [
              Container(
                height: 45,
                width: 280,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey.shade400),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BannerWidget(banners: banners),
              height20,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Categories',
                  style: GoogleFonts.prata(fontSize: 25),
                ),
              ),
              height10,
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                            color: index == 1
                                ? ConstColor.blackColor
                                : ConstColor.greyColor,
                            borderRadius: BorderRadius.circular(25)),
                        child: Center(
                            child: Text(
                          categories[index],
                          style: TextStyle(
                            color: index == 1
                                ? Colors.white
                                : ConstColor.blackColor,
                          ),
                        )),
                      ),
                    );
                  },
                ),
              ),
              height30,
              Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1.3 / 2.5, crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return const ProductViewWidget();
                    },
                  ))
            ],
          ),
        ));
  }
}
