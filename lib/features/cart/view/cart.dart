import 'package:bottom_bar_matu/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linen_republic/constants/app_strings/app_strings.dart';
import 'package:linen_republic/constants/constants.dart';
import 'package:linen_republic/features/cart/controller/bloc/bloc/cart_bloc.dart';
import 'package:linen_republic/features/cart/controller/cart_services/cart_services.dart';
import 'package:linen_republic/features/cart/model/cartmodel.dart';
import 'package:linen_republic/features/checkout/view/checkout.dart';
import 'package:linen_republic/utils/responsive/responsive.dart';
import 'package:slide_to_act/slide_to_act.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CartBloc>().add(CartProductsGetEvent());
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
                child: BlocConsumer<CartBloc, CartState>(
                  listener: (context, state) {
                    if (state is RemoveCartSuccess ||
                        state is AddToCartSuccess) {
                      context.read<CartBloc>().add(CartProductsGetEvent());
                    } else if (state is RemoveCartError) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.message)));
                    } else if (state is AddToCartError) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  builder: (context, state) {
                    if (state is FetchCartProductsSuccessState) {
                      if (state.cartItems.isEmpty) {
                        return Center(
                          child: Text(
                            "Your cart is waiting to be filled",
                            style: GoogleFonts.prata(fontSize: 18),
                          ),
                        );
                      }
                      return ListView.builder(
                          itemCount: state.cartItems.length,
                          itemBuilder: (context, index) {
                            final product = state.cartItems[index];
                            return CartTileWidget(cartModel: product);
                          });
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is FetchCartProductsSuccessState) {
                    if (state.cartItems.isEmpty) {
                      return const SizedBox();
                    }
                    final total = getPrice(state.cartItems);
                    final totalItems = getTotalItems(state.cartItems);
                    return Container(
                      height: Responsive.height * 0.11,
                      width: Responsive.width * 0.95,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'No of Items :',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                Text(
                                  totalItems.toString(),
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.white),
                                )
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total Amount :',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                                Text('${AppStrings.rupee} $total',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.white))
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              height10,
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is FetchCartProductsSuccessState &&
                      state.cartItems.isEmpty) {
                    return const SizedBox();
                  }
                  return SlideAction(
                    height: MediaQuery.of(context).size.height * 0.06,
                    sliderButtonIconPadding: 6,
                    sliderButtonYOffset: -2,
                    innerColor: Colors.white,
                    outerColor: Colors.black,
                    borderRadius: 12,
                    text: 'Swipe to Confirm Order >>',
                    textStyle: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    sliderButtonIcon: const Icon(Icons.payment_outlined),
                    sliderRotate: false,
                    onSubmit: () {
                      return Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CheckOutPage(),
                          ));
                    },
                  );
                },
              )
            ],
          ),
        ));
  }
}

class CartTileWidget extends StatefulWidget {
  const CartTileWidget({super.key, required this.cartModel});
  final CartModel cartModel;

  @override
  State<CartTileWidget> createState() => _CartTileWidgetState();
}

class _CartTileWidgetState extends State<CartTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: (context) {
              context.read<CartBloc>().add(ProductRemoveFromCart(
                    id: widget.cartModel.productId,
                  ));
            },
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
                topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
          ),
          child: Row(
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.03),
              Container(
                height: 60,
                width: 60,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Image(
                  image: NetworkImage(
                    widget.cartModel.imageUrl.first,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              width10,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  height10,
                  Text(
                    widget.cartModel.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: colorGrey3),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Text(
                      widget.cartModel.description,
                      maxLines: 1,
                      style: const TextStyle(color: colorGrey4),
                    ),
                  ),
                  Text(
                    "${AppStrings.rupee}${widget.cartModel.price.toString()}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: colorGrey2),
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
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              updateQuantity(
                                  CartModel(
                                      name: widget.cartModel.name,
                                      productId: widget.cartModel.productId,
                                      price: widget.cartModel.price,
                                      quantity: widget.cartModel.quantity,
                                      description: widget.cartModel.description,
                                      imageUrl: widget.cartModel.imageUrl,
                                      stock: widget.cartModel.stock),
                                  context,
                                  false);
                            },
                            child: const Icon(
                              Icons.remove,
                              size: 15,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            widget.cartModel.quantity,
                            style: const TextStyle(color: Colors.white),
                          ),
                          InkWell(
                            onTap: () {
                              updateQuantity(
                                CartModel(
                                    name: widget.cartModel.name,
                                    productId: widget.cartModel.productId,
                                    price: widget.cartModel.price,
                                    quantity: widget.cartModel.quantity,
                                    description: widget.cartModel.description,
                                    imageUrl: widget.cartModel.imageUrl,
                                    stock: widget.cartModel.stock),
                                context,
                                true,
                              );
                            },
                            child: const Icon(
                              Icons.add,
                              size: 15,
                              color: Colors.white,
                            ),
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
  }

  Future<void> updateQuantity(
      CartModel cartModel, BuildContext context, bool isAdd) async {
    int quantity = int.parse(cartModel.quantity);
    int stock = int.parse(cartModel.stock);
    if (isAdd && stock > quantity) {
      await CartServices().updateQuantity(cartModel, isAdd);
    } else if (!isAdd && quantity > 1) {
      await CartServices().updateQuantity(cartModel, false);
      setState(() {});
    } else if (!isAdd && quantity == 1) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text(
                'Are you sure you want to delete this item from your cart?'),
            actions: <Widget>[
              TextButton(
                child: const Text('Delete'),
                onPressed: () async {
                  context
                      .read<CartBloc>()
                      .add(ProductRemoveFromCart(id: cartModel.productId));
                  Navigator.of(context).pop();
                  setState(() {});
                },
              ),
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Stock limit exceed")));
    }
    // ignore: use_build_context_synchronously
    context.read<CartBloc>().add(CartProductsGetEvent());
  }
}

int getPrice(List<CartModel> cartItems) {
  int sum = 0;
  for (CartModel element in cartItems) {
    int price = int.parse(element.price);
    int quantity = int.parse(element.quantity);
    sum += price * quantity;
  }
  return sum;
}

int getTotalItems(List<CartModel> cartItems) {
  int item = 0;
  for (var element in cartItems) {
    int quantity = int.parse(element.quantity);
    item += quantity;
  }
  return item;
}
