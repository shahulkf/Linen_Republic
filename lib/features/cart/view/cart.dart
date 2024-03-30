import 'package:bottom_bar_matu/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linen_republic/constants/app_strings/app_strings.dart';
import 'package:linen_republic/constants/constants.dart';
import 'package:linen_republic/utils/responsive/responsive.dart';
import 'package:slide_to_act/slide_to_act.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          'My Cart',
          style: GoogleFonts.prata(),
        )),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              height10,
              Expanded(
                child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Slidable(
                          endActionPane: ActionPane(
                              motion: const StretchMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {},
                                  backgroundColor: Colors.black,
                                  icon: Icons.favorite_outline_rounded,
                                  // label: 'Add to Wishlist',
                                ),
                                SlidableAction(
                                  onPressed: (context) {},
                                  backgroundColor: Colors.black,
                                  icon: Icons.delete,
                                  // label: 'Remove',
                                )
                              ]),
                          child: Container(
                            height: Responsive.height * 0.12,
                            // width: double.infinity,
                            decoration: const BoxDecoration(
                              color: colorGrey7,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20)),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.03),
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Image(
                                    image: NetworkImage(
                                      'https://i.pinimg.com/564x/02/b9/f9/02b9f910004994aaf2199043ea4a0845.jpg',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                width10,
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    height10,
                                    Text(
                                      'Linen Shirt',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: colorGrey3),
                                    ),
                                    Text(
                                      'Mens Slim Fit Shirt',
                                      style: TextStyle(color: colorGrey4),
                                    ),
                                    Text(
                                      "${AppStrings.rupee}500",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: colorGrey2),
                                    )
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        height: Responsive.height * 0.04,
                                        width: Responsive.width * 0.20,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.black,
                                        ),
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.remove,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              '1',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Icon(
                                              Icons.add,
                                              size: 15,
                                              color: Colors.white,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const Spacer(),
                                Container(
                                  height: 94,
                                  width: 20,
                                  decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomLeft: Radius.circular(20))),
                                  child: const Icon(
                                    Icons.arrow_left_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Container(
                height: Responsive.height * 0.11,
                width: Responsive.width * 0.95,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'No of Items :',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          Text(
                            '4',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Amount :',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                          Text('${AppStrings.rupee} 2000',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              height10,
              SlideAction(
                height: MediaQuery.of(context).size.height * 0.06,
                sliderButtonIconPadding: 6,
                sliderButtonYOffset: -2,
                innerColor: Colors.white,
                outerColor: Colors.black,
                borderRadius: 12,
                text: 'Swipe to Payment >>',
                textStyle: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                sliderButtonIcon: const Icon(Icons.payment_outlined),
                sliderRotate: false,
                onSubmit: () {
                  return null;
                },
              )
            ],
          ),
        ));
  }
}
