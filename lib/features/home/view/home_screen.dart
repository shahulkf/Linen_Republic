import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linen_republic/constants/colors/colors.dart';
import 'package:linen_republic/constants/constants.dart';
import 'package:linen_republic/features/home/widgets/banner_widget.dart';
import 'package:linen_republic/features/home/widgets/product_view_widget.dart';
import 'package:linen_republic/features/product/controller/bloc/product/product_bloc.dart';
import 'package:linen_republic/features/product/view/product_details.dart';
import 'package:linen_republic/utils/responsive/responsive.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProductBloc>().add(FetchProductsEvent());
    return Scaffold(
        appBar: AppBar(
            leading: const Padding(
              padding: EdgeInsets.all(8.0),
            ),
            actions: [
              const SizedBox(
                width: 10,
              ),
              _buildSearchWidget(),
              const Spacer(),
              _buildWishlistButton()
            ]),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBannerWidget(),
              height20,
              _buildCategoryTitle(),
              height10,
              _buildCategories(),
              height30,
              _buildProductViewWidget()
            ],
          ),
        ));
  }

  Padding _buildCategoryTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Categories',
        style: GoogleFonts.prata(fontSize: 25),
      ),
    );
  }

  Widget _buildProductViewWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductFetchLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductFetchErrorState) {
            return Center(child: Text(state.message));
          } else if (state is ProductFetchSuccessState) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 15,
                  childAspectRatio: 1 / 2.0,
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(
                                product: state.products[index]),
                          ));
                    },
                    child: ProductViewWidget(
                      product: state.products[index],
                    ));
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  SizedBox _buildCategories() {
    return SizedBox(
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
                  color:
                      index == 1 ? ConstColor.blackColor : ConstColor.greyColor,
                  borderRadius: BorderRadius.circular(25)),
              child: Center(
                  child: Text(
                categories[index],
                style: TextStyle(
                  color: index == 1 ? Colors.white : ConstColor.blackColor,
                ),
              )),
            ),
          );
        },
      ),
    );
  }

  BannerWidget _buildBannerWidget() => BannerWidget(banners: banners);

  IconButton _buildWishlistButton() {
    return IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.favorite_border,
          size: 30,
        ));
  }

  Container _buildSearchWidget() {
    return Container(
      height: Responsive.height * 0.05,
      width: Responsive.width * 0.7,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Colors.grey.shade400),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
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
    );
  }
}
