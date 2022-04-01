import '../../components/default_button.dart';
import '../../screens/cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce/models/cart_item.dart';
import 'package:woocommerce/woocommerce.dart';

import 'brain.dart';

class ProductNum extends StatefulWidget {
  ProductNum({Key? key, required this.product, required this.temp});

  final WooProduct product;
  final bool temp;
  @override
  _ProductNumState createState() => _ProductNumState();
}

class _ProductNumState extends State<ProductNum> {
  List<WooCartItemImages> cartImages = [];
  int quantity = 1;
  var i = 0;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 220.0,
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned(
              right: -40.0,
              top: -40.0,
              child: InkResponse(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    child: Icon(Icons.close),
                    backgroundColor: Colors.red,
                  )),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('تعداد را وارد کنید :'),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          if (quantity >= 1) {
                            quantity++;
                            setState(() {});
                          }
                        },
                        child: Icon(Icons.add),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      Text(quantity.toString()),
                      FloatingActionButton(
                        onPressed: () {
                          if (quantity > 1) {
                            quantity--;
                            setState(() {});
                          }
                        },
                        child: Icon(Icons.remove),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DefaultButton(
                    text: 'ثبت',
                    press: () {
                      var img =
                          WooCartItemImages(src: widget.product.images[0].src);
                      cartImages.add(img);
                      var price = 0;
                      price += int.parse(widget.product.price!) * quantity;
                      Brain.cartItem.add(WooCartItem(
                        id: i,
                        images: cartImages,
                        quantity: quantity,
                        name: widget.product.name,
                        price: price.toString(),
                      ));
                      i++;
                      setState(() {});
                      if (widget.temp) {
                        Navigator.pushNamed(context, CartScreen.routeName,
                            arguments: Brain.cartItem);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
