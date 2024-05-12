import 'package:bottom_bar_matu/components/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linen_republic/constants/app_strings/app_strings.dart';
import 'package:linen_republic/constants/constants.dart';
import 'package:linen_republic/features/account/controller/bloc/orders/orders_bloc.dart';
import 'package:linen_republic/features/account/model/address/address_model.dart';
import 'package:linen_republic/features/account/model/order/order_model.dart';
import 'package:linen_republic/features/account/orders/orders.dart';
import 'package:linen_republic/features/account/view/address/view_address.dart';
import 'package:linen_republic/features/account/view/address/widgets/single_address.dart';
import 'package:linen_republic/features/cart/controller/bloc/bloc/cart_bloc.dart';

import 'package:linen_republic/features/cart/view/cart.dart';
import 'package:linen_republic/features/checkout/controller/bloc/checkout_bloc.dart';
import 'package:linen_republic/features/checkout/widget/carted_item_tile.dart';
import 'package:linen_republic/features/home/widgets/bottom_nav.dart';
import 'package:linen_republic/private.dart';
import 'package:linen_republic/utils/responsive/responsive.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:slide_to_act/slide_to_act.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  num payAmount = 0;
  bool isCOD = true;

  AddressModel? addressModel;

  final deliveryImage =
      'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fstatic.vecteezy.com%2Fsystem%2Fresources%2Fpreviews%2F002%2F423%2F042%2Foriginal%2Ffree-shipping-delivery-service-logo-badge-vector.jpg&f=1&nofb=1&ipt=862bfa3c8b4f256229f5b9ee969562a80315773dfbc50d07bc88b28b384b3618&ipo=images';

  final razoPayImage =
      'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fvectorseek.com%2Fwp-content%2Fuploads%2F2023%2F05%2FRazorpay-Logo-Vector-730x730.jpg&f=1&nofb=1&ipt=24d12702d0bfcfdd459f92f2379e2d2cd57625181d34131f36a6470fc14f5d21&ipo=images';

  late Razorpay _razorpay;
  void openCheckOut() async {
    // amount = amount * 100;
    var options = {
      'key': PrivateContent.secretKey,
      'amount': payAmount * 100,
      'name': 'Linen Republic',
      'prefil': {'contact': '0987654321', 'email': 'linenrepublic@gmail.com'},
      'extrnal': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('error : e');
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: 'Payment Success${response.paymentId!}',
        toastLength: Toast.LENGTH_SHORT);
    final OrderModel orderModel = OrderModel(
        paymentMethod: 'Online payment',
        orderedAddress: addressModel!,
        orderId: DateTime.now().microsecondsSinceEpoch.toString(),
        userId: FirebaseAuth.instance.currentUser!.uid,
        orderedItemIds: [],
        totalPrice: payAmount.toDouble(),
        status: 'Order Placed',
        timestamp: {
          'Order Placed': DateTime.now(),
          'Order Shipped': '',
          'Out For Delivery': '',
        });
    context.read<OrdersBloc>().add(OrderPlacedEvent(orderModel: orderModel));
    context.read<CartBloc>().add(ClearCartEvent());
    Navigator.pop(context);
    indexChangeNotifier.value = 0;
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: 'Payment Failed${response.message!}',
        toastLength: Toast.LENGTH_SHORT);
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: 'External Wallet${response.walletName!}',
        toastLength: Toast.LENGTH_SHORT);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  void initState() {
    super.initState();
    context.read<CheckoutBloc>().add(CheckoutEvent());

    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  List<String> orderedItms = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Confirm Order',
        style: GoogleFonts.prata(),
      )),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                // height: Responsive.height * 0.14,
                width: Responsive.width * 1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colorGrey7,
                    border: Border.all(color: colorGrey1)),
                child: BlocBuilder<CheckoutBloc, CheckoutState>(
                  builder: (context, state) {
                    if (state is CheckOutSuccess) {
                      if (state.cartedItems.isEmpty) {
                        return const Center(
                          child: Text("Your cart is waiting to be filled"),
                        );
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.cartedItems.length,
                          itemBuilder: (context, index) {
                            final product = state.cartedItems[index];
                            // return CartTileWidget(cartModel: product);
                            return CartedItemtile(cartModel: product);
                          });
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              height20,
              Container(
                // height: Responsive.height * 0.69,
                width: Responsive.width * 1,
                decoration: BoxDecoration(
                    color: colorGrey7,
                    border: Border.all(color: colorGrey3),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BlocBuilder<CheckoutBloc, CheckoutState>(
                    builder: (context, state) {
                      if (state is CheckOutSuccess) {
                        getOrderedItemIds(state);
                        final total = getPrice(state.cartedItems);
                        final totalItems = getTotalItems(state.cartedItems);
                        addressModel = state.deliveryAddress;
                        payAmount = total;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            height10,
                            PriceShowWidget(
                                label: 'Total Items', Price: '$totalItems'),
                            height10,
                            // const PriceShowWidget(
                            //     label: 'Delivery Charge', Price: '0'),
                            // height10,
                            PriceShowWidget(
                                label: 'Total Price',
                                Price: '${AppStrings.rupee}$total'),
                            height10,
                            const Divider(),
                            height10,
                            Text(
                              'Payment Method',
                              style: GoogleFonts.prata(
                                  fontWeight: FontWeight.bold),
                            ),
                            height10,
                            PaymentMethodWIdget(
                              image: razoPayImage,
                              selected: !isCOD,
                              onTap: () {
                                setState(() {
                                  isCOD = !isCOD;
                                });
                              },
                              paymentLabel: 'Online Payment',
                            ),
                            height10,
                            PaymentMethodWIdget(
                                onTap: () {
                                  setState(() {
                                    isCOD = !isCOD;
                                  });
                                },
                                selected: isCOD,
                                paymentLabel: 'Cash On Delivery',
                                image: deliveryImage),
                            height10,
                            const Divider(),
                            height10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Delivery Address',
                                  style: GoogleFonts.prata(
                                      fontWeight: FontWeight.bold),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ViewAddressPage(
                                                    key: UniqueKey()),
                                          ));
                                    },
                                    child: const Text(
                                      'Change',
                                    ))
                              ],
                            ),
                            SingleAddressWidget(
                                buttonshow: false,
                                addresses: state.deliveryAddress!,
                                selectedAddress: true,
                                onTap: () {}),
                          ],
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
              ),
              height10,
              height20,
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        width: 400,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SlideAction(
              height: MediaQuery.of(context).size.height * 0.06,
              sliderButtonIconPadding: 6,
              sliderButtonYOffset: -2,
              innerColor: Colors.white,
              outerColor: Colors.black,
              borderRadius: 12,
              text: isCOD ? 'Pay On Delivery' : 'Make Payment >>',
              textStyle: GoogleFonts.prata(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              sliderButtonIcon: const Icon(Icons.payment_outlined),
              sliderRotate: false,
              onSubmit: () {
                setState(() {
                  !isCOD
                      ? openCheckOut()
                      : showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              'Your order has been placed',
                              style: GoogleFonts.prata(),
                            ),
                            content: Text(
                              'You can check it on Orders',
                              style: GoogleFonts.prata(),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const OrdersPage(),
                                        ));
                                  },
                                  child: const Text('View Orders')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    indexChangeNotifier.value = 0;
                                  },
                                  child: const Text('Continue Shopping'))
                            ],
                          ),
                        );
                  if (isCOD) {
                    final OrderModel orderModel = OrderModel(
                        orderId:
                            DateTime.now().microsecondsSinceEpoch.toString(),
                        userId: FirebaseAuth.instance.currentUser!.uid,
                        orderedItemIds: orderedItms,
                        totalPrice: payAmount.toDouble(),
                        status: 'Order Placed',
                        paymentMethod: 'Cash on delivery',
                        timestamp: {
                          'Order Placed': DateTime.now().toString(),
                          'Order Shipped': '',
                          'Out For Delivery': '',
                        },
                        orderedAddress: addressModel!);
                    context
                        .read<OrdersBloc>()
                        .add(OrderPlacedEvent(orderModel: orderModel));
                    context.read<CartBloc>().add(ClearCartEvent());
                  }
                });
                return null;
              }),
        ),
      ),
    );
  }

  void getOrderedItemIds(CheckOutSuccess state) {
    orderedItms = state.cartedItems.map((e) => e.productId).toList();
  }
}

class PaymentMethodWIdget extends StatelessWidget {
  const PaymentMethodWIdget({
    required this.paymentLabel,
    required this.image,
    super.key,
    required this.selected,
    required this.onTap,
  });
  final String image;
  final String paymentLabel;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: Responsive.height * 0.05,
          width: Responsive.width * 0.10,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(image: NetworkImage(image))),
        ),
        width20,
        Text(
          paymentLabel,
          style: GoogleFonts.prata(),
        ),
        const Spacer(),
        InkWell(
          onTap: onTap,
          child: Icon(
            selected
                ? Icons.check_circle_outline_rounded
                : Icons.circle_outlined,
          ),
        )
      ],
    );
  }
}

class PriceShowWidget extends StatelessWidget {
  const PriceShowWidget({
    required this.label,
    required this.Price,
    super.key,
  });
  final String label;
  final String Price;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.prata(fontWeight: FontWeight.w500),
        ),
        Text(
          Price,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        )
      ],
    );
  }
}
