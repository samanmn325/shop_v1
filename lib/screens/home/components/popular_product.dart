import '../../../components/product_card.dart';
import '../../../net/brain.dart';
import '../../../screens/product_detail/product_page.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce/models/products.dart';

import '../../../constants.dart';

class PopularProducts extends StatefulWidget {
  final String catName;
  PopularProducts({required this.catName});

  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  List<WooProduct> product = [];
  var catId;
  getProducts() async {
    product = await filterProducts(Brain.publicProductList);
    setState(() {});
  }

  filterProducts(List<WooProduct> allProduct) async {
    for (int i = 0; i < allProduct.length; i++) {
      for (int j = 0; j < allProduct[i].categories.length; j++) {
        if (allProduct[i].categories[j].name == widget.catName) {
          catId = allProduct[i].categories[j].id;
          product.add(allProduct[i]);
        }
      }
    }
    var cat = {product, catId};
    return cat;
  }

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.catName}',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ProductPage(
                        catId: catId,
                        catName: "${widget.catName}",
                      );
                    }));
                  },
                  child: Text(
                    "بیشتر",
                    style: TextStyle(color: kBaseColor3),
                  ),
                ),
              ),
            ],
          ),
        ),
        //
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding: EdgeInsets.only(right: 8),
                  child: Row(
                    children: [
                      ...List.generate(
                        product.length,
                        (index) {
                          return ProductCard(
                            product: product[index],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        // end of popular title box
        // SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   child: Row(
        //     children: [
        //       ...List.generate(
        //         Brain.product.length,
        //             (index) {
        //
        //             return ProductCard(product: Brain.product[index]);
        //
        //           // return SizedBox.shrink(); // here by default width and height is 0
        //         },
        //       ),
        //       SizedBox(width: 20),
        //     ],
        //   ),
        // )
        Divider()
      ],
    );
  }
}
