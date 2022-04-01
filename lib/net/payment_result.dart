import 'package:flutter/material.dart';
import 'package:shop_v1/constants.dart';
import 'package:shop_v1/screens/home/home_screen.dart';

import '../components/default_button.dart';
import 'brain.dart';

class PaymentResult extends StatefulWidget {
  const PaymentResult({Key? key}) : super(key: key);
  static String routeName = '/payment_result';

  @override
  State<PaymentResult> createState() => _PaymentResultState();
}

class _PaymentResultState extends State<PaymentResult> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: Container(
          color: kBaseColor0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text(args)),
              DefaultButton(
                text: "بازگشت به خانه",
                color: Colors.green,
                press: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Brain(selectedRouteName: HomeScreen.routeName)));
                },
              ),
              if (args == 'پرداخت موفق')
                DefaultButton(
                  text: "گزارش سفارشات",
                  color: Colors.green,
                  press: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Brain(
                                selectedRouteName: HomeScreen.routeName)));
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
