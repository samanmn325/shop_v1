// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woocommerce/models/customer.dart';
import 'package:woocommerce/woocommerce.dart'
    show WooCart, WooCartItem, WooProduct, WooProductCategory;

import '../constants.dart';
import 'net_helper.dart';
import 'dart:io';

import '../components/try_again.dart';

const spinkit = SpinKitDancingSquare(
  color: Colors.white,
  size: 50.0,
);

/// The Brain Widget let developer to get data everywhere in app
class Brain extends StatefulWidget {
  Brain({required this.selectedRouteName});
  final String selectedRouteName;
  // static String routeName = '/brain';
  static List<WooCartItem> cartItem = [];
  static List<WooProduct> publicProductList = [];
  static List<WooProduct> allProductList = [];
  static List<WooProductCategory> productCategory = [];
  static WooCustomer customer = WooCustomer();
  static Billing billing = Billing();
  static Shipping shopping = Shipping();
  static WooCart? myCart;
  static bool isLoggedIn = false;
  static bool isCustomerInfoFull = false;
  //static List<WooProductDates> productDates = [];
  static List<WooProduct> fiteredProducts = [];
  static List<String> HPCategoryProduct = [];
  @override
  _BrainState createState() => _BrainState();
}

class _BrainState extends State<Brain> {
  bool showSpinner = false;
  bool isActive = false;
  bool isTrying = false;

  /// this following function check " Is user device connected to network or not?"
  checkConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        setState(() {
          isTrying = false;
        });
        // if (Brain.publicProductList.isEmpty) {
        //   await NetworkHelper().getProduct();
        // }
        // Brain.productDates = await getOfferProducts();
        // await getProductDates();
        // HPCategoryProduct();
        SharedPreferences pref = await SharedPreferences.getInstance();
        Brain.isLoggedIn =
            await NetworkHelper().wooCommerce.isCustomerLoggedIn();

        /// if isLoggedIn [true] get customer cartItem
        if (Brain.isLoggedIn) {
          if (Brain.customer.username == null) {
            // await NetworkHelper().getCart();
            if (await NetworkHelper().getCustomer() == false) {
              kShowToast(context,
                  "برای تکمیل خرید ابتدا باید اطلاعات پروفایل خود را کامل کنید.");
            }
          }
        }
        Navigator.pushNamed(context, widget.selectedRouteName);
      }
    } on SocketException catch (_) {
      print('not connected');
      kShowToast(context, " اتصال به اینترت ندارید  \n دوباره تلاش کنید");
      setState(() {
        isTrying = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: kBaseColor1,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/Background1.jpg'),
                  fit: BoxFit.fill),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                !isTrying
                    ? spinkit
                    : TryAgain(callBack: () {
                        checkConnection();
                      }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



HPCategoryProduct() {
  List<WooProduct> bannerProduct = Brain.allProductList
      .where((element) => element.name == "Appcategory")
      .toList();
  if (bannerProduct.isEmpty)
    Brain.HPCategoryProduct;
  else {
    for (int i = 0; i < bannerProduct[0].categories.length; i++) {
      Brain.HPCategoryProduct.add(bannerProduct[0].categories[i].name!);
    }
    ;
  }
}
