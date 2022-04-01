import 'package:badges/badges.dart';
import '../../../net/data.dart';
import '../../../screens/cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../constants.dart';

class CartIcon extends StatefulWidget {
  @override
  State<CartIcon> createState() => _CartIconState();
}

class _CartIconState extends State<CartIcon> {
  @override
  Widget build(BuildContext context) {
    int cartItemsLength = context.watch<Data>().cartItem.length;
    // ignore: unnecessary_null_comparison
    if (cartItemsLength == null) {
      cartItemsLength = 0;
    }
    return Consumer<Data>(
      builder: (context, data, child) {
        return InkWell(
          onTap: () {
            if (cartItemsLength == 0) {
              kShowToast(context, 'سبد خرید خالی است');
            } else {
              Navigator.pushNamed(
                context,
                CartScreen.routeName,
              );
            }
          },
          child: Badge(
            position: BadgePosition(top: 0, end: 1),
            badgeContent: Text(cartItemsLength.toString(),
                style: TextStyle(fontSize: 11, color: Colors.white)),
            child: Container(
              padding: EdgeInsets.only(top: 10, left: 12, bottom: 10, right: 8),
              height: 46,
              width: 46,
              decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(50),
                  color: kSecondaryColor.withOpacity(0.1),
                  shape: BoxShape.circle),
              child: SvgPicture.asset(
                "assets/icons/Cart Icon.svg",
                matchTextDirection: true,
              ),
            ),
          ),
        );
      },
    );
  }
}
// Stack(
// clipBehavior: Clip.none,
// children: [
// Container(
// padding: EdgeInsets.only(top: 10, left: 12, bottom: 10, right: 8),
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