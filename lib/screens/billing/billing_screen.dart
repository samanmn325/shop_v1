import '../../components/bottom_navigator_bar.dart';
import '../../enums.dart';
import '../../net/net_helper.dart';
import '../../screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce/woocommerce.dart';
import 'Components/billing_productCard.dart';

class BillingScreen extends StatefulWidget {
  static String routeName = "/billing";
  static List<WooOrder> allOrders = [];

  static int customerId = 0;
  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  List<WooOrder> orders = [];
  filterOrders() async {
    if (await NetworkHelper().wooCommerce.isCustomerLoggedIn()) {
      setState(() {
        orders = BillingScreen.allOrders
            .where((e) => e.customerId == BillingScreen.customerId)
            .toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    filterOrders();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, (e) => false);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            iconSize: 40.0,
            icon: Icon(Icons.arrow_left),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeScreen.routeName, (e) => false);
            },
          ),
          title: Text(
            'صورتحساب',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 1,
        ),
        bottomNavigationBar:
            CustomBottomNavBar(selectedMenu: MenuState.Billing),
        body: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (BuildContext context, int index) {
              // var item = orders[index]; //Your item
              return Container(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BillingProductCard(
                      order: orders[index],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
