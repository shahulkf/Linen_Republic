import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linen_republic/features/account/controller/bloc/address/address_bloc.dart';
import 'package:linen_republic/features/account/controller/bloc/orders/orders_bloc.dart';
import 'package:linen_republic/features/account/controller/services/address_services.dart';
import 'package:linen_republic/features/account/controller/services/order_services.dart';
import 'package:linen_republic/features/authentication/controller/bloc/bloc/auth_bloc.dart';
import 'package:linen_republic/features/authentication/controller/services/auth_services.dart';
import 'package:linen_republic/features/cart/controller/bloc/bloc/cart_bloc.dart';
import 'package:linen_republic/features/cart/controller/cart_services/cart_services.dart';
import 'package:linen_republic/features/checkout/controller/bloc/checkout_bloc.dart';
import 'package:linen_republic/features/home/controller/bloc/search_bloc.dart';
import 'package:linen_republic/features/product/controller/bloc/product/product_bloc.dart';
import 'package:linen_republic/features/product/controller/product_services/product_services.dart';
import 'package:linen_republic/features/splash/controller/bloc/splash_bloc.dart';
import 'package:linen_republic/features/splash/view/splash_screen.dart';
import 'package:linen_republic/features/wishlist/controller/bloc/bloc/wishlist_bloc.dart';
import 'package:linen_republic/features/wishlist/controller/wishlist_services/wishlist_services.dart';
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
        BlocProvider(
          create: (context) => WishlistBloc(WishListServices()),
        ),
        BlocProvider(
          create: (context) => SearchBloc(ProductServices()),
        ),
        BlocProvider(
          create: (context) => CartBloc(CartServices()),
        ),
        BlocProvider(
          create: (context) => CheckoutBloc(),
        ),
        BlocProvider(
          create: (context) => OrdersBloc(OrderServices()),
        ),
        BlocProvider(create: (context) => SplashBloc()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Linen Threads',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
          ),
          home: const SplashScreen()),
    );
  }
}
