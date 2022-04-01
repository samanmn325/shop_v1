// ignore_for_file: import_of_legacy_library_into_null_safe

import '../../../components/custom_surfix_icon.dart';
import '../../../components/default_button.dart';
import '../../../net/brain.dart';
import '../../../net/net_helper.dart';
import '../../../screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:woocommerce/models/customer.dart';
import '../../../constants.dart';
import 'profile_pic.dart';

class EditProfileScreen extends StatefulWidget {
  static String routeName = "/editProfile";
  static WooCustomer customer = WooCustomer();
  static Billing billing = Billing();
  static Shipping shopping = Shipping();
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool showSpinner = false;
  bool isActive = false;
  int? id;
  String? avatarUrl;
  String? email = "";
  String? firstName;
  String? lastName;
  String? phone;
  String? city = "";
  String? state;
  String? address;

  getCustomer() {
    avatarUrl = Brain.customer.avatarUrl;
    email = Brain.customer.email;
    firstName = Brain.customer.firstName;
    lastName = Brain.customer.lastName;
    phone = Brain.customer.billing?.phone;
    city = Brain.customer.billing?.city;
    state = Brain.customer.billing?.state;
    address = Brain.customer.billing?.address1;
    setState(() {});
  }

  // The _onBackPressed is for back to HomeScreen and refresh it by press Android backButton.
  Future<bool?> onBackPressed() async {
    Navigator.pushNamedAndRemoveUntil(
        context, ProfileScreen.routeName, (_) => false);
    return true;
  }

  changeFunction() async {
    EditProfileScreen.billing = Billing(
        email: email,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        state: state,
        city: city,
        address1: address);
    EditProfileScreen.customer = WooCustomer(
        firstName: firstName,
        lastName: lastName,
        email: email,
        billing: EditProfileScreen.billing);

    if (isActive == false) {
      isActive = true;
      setState(() {});
    } else {
      setState(() {
        showSpinner = true;
      });
      try {
        Map<dynamic, dynamic> billing = {
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'phone': phone,
          'address_1': address,
          'state': state,
          'city': city,
        };
        Map<dynamic, dynamic> customerData = {
          'avatar_url': avatarUrl,
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'billing': billing,
        };
        Brain.customer = await NetworkHelper()
            .wooCommerce
            .updateCustomer(id: Brain.customer.id!, data: customerData);
        print(Brain.customer);
        if (email != null &&
            firstName != null &&
            lastName != null &&
            phone != null &&
            city != null &&
            state != null &&
            address != null &&
            email != "" &&
            firstName != "" &&
            lastName != "" &&
            phone != "" &&
            city != "" &&
            state != "" &&
            address != "") {
          Brain.isCustomerInfoFull = true;
        } else {
          Brain.isCustomerInfoFull = false;
        }
        kShowToast(context, 'باموفقیت ذخیره شد');
      } catch (e) {
        print(e);
      }

      // Creates a new Woocommerce customer and returns the WooCustomer object.

      setState(() {
        setState(() {
          showSpinner = false;
        });
        isActive = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCustomer();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool? result = await onBackPressed();
        result ??= false;
        return result;
      },
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Column(
              children: [
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.1,
                // ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          IconButton(
                            iconSize: 40.0,
                            icon: kBackIcon,
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  ProfileScreen.routeName, (_) => false);
                            },
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 50.0),
                            child: Text("ویرایش اطلاعات",
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 24)),
                          ),
                        ],
                      ),
                    )),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    nameField(firstName, isActive),
                    const SizedBox(
                      width: 4,
                    ),
                    familyField(lastName, isActive),
                  ],
                ),
                emailField(email, isActive),
                phoneFiled(phone, isActive),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  stateField(state, isActive),
                  const SizedBox(
                    width: 4,
                  ),
                  cityFiled(city, isActive)
                ]),
                const SizedBox(
                  height: 4,
                ),
                addressField(address, isActive),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: DefaultButton(
                      color: isActive ? Colors.green : kPrimaryColor,
                      text: isActive ? "ذخیره" : "ویرایش",
                      press: changeFunction),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

