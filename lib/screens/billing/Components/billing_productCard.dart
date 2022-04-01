import '../../../screens/product_detail/product_details.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce/woocommerce.dart';
import '../../../constants.dart';
import 'package:intl/intl.dart';
import 'package:shamsi_date/shamsi_date.dart';

// ignore: must_be_immutable
class BillingProductCard extends StatefulWidget {
  BillingProductCard(
      {Key? key,
      this.width = 140,
      this.aspectRetio = 1.02,
      required this.order})
      : super(key: key);
  WooOrder order;
  final double width, aspectRetio;

  @override
  State<BillingProductCard> createState() => _BillingProductCardState();
}

class _BillingProductCardState extends State<BillingProductCard> {
  late WooProduct product;

  get kPrimaryColor => null;

  @override
  Widget build(BuildContext context) {
    getOrderCount() {
      int OrderCount = 0;
      for (int i = 0; i < widget.order.lineItems!.length; i++) {
        OrderCount = OrderCount + widget.order.lineItems![i].quantity!;
      }
      return OrderCount;
    }

    int productCount = widget.order.lineItems!.length;

    DateTime orderCreated = DateTime.parse(widget.order.dateCreated!);

    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String orderCreatedDate = formatter.format(orderCreated);
    DateTime orderDater = DateTime.parse(orderCreatedDate);
    Jalali orderCreatedShamsi = Jalali.fromDateTime(orderDater);

    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ProductDetail.routeName,
              arguments: product);
        },
        child: Container(
          padding: EdgeInsets.all(5),
          height: 117,
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //سفارش
                  Row(
                    children: [
                      Text(
                        "کد سفارش",
                        style: TextStyle(
                            color: Colors.black54,
                            fontFamily: "Iransans",
                            fontSize: 14),
                      ),
                      Text(
                        "${widget.order.id}",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Iransans",
                            fontSize: 14),
                      )
                    ],
                  ),
                  Text(
                    "${kCheckPrice(widget.order.total)} ریال",
                    style: TextStyle(fontSize: 17, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "${orderCreatedShamsi.year}/${orderCreatedShamsi.month}/${orderCreatedShamsi.day}",
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
              Row(
                children: [
                  //تعداد محصول
                  Row(
                    children: [
                      Text(
                        "تعداد محصول:  ",
                        style: TextStyle(
                            color: Colors.black54,
                            fontFamily: "Iransans",
                            fontSize: 14),
                      ),
                      Text(
                        "${productCount} عدد",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Iransans",
                            fontSize: 14),
                      )
                    ],
                  ),
                ],
              ),
              //کل سفارش
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "کل سفارش :  ",
                        style: TextStyle(
                            color: Colors.black54,
                            fontFamily: "Iransans",
                            fontSize: 14),
                      ),
                      Text(
                        "${getOrderCount()} عدد",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Iransans",
                            fontSize: 14),
                      )
                    ],
                  ),
                  Container(
                      // margin: EdgeInsets.only(bottom: 30),
                      width: 60,
                      height: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: isPaid() ? Colors.lightGreen : Colors.redAccent,
                      ),
                      child: Center(
                        child: Text(
                          "${StatusTranslator(widget.order.status!)}",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ))
                ],
              )
            ],
          ),
        ));
  }

  isPaid() {
    if (widget.order.status == "completed")
      return true;
    else
      return false;
  }

  StatusTranslator(String status) {
    if (status == "completed")
      return "تکمیل شده";
    else
      return "لغو شده";
  }
}
/*





 Row(
        children: [
          Container(
            height:120,
            width: 150,
          /* decoration:BoxDecoration(
             image: DecorationImage(
              image: NetworkImage(product.images[0].src),
              fit: BoxFit.contain,
          )
           ),*/
           /* child: Image(
              image: NetworkImage(product.images[0].src),
            ),*/
          ),
          const SizedBox(height: 10),
          Spacer(),
          Column(
            children: [
              /*Text(
                product.name,
                style: TextStyle(color: Colors.black),
                maxLines: 2,
              ),*/
              SizedBox(
                height: 5,
              ),
            /*  Padding(
                padding: const EdgeInsets.only(left: 13.0),
                child: Text(
                  " تومان ${kCheckPrice(product.price)}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: kPrimaryColor,
                  ),
                ),
              ),*/
            ],
          ),
        ],
      ),
   






 */
