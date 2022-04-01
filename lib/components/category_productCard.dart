import '../../screens/product_detail/product_details.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce/models/products.dart';
import '../../constants.dart';

class CategoryProductCard extends StatelessWidget {
  const CategoryProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
  }) : super(key: key);

  final double width, aspectRetio;
  final WooProduct product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetail.routeName,
            arguments: product);
      },
      child: Row(
        children: [
          Container(
            height: 252,
            width: 150,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(product.images[0].src!),
              fit: BoxFit.contain,
            )),
            /* child: Image(
              image: NetworkImage(product.images[0].src),
            ),*/
          ),
          const SizedBox(height: 10),
          Spacer(),
          Column(
            children: [
              Text(
                product.name!,
                style: TextStyle(color: Colors.black),
                maxLines: 2,
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 13.0),
                child: Text(
                  " ریال ${kCheckPrice(product.price)}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
