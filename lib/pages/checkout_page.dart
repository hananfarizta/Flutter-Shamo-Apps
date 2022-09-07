import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/pages/widgets/checkout_card.dart';
import 'package:shamo/pages/widgets/loading_button.dart';
import 'package:shamo/providers/auth_provider.dart';
import 'package:shamo/providers/cart_provider.dart';
import 'package:shamo/providers/transaction_provider.dart';
import 'package:shamo/theme.dart';

class CheckoutPage extends StatefulWidget {
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleCheckout() async {
      setState(() {
        isLoading = true;
      });
      if (await transactionProvider.checkout(authProvider.user.token,
          cartProvider.carts, cartProvider.totalPrice())) {
        cartProvider.carts = [];
        Navigator.pushNamedAndRemoveUntil(
            context, '/checkout-success', (route) => false);
      }
      setState(() {
        isLoading = false;
      });
    }

    header() {
      return AppBar(
        backgroundColor: bgColor1,
        elevation: 0,
        centerTitle: true,
        title: const Text('Checkout Details'),
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          // NOTE : LIST ITEMS
          Container(
            margin: EdgeInsets.only(top: defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'List Items',
                  style: primaryTextStyle.copyWith(
                      fontSize: 16, fontWeight: medium),
                ),
                Column(
                    children: cartProvider.carts
                        .map((cart) => CheckoutCard(cart))
                        .toList())
              ],
            ),
          ),

          // NOTE : ADDRESS DETAIL
          Container(
            margin: EdgeInsets.only(top: defaultMargin),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: bgColor4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Address Details',
                  style: primaryTextStyle.copyWith(
                      fontSize: 16, fontWeight: medium),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          'assets/icon_store_location.png',
                          width: 40,
                        ),
                        Image.asset(
                          'assets/icon_line.png',
                          height: 30,
                        ),
                        Image.asset(
                          'assets/icon_your_address.png',
                          width: 40,
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Store Location',
                          style: secondaryTextStyle.copyWith(
                              fontSize: 12, fontWeight: light),
                        ),
                        Text(
                          'Adidas Core',
                          style: primaryTextStyle.copyWith(fontWeight: medium),
                        ),
                        SizedBox(
                          height: defaultMargin,
                        ),
                        Text(
                          'Your Address',
                          style: secondaryTextStyle.copyWith(
                              fontSize: 12, fontWeight: light),
                        ),
                        Text(
                          'Marsemoon',
                          style: primaryTextStyle.copyWith(fontWeight: medium),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          //NOTE : PAYMENT SUMMARY
          Container(
            margin: EdgeInsets.only(top: defaultMargin),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: bgColor4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Summary',
                  style: primaryTextStyle.copyWith(
                      fontSize: 16, fontWeight: medium),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Product Quantity',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '${cartProvider.totalItems()} Items',
                      style: primaryTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Product Price',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '\$${cartProvider.totalPrice()}',
                      style: primaryTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Shipping',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Free',
                      style: primaryTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                const Divider(
                  thickness: 1,
                  color: Color(0xff2E3141),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: priceTextStyle.copyWith(fontWeight: semibold),
                    ),
                    Text(
                      '\$${cartProvider.totalPrice()}',
                      style: priceTextStyle.copyWith(fontWeight: semibold),
                    )
                  ],
                )
              ],
            ),
          ),
          //NOTE : CHECKOUT BUTTON
          SizedBox(
            height: defaultMargin,
          ),
          const Divider(
            thickness: 1,
            color: Color(0xff2E3141),
          ),
          isLoading
              ? Container(
                  margin: EdgeInsets.only(bottom: defaultMargin),
                  child: LoadingButton())
              : Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: defaultMargin),
                  child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      onPressed: handleCheckout,
                      child: Text(
                        'Checkout Now',
                        style: primaryTextStyle.copyWith(
                            fontWeight: semibold, fontSize: 16),
                      )),
                )
        ],
      );
    }

    return Scaffold(
      backgroundColor: bgColor3,
      appBar: header(),
      body: content(),
    );
  }
}
