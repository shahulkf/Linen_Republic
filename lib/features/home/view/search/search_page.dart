import 'package:bottom_bar_matu/components/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linen_republic/utils/responsive/responsive.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: Responsive.height * 0.05,
          width: Responsive.width * 0.82,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: colorGrey6),
          child: CupertinoSearchTextField()
        ),
      ),
    );
  }
}
