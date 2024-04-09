import 'package:bottom_bar_matu/components/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linen_republic/constants/app_strings/app_strings.dart';
import 'package:linen_republic/constants/colors/colors.dart';
import 'package:linen_republic/constants/constants.dart';
import 'package:linen_republic/features/cart/bloc/bloc/cart_bloc.dart';
import 'package:linen_republic/features/cart/model/cartmodel.dart';
import 'package:linen_republic/features/home/model/product_model.dart';
import 'package:linen_republic/features/home/widgets/bottom_nav.dart';
import 'package:linen_republic/features/product/controller/bloc/product/product_bloc.dart';
import 'package:linen_republic/features/product/model/product_model.dart';
import 'package:linen_republic/utils/responsive/responsive.dart';
import 'package:slide_to_act/slide_to_act.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final sizeWithQuantity = {
      'S': product.small,
      'M': product.medium,
      'L': product.large,
      'XL': product.xl,
    };
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductBloc>().add(
          SelectSizeEvent(size: sizes[0], sizeWithQuantity: sizeWithQuantity));
    });
    return WillPopScope(
      onWillPop: () async {
        context
            .read<ProductBloc>()
            .add(FetchProductsEvent(category: categories[0]));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
                indexChangeNotifier.value = 2;
              },
              icon: const Icon(Icons.favorite_border_rounded)),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
                indexChangeNotifier.value = 1;
              },
              icon: const Icon(Icons.shopping_bag_outlined))
        ]),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Responsive.height * 0.55,
                  width: Responsive.width * 1,
                  child: CarouselSlider(
                      items: product.image
                          .map((e) => Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(e))),
                              ))
                          .toList(),
                      options: CarouselOptions(
                        aspectRatio: 1 / 2.5,
                        viewportFraction: 1,
                        enlargeFactor: 0.15,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        autoPlayCurve: Curves.linear,
                      )),
                ),
                height10,
                Text(
                  product.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: colorGrey1),
                ),
                height10,
                Text(
                  '${AppStrings.rupee}${product.price}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22),
                ),
                height30,
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Select Size',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    BlocBuilder<ProductBloc, ProductState>(
                      builder: (context, state) {
                        return Text(
                          'Quantity : ${state is SelectedSizeState ? state.available : 0}',
                          style: const TextStyle(color: colorGrey5),
                        );
                      },
                    )
                  ],
                ),
                height20,
                SizedBox(
                  height: Responsive.height * 0.08,
                  width: double.infinity,
                  child: BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: sizes.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizeCircularWidget(
                                index: index,
                                product: product,
                              ),
                            );
                          });
                    },
                  ),
                ),
                height30,
                const Divider(),
                height10,
                const Text(
                  'Product Description',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                height20,
                Text(
                  product.description,
                  style: const TextStyle(fontSize: 18, color: colorGrey4),
                ),
                height10,
                const Divider(),
                height30,
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: MediaQuery.of(context).size.height * 0.065,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Center(
                          child: Text(
                        'Buy Now',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white),
                      )),
                    ),
                    SizedBox(
                      width: Responsive.width * 0.03,
                    ),
                    Expanded(
                      child: SlideAction(
                        height: MediaQuery.of(context).size.height * 0.065,
                        sliderButtonIconPadding: 6,
                        innerColor: Colors.white,
                        outerColor: Colors.black,
                        borderRadius: 12,
                        text: 'Swipe to Bag >>',
                        textStyle: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        sliderButtonIcon:
                            const Icon(Icons.shopping_bag_outlined),
                        sliderRotate: false,
                        onSubmit: () {
                          final cartModel = CartModel(
                              productId: product.id!,
                              name: product.title,
                              price: product.price.toString(),
                              quantity: 1.toString(),
                              description: product.description,
                              imageUrl: product.image,
                              stock: (product.small +
                                      product.large +
                                      product.medium +
                                      product.xl)
                                  .toString());
                          context
                              .read<CartBloc>()
                              .add(ProductAddToCart(cartModel: cartModel));
                          return null;
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SizeCircularWidget extends StatelessWidget {
  const SizeCircularWidget({
    super.key,
    required this.index,
    required this.product,
  });
  final int index;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            final sizeWithQuantity = {
              'S': product.small,
              'M': product.medium,
              'L': product.large,
              'XL': product.xl,
            };
            context.read<ProductBloc>().add(SelectSizeEvent(
                  size: sizes[index],
                  sizeWithQuantity: sizeWithQuantity,
                ));
          },
          child: Container(
            height: Responsive.height * 0.06,
            width: Responsive.width * 0.13,
            decoration: BoxDecoration(
                color: state is SelectedSizeState
                    ? state.selectedSize == sizes[index]
                        ? Colors.black
                        : ConstColor.greyColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(30)),
            child: Center(
                child: Text(
              sizes[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: state is SelectedSizeState
                    ? state.selectedSize == sizes[index]
                        ? Colors.white
                        : ConstColor.blackColor
                    : Colors.black,
              ),
            )),
          ),
        );
      },
    );
  }
}