///////////////////////
//fields start/////////
//////////////////////

  Container nameField(String? name, bool? isWriteAble) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 10),
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(
          color: const Color(0xFFF5F6F9),
          borderRadius: BorderRadius.circular(20)),
      child: TextFormField(
        initialValue: name,
        enabled: isWriteAble,
        keyboardType: TextInputType.emailAddress,
        onSaved: (newValue) => name = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            name = value;
            firstName = value;
            setState(() {});
            // removeError(error: kEmailNullError);
          }
          if (emailValidatorRegExp.hasMatch(value)) {
            // removeError(error: kInvalidEmailError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty) {
            //addError(error: kEmailNullError);
            return "";
          } else if (!emailValidatorRegExp.hasMatch(value)) {
            //addError(error: kInvalidEmailError);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor)),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor)),
          labelText: "نام",
          labelStyle: const TextStyle(color: kPrimaryColor),
          hintText: "وارد کردن نام",
          hintStyle: const TextStyle(fontSize: 13),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
              color: kPrimaryColor, svgIcon: "assets/icons/User icon.svg"),
        ),
      ),
    );
  }

  Container familyField(String? family, bool? isWriteAble) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 10),
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(
          color: const Color(0xFFF5F6F9),
          borderRadius: BorderRadius.circular(20)),
      child: TextFormField(
        initialValue: family,
        enabled: isWriteAble,
        keyboardType: TextInputType.emailAddress,
        onSaved: (newValue) => family = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            family = value;
            lastName = value;
            setState(() {});
            // removeError(error: kEmailNullError);
          }
          if (emailValidatorRegExp.hasMatch(value)) {
            // removeError(error: kInvalidEmailError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty) {
            //addError(error: kEmailNullError);
            return "";
          } else if (!emailValidatorRegExp.hasMatch(value)) {
            //addError(error: kInvalidEmailError);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor)),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor)),
          labelText: "نام خانوادگی",
          labelStyle: const TextStyle(color: kPrimaryColor),
          hintText: "وارد کردن فامیلی",
          hintStyle: const TextStyle(fontSize: 13),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
              color: kPrimaryColor, svgIcon: "assets/icons/User icon.svg"),
        ),
      ),
    );
  }

  Container emailField(String? email2, bool? isWriteAble) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: const Color(0xFFF5F6F9),
          borderRadius: BorderRadius.circular(20)),
      child: TextFormField(
        initialValue: email2,
        enabled: isWriteAble,
        keyboardType: TextInputType.emailAddress,
        onSaved: (newValue) => email2 = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            email2 = value;
            email = value;
            setState(() {});
            // removeError(error: kEmailNullError);
          }
          if (emailValidatorRegExp.hasMatch(value)) {
            // removeError(error: kInvalidEmailError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty) {
            //addError(error: kEmailNullError);
            return "";
          } else if (!emailValidatorRegExp.hasMatch(value)) {
            //addError(error: kInvalidEmailError);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor)),
          labelText: "ایمیل",
          labelStyle: TextStyle(color: kPrimaryColor),
          hintText: "وارد کردن ایمیل",
          hintStyle: TextStyle(fontSize: 13),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
              color: kPrimaryColor, svgIcon: "assets/icons/Mail.svg"),
        ),
      ),
    );
  }

  Container phoneFiled(String? phone2, bool? isWriteAble) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: Color(0xFFF5F6F9), borderRadius: BorderRadius.circular(20)),
      child: TextFormField(
        initialValue: phone2,
        enabled: isWriteAble,
        keyboardType: TextInputType.emailAddress,
        onSaved: (newValue) => phone2 = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            phone2 = value;
            phone = value;
            setState(() {});
            // removeError(error: kEmailNullError);
          }
          if (emailValidatorRegExp.hasMatch(value)) {
            // removeError(error: kInvalidEmailError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty) {
            //addError(error: kEmailNullError);
            return "";
          } else if (!emailValidatorRegExp.hasMatch(value)) {
            //addError(error: kInvalidEmailError);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor)),
          labelText: "شماره تماس",
          labelStyle: TextStyle(color: kPrimaryColor),
          hintText: " وارد کردن شماره موبایل",
          hintStyle: TextStyle(fontSize: 13),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
              color: kPrimaryColor, svgIcon: "assets/icons/Phone.svg"),
        ),
      ),
    );
  }

  Container cityFiled(String? city2, bool? isWriteAble) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 10),
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(
          color: Color(0xFFF5F6F9), borderRadius: BorderRadius.circular(20)),
      child: TextFormField(
        initialValue: city2,
        enabled: isWriteAble,
        keyboardType: TextInputType.emailAddress,
        onSaved: (newValue) => city2 = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            city2 = value;
            city = value;
            setState(() {});
            // removeError(error: kEmailNullError);
          }
          if (emailValidatorRegExp.hasMatch(value)) {
            // removeError(error: kInvalidEmailError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty) {
            //addError(error: kEmailNullError);
            return "";
          } else if (!emailValidatorRegExp.hasMatch(value)) {
            //addError(error: kInvalidEmailError);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor)),
          labelText: "شهر",
          labelStyle: TextStyle(color: kPrimaryColor),
          hintText: "وارد کردن شهر",
          hintStyle: TextStyle(fontSize: 13),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
              color: kPrimaryColor, svgIcon: "assets/icons/User icon.svg"),
        ),
      ),
    );
  }

  Container stateField(String? state2, bool? isWriteAble) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 10),
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(
          color: Color(0xFFF5F6F9), borderRadius: BorderRadius.circular(20)),
      child: TextFormField(
        initialValue: state2,
        enabled: isWriteAble,
        keyboardType: TextInputType.emailAddress,
        onSaved: (newValue) => state2 = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            state2 = value;
            state = value;
            setState(() {});
            // removeError(error: kEmailNullError);
          }
          if (emailValidatorRegExp.hasMatch(value)) {
            // removeError(error: kInvalidEmailError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty) {
            //addError(error: kEmailNullError);
            return "";
          } else if (!emailValidatorRegExp.hasMatch(value)) {
            //addError(error: kInvalidEmailError);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor)),
          labelText: "استان",
          labelStyle: TextStyle(color: kPrimaryColor),
          hintText: "وارد کردن استان",
          hintStyle: TextStyle(fontSize: 13),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
              color: kPrimaryColor, svgIcon: "assets/icons/User icon.svg"),
        ),
      ),
    );
  }

  Container addressField(String? address2, bool? isWriteAble) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: Color(0xFFF5F6F9), borderRadius: BorderRadius.circular(20)),
      child: TextFormField(
        initialValue: address2,
        enabled: isWriteAble,
        keyboardType: TextInputType.emailAddress,
        onSaved: (newValue) => address2 = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            address2 = value;
            address = value;
            setState(() {});
            // removeError(error: kEmailNullError);
          }
          if (emailValidatorRegExp.hasMatch(value)) {
            // removeError(error: kInvalidEmailError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty) {
            //addError(error: kEmailNullError);
            return "";
          } else if (!emailValidatorRegExp.hasMatch(value)) {
            //addError(error: kInvalidEmailError);
            return "";
          }
          return null;
        },
        minLines: 3,
        maxLines: 3,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor)),
          labelText: "آدرس محل سکونت",
          labelStyle: TextStyle(color: kPrimaryColor),
          hintText: "وارد کردن آدرس",
          hintStyle: TextStyle(fontSize: 13),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
              color: kPrimaryColor, svgIcon: "assets/icons/Home.svg"),
        ),
      ),
    );
  }
}
