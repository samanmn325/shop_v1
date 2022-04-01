// ignore_for_file: import_of_legacy_library_into_null_safe
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shop_v1/screens/welcome/welcome_screen.dart';
import 'package:http/http.dart' as http;
import 'package:uni_links/uni_links.dart';
import 'package:woocommerce/models/cart_item.dart';
import 'package:woocommerce/models/order_payload.dart';

import '../../components/default_button.dart';
import '../../net/brain.dart';
import '../../net/data.dart';
import '../../net/net_helper.dart';
import '../../net/payment_result.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/login/login_popup.dart';
import '../../screens/profile/components/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zarinpal/zarinpal.dart';
import '../../constants.dart';
import '../../enums.dart';
import 'components/cart_card.dart';
import 'components/checkout_card.dart';

class CartScreen extends StatefulWidget {
  static String routeName = '/cart_screen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Widget buyButton = ElevatedButton(onPressed: () {}, child: null);
  bool isLoggedIn = false;
  int amount = 0;
  int totalPrice = 0;
  bool showSpinner = false;
  List<LineItems> lineItems = [];
  // ??????????????????????????????????????????????????????????????????????????????
  // ????????????????????????????????? start ???????????????????????????????????????

  StreamSubscription? _sub;
  Uri? _latestUri;
  Object? _err;
  PaymentRequest _paymentRequest = PaymentRequest();

  _payment(int amount) async {
    _paymentRequest.setIsSandBox(true);
    _paymentRequest.setMerchantID("71d28f8c-9bbe-4f4d-a7ab-4ac45e5654a5");
    _paymentRequest.setAmount(amount);
    _paymentRequest.setCallbackURL("sam17291729://zarinpalpayment");
    _paymentRequest.setDescription("توضیحات پرداخت");

    String? _paymentUrl;

    ZarinPal().startPayment(_paymentRequest,
        (int? status, String? paymentGatewayUri) async {
      if (status == 100) _paymentUrl = paymentGatewayUri;
      await _launchInBrowser(_paymentUrl!); // launch URL in browser
    });
  }

  /// Handle incoming links - the ones that the app will recieve from the OS
  /// while already started.
  void _handleIncomingLinks() {
    // It will handle app links while the app is already started - be it in
    // the foreground or in the background.
    _sub = uriLinkStream.listen((Uri? uri) {
      if (!mounted) return;
      print('got uri: $uri');
      setState(() {
        _latestUri = uri;
        _err = null;
      });
      final a = _latestUri!.queryParameters["Status"];
      print(a);
      final b = _latestUri?.queryParameters["Authority"];
      print(b);
      if (a != null && b != null) {}
      ZarinPal().verificationPayment(a!, b!, _paymentRequest,
          (isPaymentSuccess, refID, paymentRequest) async {
        if (isPaymentSuccess) {
          // Payment Is Success
          print("Success");
          List<WooCartItem> cartItem = context.watch<Data>().cartItem;
          for (int i = 0; i < cartItem.length; i++) {
            LineItems lineItem = LineItems(
                productId: cartItem[i].id,
                name: cartItem[i].name,
                quantity: cartItem[i].quantity);
            lineItems.add(lineItem);
          }
          // WooOrderPayloadBilling billing = Brain.billing as WooOrderPayloadBilling;
          WooOrderPayloadBilling billing = WooOrderPayloadBilling(
              firstName: Brain.billing.firstName,
              lastName: Brain.billing.lastName,
              email: Brain.billing.lastName,
              phone: Brain.billing.phone,
              state: Brain.billing.state,
              city: Brain.billing.city,
              address1: Brain.billing.address1);
          await NetworkHelper().wooCommerce.createOrder(WooOrderPayload(
              status: 'completed',
              customerId: Brain.customer.id,
              billing: billing,
              lineItems: lineItems));
          Navigator.pushNamed(context, PaymentResult.routeName,
              arguments: 'پرداخت موفق');
        } else {
          print("Error");
          Navigator.pushNamed(context, PaymentResult.routeName,
              arguments: 'پرداخت ناموفق');
        }
      });
    }, onError: (Object err) {
      if (!mounted) return;
      print('got err: $err');
      setState(() {
        _latestUri = null;
        if (err is FormatException) {
          _err = err;
        } else {
          _err = null;
        }
      });
    });
  }

// ??????????????????????????????? end ??????????????????????????????????????
// ??????????????????????????????????????????????????????????????????????????????

