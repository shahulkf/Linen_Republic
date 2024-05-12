import 'package:bottom_bar_matu/components/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linen_republic/constants/constants.dart';
import 'package:linen_republic/features/home/view/search/search_page.dart';
import 'package:linen_republic/features/home/widgets/banner_widget.dart';
import 'package:linen_republic/features/home/widgets/bottom_nav.dart';
import 'package:linen_republic/features/home/widgets/product_view_widget.dart';
import 'package:linen_republic/features/product/controller/bloc/product/product_bloc.dart';
import 'package:linen_republic/features/product/view/product_details.dart';
import 'package:linen_republic/utils/responsive/responsive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    context
        .read<ProductBloc>()
        .add(FetchProductsEvent(category: categories[0]));
    return Scaffold(
        appBar: AppBar(
            leading: const Padding(
              padding: EdgeInsets.all(8.0),
            ),
            actions: [
              const SizedBox(
                width: 10,
              ),
              _buildSearchWidget(context),
              const Spacer(),
              _buildWishlistButton(),
              width5
            ]),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBannerWidget(),
              height20,
              _buildCategoryTitle(),
              height10,
              _buildCategories(categories, selectedIndex, (value) {
                selectedIndex = value;
                setState(() {});
              }),
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

  // SizedBox _buildCategories() {
  SizedBox _buildCategories(List<String> categories, int selectedIndex,
      ValueChanged<int> onSelected) {
    final debounce = Debouncer(delay: 1);
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(categories.length, (index) {
          return ChoiceChip(
            checkmarkColor:
                index == selectedIndex ? Colors.white : Colors.black,
            label: Text(
              categories[index],
              style: GoogleFonts.prata(
                color: index == selectedIndex ? Colors.white : Colors.black,
              ),
            ),
            selected: selectedIndex == index,
            selectedColor: index == selectedIndex ? Colors.black : null,
            onSelected: (selected) {
              onSelected(index);
              debounce.run(() {
                context
                    .read<ProductBloc>()
                    .add(FetchProductsEvent(category: categories[index]));
              });
            },
          );
        }),
      ),
    );
  }

  BannerWidget _buildBannerWidget() => BannerWidget(banners: banners);

  IconButton _buildWishlistButton() {
    return IconButton(
        onPressed: () {
          indexChangeNotifier.value = 2;
        },
        icon: const Icon(
          Icons.favorite_border,
          size: 30,
        ));
  }

  Widget _buildSearchWidget(context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => const SearchScreen(),
          ),
        );
      },
      child: Container(
        height: Responsive.height * 0.05,
        width: Responsive.width * 0.82,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: colorGrey6),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Search your Product . . ',
                style: TextStyle(color: colorGrey5),
              ),
              Icon(
                CupertinoIcons.search,
                color: colorGrey5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
