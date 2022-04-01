import '../../../net/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../constants.dart';

class CheckoutCard extends StatefulWidget {
  CheckoutCard({required this.getButton});
  final Widget getButton;
  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(
      builder: (context, data, child) {
        return Container(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 30,
          ),
          // height: 174,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -15),
                blurRadius: 20,
                color: const Color(0xFFDADADA).withOpacity(0.15),
              )
            ],
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*   Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset("assets/icons/receipt.svg"),
                  ),
                  Spacer(),
                  Text("وارد کردن کد تخفیف"),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: kTextColor,
                  )
                ],
              ),
             */
                /* SizedBox(height: 20),*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "مجموع:\n",
                        style: TextStyle(fontSize: 20),
                        children: [
                          TextSpan(
                            text:
                                "  ${kCheckPrice(data.totalPrice.toString())} تومان",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 170, child: widget.getButton),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
