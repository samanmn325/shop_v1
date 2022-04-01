import '../../../net/brain.dart';
import '../../../screens/home/search_resultPage.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce/models/products.dart';

import '../../../constants.dart';
// ignore_for_file: must_be_immutable

class searchBox extends StatefulWidget {
  searchBox({this.autoFocus = false});
  bool autoFocus;

  @override
  State<searchBox> createState() => _searchBoxState();
}

class _searchBoxState extends State<searchBox> {
  List<WooProduct> result = [];
  List<WooProduct> products = Brain.publicProductList;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.65,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        autofocus: widget.autoFocus,
        onTap: () {
          if (ModalRoute.of(context)!.settings.name != SearchResult.routeName)
            Navigator.pushNamed(context, SearchResult.routeName);
        },
        onChanged: (value) {
          if (value.length >= 3) {
            final Sresult = products
                .where((element) => element.name!
                    .contains(value) /*|| element.lastName.contains(value)*/)
                .toList();
            setState(() {
              this.result = Sresult;
              //this.value = value;
            });
          }
        },
        decoration: InputDecoration(
            // contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 9),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "جستجو محصول ...",
            hintStyle: TextStyle(fontSize: 12),
            prefixIcon: RotatedBox(
              quarterTurns: 1,
              child: Icon(
                Icons.search,
              ),
            )),
      ),
    );
  }
}
