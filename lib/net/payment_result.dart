import 'package:flutter/material.dart';

class PaymentResult extends StatefulWidget {
  const PaymentResult({ Key? key }) : super(key: key);
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
      body: Center(child: Text(args)),
    );
  }
}