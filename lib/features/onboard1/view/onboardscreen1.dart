import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linen_republic/constants/colors/colors.dart';
import 'package:linen_republic/constants/constants.dart';
import 'package:linen_republic/features/authentication/view/login/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardScreenOne extends StatelessWidget {
  OnboardScreenOne({super.key});
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
                controller: _controller,
                itemCount: onBoardItems.length,
                itemBuilder: (context, index) {
                  final item = onBoardItems[index];
                  return OnBoardWidget(item: item);
                }),
          ),
          SizedBox(
            height: 60,
            width: 100,
            child: Column(
              children: [
                Center(
                    child: SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: const JumpingDotEffect(
                      activeDotColor: ConstColor.blackColor),
                )),
                const SizedBox(height: 10),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ));
                    },
                    child: const Text(
                      'Skip to login >>',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )),
              ],
            ),
          )
        ],
      ),
    )));
  }
}

class OnBoardWidget extends StatelessWidget {
  const OnBoardWidget({required this.item, super.key});
  final Map<String, String> item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        height20,
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(item['image']!), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(50),
          ),
          height: 500,
        ),
        height10,
        Text(
          item['title'].toString(),
          style: GoogleFonts.prata(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        height10,
        Text(
          item['subtitle'].toString(),
          style: GoogleFonts.prata(color: textColors, fontSize: 17.5),
        ),
      ],
    );
  }
}
