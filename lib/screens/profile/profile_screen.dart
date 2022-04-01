import '../../components/bottom_navigator_bar.dart';
import '../../net/brain.dart';
import '../../net/net_helper.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/login/login_popup.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce/models/customer.dart';
import '../../constants.dart';
import '../../enums.dart';
import 'components/edit_profile.dart';
import 'components/profile_menu.dart';
import 'components/profile_pic.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = "/profile";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // The _onBackPressed is for back to HomeScreen and refresh it by press Android backButton.
  Future<bool?> onBackPressed() async {
    Navigator.pushNamedAndRemoveUntil(
        context, HomeScreen.routeName, (_) => false);
    return true;
  }

  void exitFromProfile() async {
    try {
      bool isLoggedIn = await NetworkHelper().wooCommerce.isCustomerLoggedIn();
      if (isLoggedIn) {
        await NetworkHelper().wooCommerce.logUserOut();
        Brain.isLoggedIn = false;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Brain(selectedRouteName: HomeScreen.routeName)));
        kShowToast(context, 'شما از حساب کاربری خود خارج شدید');
      } else {
        Brain.isLoggedIn = false;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Brain(selectedRouteName: HomeScreen.routeName)));
        kShowToast(context, 'شما داخل حساب کاربری خود نیستید');
      }
    } catch (exception) {
      kShowToast(context,
          'به دلیل مشکلاتی شما نمی توانید از حساب کاربری خود خارج شوید');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool? result = await onBackPressed();
        if (result == null) {
          result = false;
        }
        return result;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: null,
          title: Text("پروفایل",
              style: TextStyle(color: Colors.black87, fontSize: 24)),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              // ProfilePic(
              //   isEditAble: false,
              // ),
              SizedBox(height: 20),
              ProfileMenu(
                text: "حساب من",
                icon: "assets/icons/User Icon.svg",
                press: () async {
                  bool isLoggedIn =
                      await NetworkHelper().wooCommerce.isCustomerLoggedIn();
                  if (isLoggedIn) {
                    // Navigator.pushNamed(context, EditProfileScreen.routeName);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Brain(
                                selectedRouteName:
                                    EditProfileScreen.routeName)));
                  } else {
                    kShowToast(context, 'شما داخل حساب کاربری خود نیستید');
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return LoginPopUp(
                            selectedScreen: Screen.profile,
                          );
                        });
                  }
                },
              ),
              /*     ProfileMenu(
              text: "اعلان ها",
              icon: "assets/icons/Bell.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "تنظیمات",
              icon: "assets/icons/Settings.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "پشتیبانی",
              icon: "assets/icons/Question mark.svg",
              press: () {},
            ),*/
              ProfileMenu(
                text: "خروج از حساب",
                icon: "assets/icons/Log out.svg",
                press: () async {
                  Brain.billing = Billing();
                  Brain.customer = WooCustomer();
                  Brain.cartItem = [];
                  exitFromProfile();
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar:
            CustomBottomNavBar(selectedMenu: MenuState.profile),
      ),
    );
  }
}
