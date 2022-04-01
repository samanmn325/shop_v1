import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

const Color kBaseColor0 = Color(0xFFF5F6F9);

///white
const Color kBaseColor1 = Color(0xFFFFE6E6);

///white
const Color kBaseColor2 = Color(0xfff7b4dd);

///Veri Peri
const Color kBaseColor3 = Color(0xff97999b);

///Ultimate Gray
const Color kBaseColor4 = Color(0xff104581);

///Classic Blueconst
const Color kBaseColor5 = Color(0xFFAA95FA);

///

/// kCheckPrice has two jobs :
///  1. convert currency to toman .
///  2. check null prices .
String kCheckPrice(String? price) {
  if (price == '') {
    return '0';
  } else {
    var formatter = NumberFormat('###,###,###,###');
    var a = int.parse(price!);
    var c = formatter.format(a);
    print(c);
    return c;
  }
}

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);
const defaultDuration = Duration(milliseconds: 250);
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "لطفا ایمیل خود را وارد کنید";
const String kInvalidEmailError = "ایمیل وارد شده نا معتبر است!";
const String kPassNullError = "رمز عبور خود را وارد کنید";
const String kShortPassError = "رمز وارد شده کوتاه است";
const String kMatchPassError = "رمز وارد شده همخوانی ندارد";
const String kUsernameNullError = "نام کاربری خود را وارد کنید";
const String kShortUserNameError =
    "نام کاربری وارد شده نباید کمتر از سه حرف باشد";
const String kNameNullError = "نام خود را وارد کنید";
const String kPhoneNumberNullError = "شماره تماس خود را وارد کنید";
const String kAddressNullError = "آدرس خود را وارد کنید";

void kShowToast(BuildContext context, String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
  // final scaffold = ScaffoldMessenger.of(context);
  // scaffold.showSnackBar(
  //   SnackBar(
  //     content: Text(text),
  //     action:
  //         SnackBarAction(label: '', onPressed: scaffold.hideCurrentSnackBar),
  //   ),
  // );
}

class NetButton extends StatelessWidget {
  NetButton({this.text, this.press});
  final String? text;
  final VoidCallback? press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 130,
        height: 50,
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0x951EBFFF)),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
              )),
            ),
            onPressed: press,
            child: Center(
              child: Text(text!),
            )),
      ),
    );
  }
}

isNull(var input) {
  if (input == null || input == Null || input == "" || input == '')
    return true;
  else
    return false;
}
