import 'package:flutter/material.dart';
import 'package:linen_republic/constants/colors/colors.dart';
import 'package:linen_republic/features/account/orders/widgets/event_card.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimeLineTile extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final eventCard;
  const TimeLineTile(
      {super.key,
      required this.isFirst,
      required this.isLast,
      required this.isPast,
      required this.eventCard});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: LineStyle(
          color: isPast ? ConstColor.blackColor : ConstColor.greyColor,
        ),
        indicatorStyle: IndicatorStyle(
          width: 30,
          color: isPast ? ConstColor.blackColor : ConstColor.greyColor,
          iconStyle: IconStyle(
              iconData: Icons.done,
              color: isPast ? ConstColor.whiteColor : ConstColor.greyColor),
        ),
        endChild: EventCard(
          isPast: isPast,
          child: eventCard,
        ),
      ),
    );
  }
}
