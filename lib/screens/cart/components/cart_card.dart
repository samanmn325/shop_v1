import '../../../net/brain.dart';
import '../../../net/data.dart';
import '../../../screens/product_detail/product_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/woocommerce.dart';

import '../../../constants.dart';

class CartCard extends StatefulWidget {
  CartCard({required this.cartItem, required this.index});
  final WooCartItem cartItem;
  final int index;

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  late String price;
  late int total;
  bool temp = false;
  late WooProduct product;
  int off = 0;
  late int quantity1 = widget.cartItem.quantity!;
  void setPrice() {
    /// this loop take product price property and give it to cartItem with same name.
    for (int i = 0; i < context.watch<Data>().cartItem.length; i++) {
      for (int j = 0; j < Brain.publicProductList.length; j++) {
        if (Brain.publicProductList[j].id ==
            context.watch<Data>().cartItem[i].id) {
          price = Brain.publicProductList[j].price!;
        }
      }
    }
  }

  goToProduct() async {
    for (WooProduct product2 in Brain.publicProductList) {
      if (product2.name == widget.cartItem.name) {
        setState(() {
          product = product2;
        });
      }
    }

    int salePrice1 = 0;
    if (double.parse(product.salePrice!) > 0) {
      salePrice1 = await int.parse(product.salePrice!);
      double result = (int.parse(product.regularPrice!) - salePrice1) /
          int.parse(product.regularPrice!) *
          100;
      setState(() {
        off = result.ceil();
      });
      // async with a global variable must be
    }
  }

  change(bool temp) {
    if (widget.cartItem.quantity! > 1) {
      if (temp) {
        context.read<Data>().setCartQuantity(widget.cartItem.id, true);
        context.read<Data>().calculateTotalPrice();
      } else {
        context.read<Data>().setCartQuantity(widget.cartItem.id, false);
        context.read<Data>().calculateTotalPrice();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    goToProduct();
  }

  @override
  Widget build(BuildContext context) {
    change(temp);
    setPrice();
    total = int.parse(widget.cartItem.price!) * widget.cartItem.quantity!;

    //todo : cartCard
    return Consumer<Data>(
      builder: (context, data, child) {
        return Card(
          child: GestureDetector(
            onTap: () {
              kShowToast(context, "برای حذف به سمت راست بکشید");
            },
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: Card(
                    color: kBaseColor0,
                    child: GestureDetector(
                      child: Image(
                        image: NetworkImage(widget.cartItem.images![0].src!,
                            scale: 1),
                      ),
                      onTap: () async {
                        Navigator.pushNamed(context, ProductDetail.routeName,
                            arguments: ProductArguments(product, off));
                      },
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.cartItem.name!,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        maxLines: 2,
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '  قیمت واحد:  ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: kPrimaryColor,
                                ),
                              ),
                              Text(
                                '     ${kCheckPrice(widget.cartItem.price)} تومان ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: " تعداد: ",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.green,
                                ),
                                splashColor: Colors.green,
                                onPressed: () {
                                  if (quantity1 >= 1) {
                                    setState(() {
                                      quantity1++;
                                      temp = true;
                                    });
                                  }
                                },
                              ),
                              Text(quantity1.toString()),
                              IconButton(
                                icon: Icon(
                                  Icons.remove,
                                  color: Colors.red,
                                ),
                                splashColor: Colors.red,
                                onPressed: () {
                                  if (quantity1 > 1) {
                                    setState(() {
                                      quantity1--;
                                      temp = false;
                                    });
                                  }
                                },
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
