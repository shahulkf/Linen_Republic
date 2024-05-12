import 'package:bottom_bar_matu/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:linen_republic/constants/colors/colors.dart';
import 'package:linen_republic/utils/responsive/responsive.dart';

class EventCard extends StatelessWidget {
  final child;
  final bool isPast;
  const EventCard({super.key, this.child, required this.isPast});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.height * 0.13,
      margin: const EdgeInsets.all(25),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(29),
            bottomLeft: Radius.circular(29),
          ),
          color: isPast ? colorGrey3 : ConstColor.greyColor),
      child: child,
    );
  }
}
