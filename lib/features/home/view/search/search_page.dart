import 'dart:async';

import 'package:bottom_bar_matu/components/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linen_republic/features/home/controller/bloc/search_bloc.dart';
import 'package:linen_republic/features/home/widgets/product_view_widget.dart';
import 'package:linen_republic/features/product/view/product_details.dart';
import 'package:linen_republic/utils/responsive/responsive.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final String searchQuery = '';
  String? _selectedFilter;
  @override
  void initState() {
    super.initState();
    context.read<SearchBloc>().add(FilterByAll());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildSearchBar(),
      body: _buildProductViewWidget(context),
    );
  }

  Widget _buildProductViewWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is FilterErrorState) {
            return const Center(child: Text('Error'));
          } else if (state is FilterSuccessState) {
            final products = state.products;
            return Column(
              children: [
                _buildFilterDropdown(),
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 15,
                      childAspectRatio: 1 / 2.0,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                product: products[index],
                              ),
                            ),
                          );
                        },
                        child: ProductViewWidget(
                          product: products[index],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  PreferredSize _buildSearchBar() {
    final debouncer = Debouncer(delay: 500);
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: AppBar(
        title: Container(
          height: Responsive.height * 0.05,
          width: Responsive.width * 0.82,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: colorGrey6),
          child: CupertinoSearchTextField(
            onChanged: (value) {
              debouncer.run(() {
                context
                    .read<SearchBloc>()
                    .add(SearchProductEvent(query: value));
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFilterDropdown() {
    List<String> items = ['All', 'Low to High', 'High to Low', 'Under 999'];

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ChoiceChip(
              labelStyle: GoogleFonts.prata(
                color: _selectedFilter == items[index]
                    ? Colors.white
                    : Colors.black,
              ),
              label: Text(items[index]),
              selected: _selectedFilter == items[index],
              onSelected: (selected) {
                setState(() {
                  _selectedFilter = selected ? items[index] : null;
                });
                switch (_selectedFilter) {
                  case 'Under 999':
                    context.read<SearchBloc>().add(FilterByUnder999());
                    break;
                  case 'Low to High':
                    context.read<SearchBloc>().add(FilterByLowToHigh());
                    break;
                  case 'High to Low':
                    context.read<SearchBloc>().add(FilterByHighToLow());

                  default:
                    context.read<SearchBloc>().add(FilterByAll());
                }
              },
              selectedColor: Colors.black,
              backgroundColor: Colors.grey[200],
            ),
          );
        },
      ),
    );
  }
}

class Debouncer {
  final int delay;
  Timer? timer;
  Debouncer({required this.delay});

  void run(VoidCallback action) {
    timer?.cancel();
    timer = Timer(Duration(milliseconds: delay), action);
  }
}
