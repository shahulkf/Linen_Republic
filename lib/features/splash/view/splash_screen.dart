import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linen_republic/constants/colors/colors.dart';
import 'package:linen_republic/features/home/view/main_page.dart';
import 'package:linen_republic/features/onboard1/view/onboardscreen1.dart';
import 'package:linen_republic/features/splash/controller/bloc/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SplashBloc>().add(StartAppEvent());
    return Scaffold(
      backgroundColor: ConstColor.whiteColor,
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is NavigateToHomeState) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MainPage(),
                ));
          } else if (state is NavigateToAuthState) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => OnboardScreenOne(),
                ));
          }
        },
        child: const Center(
          child: Image(
              image: AssetImage(
                  'assets/62A2E7C0-F6A9-4DD0-B08E-D964DA098BE5.png')),
        ),
      ),
    );
  }
}
