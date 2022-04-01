import '../../components/product_card.dart';
import '../../net/brain.dart';
import '../../screens/cart/components/cart_icon.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce/models/products.dart';
import '../../constants.dart';

class SearchResult extends StatefulWidget {
  static String routeName = "/search";
  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  int cartItemsLength = Brain.cartItem.length;
  List<WooProduct> result = [];
  List<WooProduct> products = Brain.publicProductList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Padding(
            padding: const EdgeInsets.fromLTRB(8, 30, 8, 8),
            child: Padding(
              padding: const EdgeInsets.only(top: 5, left: 14.0, right: 14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 35.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      autofocus: true,
                      onTap: () {
                        if (ModalRoute.of(context)!.settings.name !=
                            SearchResult.routeName)
                          Navigator.pushNamed(context, SearchResult.routeName);
                      },
                      onChanged: (value) {
                        if (value.length >= 3) {
                          final Sresult = products
                              .where((element) => element.name!
                                  .toLowerCase()
                                  .contains(
                                      value) /*|| element.lastName.contains(value)*/)
                              .toList();
                          setState(() {
                            this.result = Sresult;
                            //this.value = value;
                          });
                        } else
                          setState(() {
                            this.result.clear();
                          });
                      },
                      decoration: InputDecoration(
                          // contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: "جستجو محصول ...",
                          hintStyle: TextStyle(fontSize: 14),
                          prefixIcon: RotatedBox(
                            quarterTurns: 1,
                            child: Icon(
                              Icons.search,
                            ),
                          )),
                    ),
                  ),
                  SizedBox(),
                  CartIcon(),
                ],
              ),
            )),
      ),
      body: Container(
        padding: EdgeInsets.only(right: 11),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 1.48),
          children: List.generate(
            result.length,
            (index) => Container(
              margin: EdgeInsets.only(
                top: 8,
              ),
              //padding: EdgeInsets.only(left: 10),
              child: ProductCard(product: result[index]),
            ),
          ),
        ),
      ),
    );
  }
}
