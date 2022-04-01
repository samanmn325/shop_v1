import 'dart:io';
import '../../components/bottom_navigator_bar.dart';
import '../../net/brain.dart';
import '../drawer/drawer.dart';
import '../../net/net_helper.dart';
import '../../screens/billing/billing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:woocommerce/woocommerce.dart';
import '../../enums.dart';
import 'components/banner_slider.dart';
import 'components/category_box.dart';
import 'components/header.dart';
import 'components/offer_slider.dart';
import 'components/popular_product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = '/';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
//

class _HomeScreenState extends State<HomeScreen> {
  bool hasOffer = false;
  List<String> banner2() {
    List<String> banner1ImageList = [];
    List<WooProduct> bannerProduct = Brain.allProductList
        .where((element) => element.name == "banner2")
        .toList();
    if (bannerProduct.isEmpty)
      return banner1ImageList;
    else {
      for (int i = 0; i < bannerProduct[0].images.length; i++) {
        banner1ImageList.add(bannerProduct[0].images[i].src!);
      }
      return banner1ImageList;
    }
  }

  List<String> banner1() {
    List<String> banner1ImageList = [];
    List<WooProduct> bannerProduct = Brain.allProductList
        .where((element) => element.name == "banner1")
        .toList();
    if (bannerProduct.isEmpty)
      return banner1ImageList;
    else {
      for (int i = 0; i < bannerProduct[0].images.length; i++) {
        banner1ImageList.add(bannerProduct[0].images[i].src!);
      }
      return banner1ImageList;
    }
  }

  /// The onBackPressed is for Restrict Android backButton
  Future<bool?> onBackPressed() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'آیا میخواید از برنامه خارج شوید؟',
              style: TextStyle(fontFamily: "Iransans"),
            ),
            // content: const Text('برای خروج از برنامه دکمه بستن را بزنید.'),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: const Text(
                      'بله',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Iransans",
                          color: Colors.green),
                    ),
                    onPressed: () {
                      exit(0);
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    child: const Text(
                      'خیر',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Iransans",
                          color: Colors.red),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                ],
              ),
            ],
          );
        });
  }

  checkOffer() {
    for (WooProduct i in Brain.publicProductList) {
      if (i.dateOnSaleTo != null) {
        setState(() {
          hasOffer = true;
        });
        return;
      }
    }
  }

  @override
  void initState() {
    checkOffer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// The SystemChrome.setPreferredOrientations is for Lock up Rotation Screen .
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    //takes all orders list when home page is building

    getOrders();

    return WillPopScope(
      onWillPop: () async {
        bool? result = await onBackPressed();
        result ??= false;
        return result;
      },
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          flexibleSpace: Padding(
            padding: const EdgeInsets.fromLTRB(8, 30, 8, 8),
            child: Header(),
          ),
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            ///top header banner in very start
            bannerSlider(banner1()),
            CategoryBox(),
            //Brain.fiteredProducts.length > 0 ? OfferSlider() : Container(),
            if (hasOffer) OfferSlider(),
            const SizedBox(
              height: 5,
            ),
            Column(
              children: [
                ...List.generate(Brain.HPCategoryProduct.length, (index) {
                  if (index == 0) {
                    return Column(
                      children: [
                        PopularProducts(
                            catName: Brain.HPCategoryProduct[index]),
                        bannerSlider(banner2()),
                      ],
                    );
                  } else
                    return PopularProducts(
                        catName: Brain.HPCategoryProduct[index]);
                })
              ],
            ),

            //second banner in middle of the app
            // bannerSlider(banner2()),
            /* PopularProducts(
              catName: Brain.HPCategoryProduct[1],
            ),
            Divider(),
            PopularProducts(
              catName: Brain.HPCategoryProduct[2],
            ),
            Divider(),*/
          ]),
        ),
        bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
        // bottomNavigationBar: BottomNavigator(),
      ),
    );
  }
}

getOrders() async {
  NetworkHelper().getCustomer();
  bool isLoggedIn = await NetworkHelper().wooCommerce.isCustomerLoggedIn();
  if (isLoggedIn) {
    BillingScreen.allOrders = await NetworkHelper().wooCommerce.getOrders();
    BillingScreen.customerId =
        (await NetworkHelper().wooCommerce.fetchLoggedInUserId())!;
  }
}