  ///_launchInBrowser is for launch url in external Browser(chrome & etc.).
  Future<void> _launchInBrowser(String url) async {
    if (await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
  }

  isLogin() async {
    isLoggedIn = await NetworkHelper().wooCommerce.isCustomerLoggedIn();
    setState(() {});
    getBuyButton();
  }

  /// BuyButton /////////////////////////////////////////////////
  getBuyButton() {
    if (isLoggedIn) {
      if (Brain.isCustomerInfoFull) {
        buyButton = DefaultButton(
          color: Colors.green,
          text: 'تکمیل خرید',
          press: () async {
            // kShowToast(context, "شروع.");
            // List<LineItems> lineItems = [];
            // List<WooCartItem> cartItem = context.watch<Data>().cartItem;
            // for (int i = 0; i < cartItem.length; i++) {
            //   LineItems lineItem = LineItems(
            //       productId: cartItem[i].id,
            //       name: cartItem[i].name,
            //       quantity: cartItem[i].quantity);
            //   lineItems.add(lineItem);
            // }
            // // WooOrderPayloadBilling billing = Brain.billing as WooOrderPayloadBilling;
            // WooOrderPayloadBilling billing = WooOrderPayloadBilling(
            //     firstName: Brain.billing.firstName,
            //     lastName: Brain.billing.lastName,
            //     email: Brain.billing.lastName,
            //     phone: Brain.billing.phone,
            //     state: Brain.billing.state,
            //     city: Brain.billing.city,
            //     address1: Brain.billing.address1);
            // await NetworkHelper().wooCommerce.createOrder(WooOrderPayload(
            //     status: 'completed',
            //     customerId: Brain.customer.id,
            //     billing: billing,
            //     lineItems: lineItems));
            // kShowToast(context, 'پایان.');
            _payment(totalPrice);
          },
        );
      } else {
        buyButton = DefaultButton(
          color: Colors.blueGrey,
          text: "تکمیل خرید",
          press: () async {
            kShowToast(context,
                "برای تکمیل خرید ابتدا باید اطلاعات پروفایل خود را کامل کنید.");
            Navigator.pushNamed(context, EditProfileScreen.routeName);
          },
        );
      }
    } else {
      buyButton = DefaultButton(
          text: "پرداخت",
          press: () async {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return LoginPopUp(
                    selectedScreen: Screen.cart,
                  );
                });
          });
    }
    setState(() {});
  }

  Future<bool?> _onBackPressed() async {
    Navigator.pushNamedAndRemoveUntil(
        context, HomeScreen.routeName, (_) => false);
    return true;
  }

  // /// calculateTotalPrice is for calculate [totalPrice] and change it form String to Integer
  // void calculateTotalPrice() {
  //   setState(() {
  //     totalPrice = 0;
  //   });
  //   for (int i = 0; i < context.watch<Data>().cartItem.length; i++) {
  //     for (int j = 0; j < Brain.publicProductList.length; j++) {
  //       if (Brain.publicProductList[j].name ==
  //               context.watch<Data>().cartItem[i].name ||
  //           Brain.publicProductList[j].id ==
  //               context.watch<Data>().cartItem[i].id) {
  //         context.read<Data>().setPrice(i, Brain.publicProductList[j].price);
  //         var temp = changePrice(context.watch<Data>().cartItem[i].price) *
  //             context.watch<Data>().cartItem[i].quantity;
  //         totalPrice += temp;
  //       }
  //     }
  //   }
  //   setState(() {
  //     totalPrice;
  //   });
  // }
  // int changePrice(String price) {
  //   int changedPrice = int.parse(price);
  //   return changedPrice;
  // }
  @override
  void initState() {
    super.initState();
    _handleIncomingLinks();
    isLogin();
  }

  @override
  void dispose() {
    _sub!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<Data>().calculateTotalPrice();
    setState(() {
      totalPrice = context.watch<Data>().totalPrice;
    });

    /// WillPopScope helps developer to control Android BackButton
    return Consumer<Data>(builder: (context, data, child) {
      return WillPopScope(
        onWillPop: () async {
          bool? result = await _onBackPressed();
          if (result == null) {
            result = false;
          }
          return result;
        },
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                iconSize: 40.0,
                icon: Icon(Icons.arrow_left),
                onPressed: () {
                  Navigator.pop(context);

                  ///
                  // Navigator.pushNamedAndRemoveUntil(
                  //     context, HomeScreen.routeName, (_) => false);
                },
              ),
              title: Center(
                child: Column(
                  children: [
                    Text(
                      "سبد خرید",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "${data.cartItem.length} محصول",
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: data.cartItem.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  // cartItem will remove by customer from here
                  child: Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        var temp =
                            data.changePrice(data.cartItem[index].price!) *
                                data.cartItem[index].quantity!;
                        data.totalPrice -= temp;
                        data.removeCartItem(data.cartItem[index]);
                      });
                    },
                    background: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFE6E6),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Column(
                      children: [
                        CartCard(cartItem: data.cartItem[index], index: index),
                        SizedBox(
                            width: 170,
                            child: ElevatedButton(
                              child: Text('خرید'),
                              onPressed: () {
                                _payment(1000);
                              },
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: CheckoutCard(
              getButton: buyButton,
            ),
          ),
        ),
      );
    });
  }
}
///////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
