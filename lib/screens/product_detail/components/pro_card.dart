import '../../../../screens/product_detail/product_details.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce/models/products.dart';
import '../../../constants.dart';

class ProCard extends StatefulWidget {
  ProCard({
    required this.product,
  });
  final WooProduct product;

  @override
  _ProCardState createState() => _ProCardState();
}

class _ProCardState extends State<ProCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 8),
        height: MediaQuery.of(context).size.height * 0.29,
        width: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, ProductDetail.routeName,
                arguments: widget.product);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.product.images[0].src!,
                    ),
                    fit: BoxFit.fitHeight,
                  ),
                  // color: kSecondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  widget.product.name!,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                  ),
                  maxLines: 2,
                ),
              ),
              Divider(
                height: 0.2,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'ریال ${kCheckPrice(widget.product.price)}',
                  style: TextStyle(
                      color: Colors.black.withOpacity(.7),
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ));
  }
}
