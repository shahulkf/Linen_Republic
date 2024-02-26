import 'package:flutter/material.dart';
import 'package:linen_republic/features/onboard1/view/onboardscreen1.dart';
import 'package:linen_republic/utils/responsive/responsive.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.initScreenSize(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Linen Republic',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home: OnboardScreenOne());
  }
}
