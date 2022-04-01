import '../../screens/product_detail/product_details.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce/models/products.dart';
import '../constants.dart';

class ProductCard extends StatefulWidget {
  ProductCard({
    required this.product,
  });
  final WooProduct product;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int off = 0;
  offPercent() async {
    int salePrice1 = 0;
    if (double.parse(widget.product.salePrice!) > 0) {
      salePrice1 = await int.parse(widget.product.salePrice!);

      double result = (int.parse(widget.product.regularPrice!) - salePrice1) /
          int.parse(widget.product.regularPrice!) *
          100;

      setState(() {
        off = result.ceil();
      });
      // async with a global variable must be
    }
  }

  @override
  void initState() {
    super.initState();
    //EndTime();
    offPercent();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        margin: EdgeInsets.only(left: 10),
        height: MediaQuery.of(context).size.height * 0.34,
        width: 165,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: GestureDetector(
          onTap: () {
            //print("############################################$endTime");
            Navigator.pushNamed(
              context,
              ProductDetail.routeName,
              arguments: ProductArguments(widget.product, off),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AspectRatio(
                  aspectRatio: 1.2,
                  child: Hero(
                    tag: widget.product.id.toString(),
                    child: displayMedia(),
                  ),
                ),
                Divider(
                  height: 1,
                ),
                //PRODUCT IMAGE
                Text(
                  widget.product.name != '' ? widget.product.name! : 'بدون نام',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                  ),
                  maxLines: 2,
                ),
                //PRODUCT TITLE
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    (off == 0)
                        ? SizedBox(
                            height: 20,
                          )
                        : regularBox(),
                    SizedBox(
                      width: 5,
                    ),
                    percentBox(off)
                  ],
                ),
                //PRODUCT PRICE
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    (off == 0)
                        ? " ${kCheckPrice(widget.product.regularPrice)}ریال"
                        : " ${kCheckPrice(widget.product.salePrice)}ریال",
                    style: TextStyle(
                        color: Colors.black.withOpacity(.7),
                        fontSize: 16,
                        fontWeight: FontWeight.w300),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget displayMedia() {
    try {
      /// the FadeInImage.assetNetwork shows a default image until imageProduct load completely.
      return FadeInImage.assetNetwork(
        placeholder: 'assets/images/Pattern Success.png',
        image: widget.product.images[0].src!,
        fit: BoxFit.contain,
      );
    } catch (e) {
      print(e);
      return Image.asset("assets/images/Pattern Success.png");
    }
  }

  percentBox(int off) {
    if (off == 0)
      return Container();
    else
      return Container(
        padding: EdgeInsets.only(right: 2),
        width: 35,
        height: 18,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40), color: Colors.red),
        child: Center(
          child: Text(
            off.toString(),
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      );
  }

  regularBox() {
    return Align(
      alignment: Alignment.topRight,
      child: Text(
          kCheckPrice(widget.product.regularPrice != null
              ? widget.product.regularPrice
              : 0.toString()),
          style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough),
          maxLines: 1),
    );
  }
}
