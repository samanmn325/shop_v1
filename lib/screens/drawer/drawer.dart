import '../../../constants.dart';
import '../../../enums.dart';
import '../../../net/net_helper.dart';
import '../../../screens/home/components/category_box.dart';
import '../../../screens/login/login_popup.dart';
import 'package:flutter/material.dart';

const kTextStyle = TextStyle(color: Colors.black, fontWeight: FontWeight.w300);

class MyDrawer extends StatefulWidget {
  MyDrawer({Key? key, this.child}) : super(key: key);
  final Widget? child;
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  int _selectedDestination = 0;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 50.0, 8.0, 8.0),
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Center(
                child: Text(
                  'بتاشاپ',
                  style: kTextStyle,
                ),
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text(
                'ورود و ثبت نام',
                style: kTextStyle,
              ),
              selected: _selectedDestination == 1,
              onTap: () async {
                bool isLoggedIn =
                    await NetworkHelper().wooCommerce.isCustomerLoggedIn();
                if (isLoggedIn) {
                  kShowToast(context, 'شما قبلا وارد حساب خود شده اید.');
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return LoginPopUp(
                          selectedScreen: Screen.drawer,
                        );
                      });
                }
              },
            ),
            SubMenu(),
            Divider(
              height: 1,
              thickness: 1,
            ),
            ExpansionTile(
              title: Text('ارتباط با ما'),
              leading: Icon(Icons.message),
              children: <Widget>[
                Align(
                  child: Text(' ایمیل :  epicsite@gmail.com  '),
                  alignment: Alignment.center,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Divider(
                  endIndent: 30,
                  indent: 30,
                  height: 1,
                  thickness: 1,
                ),
                Align(
                  child: Text(' شماره تماس : 021 - 2245985'),
                  alignment: Alignment.center,
                ),
                SizedBox(
                  height: 5.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }
}

class SubMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('دسته بندی'),
      leading: Icon(Icons.view_list),
      children: <Widget>[
        DrawerCategory(),
      ],
    );
  }
}

class RoundedMenuItem extends StatelessWidget {
  RoundedMenuItem({this.text, this.press});
  final String? text;
  final VoidCallback? press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          Icon(Icons.add_circle_outline),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: Text(text!),
              onTap: press,
            ),
          ),
        ],
      ),
    );
  }
}
