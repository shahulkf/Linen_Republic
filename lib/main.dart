import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linen_republic/features/account/controller/bloc/bloc/address_bloc.dart';
import 'package:linen_republic/features/account/controller/services/address_services.dart';
import 'package:linen_republic/features/authentication/controller/bloc/bloc/auth_bloc.dart';
import 'package:linen_republic/features/authentication/controller/services/auth_services.dart';
import 'package:linen_republic/features/home/view/main_page.dart';
import 'package:linen_republic/features/onboard1/view/onboardscreen1.dart';
import 'package:linen_republic/features/product/controller/bloc/product/product_bloc.dart';
import 'package:linen_republic/features/product/controller/product_services/product_services.dart';
import 'package:linen_republic/firebase_options.dart';
import 'package:linen_republic/utils/responsive/responsive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.initScreenSize(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBlocBloc(AuthenticationServices()),
        ),
        BlocProvider(
          create: (context) => ProductBloc(ProductServices()),
        ),
        BlocProvider(
          create: (context) => AddressBloc(AddressService()),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Linen Republic',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
          ),
          home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return MainPage();
                }
                return OnboardScreenOne();
              })),
    );
  }
}
