import '../../../net/data.dart';
import '../../../screens/cart/components/cart_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../search_resultPage.dart';

class Header extends StatefulWidget {
  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  int? cartItemsLength;
  @override
  Widget build(BuildContext context) {
    cartItemsLength = context.watch<Data>().cartItem.length;
    // ignore: unnecessary_null_comparison
    return Consumer<Data>(
      builder: (context, data, child) {
        return Padding(
          padding: const EdgeInsets.only(top: 5, left: 14.0, right: 14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 35.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, SearchResult.routeName);
                },
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Icon(
                    Icons.search,
                  ),
                ),
              ),
              Spacer(),
              Text(
                "آونگ طلایی",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Iransans",
                    color: Colors.black.withOpacity(0.75)),
              ),
              Spacer(),
              SizedBox(),
              CartIcon(),
            ],
          ),
        );
      },
    );
  }
}
// Stack(
// clipBehavior: Clip.none, children: [
// Container(
// padding:
// EdgeInsets.only(top: 10, left: 12, bottom: 10, right: 8),
// height: 46,
// width: 46,
// decoration: BoxDecoration(
// // borderRadius: BorderRadius.circular(50),
// color: kSecondaryColor.withOpacity(0.1),
// shape: BoxShape.circle),
// child: SvgPicture.asset(
// "assets/icons/Cart Icon.svg",
// matchTextDirection: true,
// ),
// ),
// Positioned(
// top: 0,
// left: 0,
// child: Container(
// height: 15,
// width: 15,
// decoration: BoxDecoration(
// shape: BoxShape.circle, color: Colors.red),
// child: Center(
// child: Text(
// cartItemsLength.toString(),
// style: TextStyle(fontSize: 11, color: Colors.white),
// ),
// ),
// ),
// )
// ],
// )