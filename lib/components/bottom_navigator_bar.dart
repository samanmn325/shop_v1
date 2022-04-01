import '../../screens/billing/billing_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants.dart';
import '../enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({
    required this.selectedMenu,
  });
  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              icon: SvgPicture.asset(
                "assets/icons/Shop Icon.svg",
                color: MenuState.home == selectedMenu
                    ? kPrimaryColor
                    : inActiveIconColor,
              ),
              onPressed: () {
                if (ModalRoute.of(context)!.settings.name !=
                    HomeScreen.routeName)
                  Navigator.pushNamedAndRemoveUntil(
                      context, HomeScreen.routeName, (e) => false);
              }),
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/Bill Icon.svg",
              color: MenuState.Billing == selectedMenu
                  ? kPrimaryColor
                  : inActiveIconColor,
            ),
            onPressed: () {
              if (ModalRoute.of(context)!.settings.name !=
                  BillingScreen.routeName) {
                Navigator.pushNamedAndRemoveUntil(
                    context, BillingScreen.routeName, (e) => false);
              }
            },
          ),
          /* IconButton(
            icon: SvgPicture.asset("assets/icons/Chat bubble Icon.svg"),
            onPressed: () {},
          ),*/
          IconButton(
              icon: SvgPicture.asset(
                "assets/icons/User Icon.svg",
                color: MenuState.profile == selectedMenu
                    ? kPrimaryColor
                    : inActiveIconColor,
              ),
              onPressed: () {
                if (ModalRoute.of(context)!.settings.name !=
                    ProfileScreen.routeName)
                  Navigator.pushNamedAndRemoveUntil(
                      context, ProfileScreen.routeName, (e) => false);
              }),
        ],
      ),
    );
  }
}
