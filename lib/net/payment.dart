// ignore_for_file: unused_local_variable, unused_element

import '../../components/default_button.dart';
import '../../screens/login/login_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zarinpal/zarinpal.dart';
import '../constants.dart';
import '../enums.dart';
import 'brain.dart';
import 'net_helper.dart';

class Payment extends StatefulWidget {
  static String routeName = '/payment';
  Payment({required this.amount});
  final int amount;
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  Future<void> initUniLinks() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final initialLink = await getInitialLink();
      // Parse the link and warn the user, if it is not correct,
      // but keep in mind it could be `null`.
      // navigate to every page you want
    } on PlatformException {
      // Handle exception by warning the user their action did not succeed
      // return?
    }
  }

  /// _payment is for interact with online payment gateway.
  _payment(int amount) async {
    PaymentRequest _paymentRequest = PaymentRequest();

    _paymentRequest.setIsSandBox(true);
    _paymentRequest.setMerchantID("5f2bddbe-615e-11ea-a63b-000c295eb8fc");
    _paymentRequest.setAmount(amount);
    _paymentRequest.setCallbackURL("https://epicsite.ir/");
    _paymentRequest.setDescription("توضیحات پرداخت");

    String? _paymentUrl;

    ZarinPal().startPayment(_paymentRequest,
        (int? status, String? paymentGatewayUri) async {
      if (status == 100) _paymentUrl = paymentGatewayUri;
      await _launchInBrowser(_paymentUrl!); // launch URL in browser
    });

    ZarinPal()
        .verificationPayment("Status", "Authority Call back", _paymentRequest,
            (isPaymentSuccess, refID, paymentRequest) {
      if (isPaymentSuccess) {
        // Payment Is Success
        print("Success");
      } else {
        print("Error");
      }
    });
  }

  ///_launchInBrowser is for launch url in external Browser(chrome & etc.).
  Future<void> _launchInBrowser(String url) async {
    if (!await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
  }

  ///_launchInWebViewOrVC is for launch url in app.
  Future<void> _launchInWebViewOrVC(String url) async {
    if (!await launch(
      url,
      forceSafariVC: true,
      forceWebView: true,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
  }

  bool isLoggedIn = false;
  isLogin() async {
    isLoggedIn = await NetworkHelper().wooCommerce.isCustomerLoggedIn();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  @override
  Widget build(BuildContext context) {
    /// Check if a user is Logged In.
    if (isLoggedIn) {
      if (Brain.isCustomerInfoFull) {
        return DefaultButton(
          color: Colors.green,
          text: 'تکمیل خرید',
          press: () {
            _payment(widget.amount);
          },
        );
      } else {
        return DefaultButton(
          color: Colors.blueGrey,
          text: "تکمیل خرید",
          press: () async {
            kShowToast(context,
                "برای تکمیل خرید ابتدا باید اطلاعات پروفایل خود را کامل کنید.");
          },
        );
      }
    } else {
      return DefaultButton(
        text: "پرداخت",
        press: () async {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return LoginPopUp(
                  selectedScreen: Screen.cart,
                );
              });
        },
      );
    }
  }
}
