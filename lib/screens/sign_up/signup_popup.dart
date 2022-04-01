// ignore_for_file: import_of_legacy_library_into_null_safe


import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:woocommerce/woocommerce.dart';
import '../../components/custom_surfix_icon.dart';
import '../../components/default_button.dart';
import '../../components/form_error.dart';
import '../../constants.dart';
import '../../enums.dart';
import '../../net/brain.dart';
import '../../net/net_helper.dart';
import '../cart/cart_screen.dart';
import '../home/home_screen.dart';
import '../profile/components/edit_profile.dart';

class SignupPopup extends StatefulWidget {
  const SignupPopup({Key? key, required this.selectedScreen}) : super(key: key);
  final Screen selectedScreen;

  @override
  _SignupPopupState createState() => _SignupPopupState();
}

class _SignupPopupState extends State<SignupPopup> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String userName;
  late String password;
  late String conform_password;
  bool remember = false;
  bool showSpinner = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  /// screenChecker helps to check which screen should showing to user.
  void screenChecker(Screen selectedScreen) {
    if (selectedScreen == Screen.drawer) {
      navigateToScreen(HomeScreen.routeName);
    }
    if (selectedScreen == Screen.cart) {
      navigateToScreen(CartScreen.routeName);
    }
    if (selectedScreen == Screen.profile) {
      navigateToScreen(EditProfileScreen.routeName);
    }
  }

  /// navigateToScreen helps to navigate user to target screen
  void navigateToScreen(String routeName) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Brain(selectedRouteName: routeName)));
    kShowToast(context, "با موفقیت وارد حساب کاربری شدید");
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: AlertDialog(
        content: Container(
          height: 400.0,
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned(
                right: -40.0,
                top: -40.0,
                child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Colors.red,
                    )),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              Scrollbar(
                isAlwaysShown: true,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        FormError(errors: errors),
                        SizedBox(height: 15.0),
                        buildEmailFormField(),
                        SizedBox(height: 15.0),
                        buildUsernameFormField(),
                        SizedBox(height: 15.0),
                        buildPasswordFormField(),
                        SizedBox(height: 15.0),
                        buildConformPassFormField(),
                        SizedBox(height: 10.0),
                        DefaultButton(
                          text: "ثبت نام",
                          width: 150.0,
                          press: () async {
                            // if all are valid then go to success screen and then go to home screen
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              // Creates a new Woocommerce customer and returns the WooCustomer object.
                              
                              try {
                                setState(() {showSpinner = true; });
                                WooCustomer user = WooCustomer(
                                    username: userName,
                                    password: password,
                                    email: email);
                                final result = await NetworkHelper()
                                    .wooCommerce
                                    .createCustomer(user);
                                if (result) {
                                  setState(() {
                                    showSpinner = false;
                                  });
                                  await NetworkHelper()
                                      .wooCommerce
                                      .loginCustomer(
                                          username: userName,
                                          password: password);
                                  bool isLoggedIn = await NetworkHelper()
                                      .wooCommerce
                                      .isCustomerLoggedIn();
                                  if (isLoggedIn) {
                                    // await Future.delayed(Duration(seconds: 10));

                                    screenChecker(widget.selectedScreen);
                                  } else {
                                    setState(() {
                                      showSpinner = false;
                                    });
                                    // Navigator.pop(context);
                                    kShowToast(context,
                                        "ساخت حساب کاربری شما به مشکل خورده است.");
                                  }
                                } else {
                                  setState(() {
                                    showSpinner = false;
                                  });
                                  Navigator.pop(context);
                                  kShowToast(context,
                                      "ساخت حساب کاربری شما به مشکل خورده است.");
                                }
                              } catch (e) {
                                Navigator.pop(context);
                                kShowToast(context,
                                    "ساخت حساب کاربری شما به مشکل خورده است.");
                                print(e);
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conform_password = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == conform_password) {
          removeError(error: kMatchPassError);
        }
        conform_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "تایید رمز عبور",
        hintText: "دوباره رمز را وارد کنید",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        }
        if (value.length >= 4) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 4) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "رمز عبور",
        hintText: "رمز خود را وارد کنید",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildUsernameFormField() {
    return TextFormField(
      onSaved: (newValue) => userName = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kUsernameNullError);
        } else if (value.length >= 3) {
          removeError(error: kShortUserNameError);
        }
        userName = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kUsernameNullError);
          return "";
        } else if (value.length < 3) {
          addError(error: kShortUserNameError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "نام کاربری",
        hintText: "نام کاربری را وارد کنید",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        }
        if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "ایمیل",
        hintText: "ایمیل خود را وارد کنید",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
