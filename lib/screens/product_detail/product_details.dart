import '../../net/data.dart';
import '../../screens/cart/components/cart_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/models/cart_item.dart';
import 'package:woocommerce/woocommerce.dart';
import '../../constants.dart';
import 'components/default_btn.dart';
import 'components/product_description.dart';
import 'components/product_images.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({
    Key? key,
  }) : super(key: key);
  static String routeName = '/details';
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  List<WooCartItemImages> cartImages = [];
  bool isExist = false;
  late int index = 0;
  int quantity = 1;

  /// The _onBackPressed is for back to HomeScreen and refresh it by press Android backButton.
  Future<bool?> onBackPressed() async {
    Navigator.pop(context);
    // Navigator.pushNamedAndRemoveUntil(
    //     context, HomeScreen.routeName, (_) => false);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // todo
    final args = ModalRoute.of(context)!.settings.arguments as ProductArguments;

    return Consumer<Data>(builder: (context, data, child) {
      return WillPopScope(
        onWillPop: () async {
          bool? result = await onBackPressed();
          if (result == null) {
            result = false;
          }
          return result;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Color(0xFFF5F6F9),
          appBar: AppBar(
            leading: IconButton(
              iconSize: 40.0,
              icon: Icon(Icons.arrow_left),
              onPressed: () {
                Navigator.pop(context);
                // Navigator.pushNamedAndRemoveUntil(
                //     context, HomeScreen.routeName, (_) => false);
              },
            ),
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
                    SizedBox(),
                    CartIcon(),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: 80,
            child: Container(
                padding: EdgeInsets.only(top: 5),
                color: kSecondaryColor.withOpacity(0.1),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ///add to cart button
                        Padding(
                          padding: EdgeInsets.only(
                            left: 5,
                            right: 10,
                            bottom: 8,
                          ),
                          child: DefaultButton(
                            text: "افزودن به سبد خرید",
                            press: () async {
                              //todo productDetails
                              /// check user is login or not . if user logged in add item to user cart.
                              /// instock , outofstock , onbackorder
                              if (args.product.stockStatus == 'outofstock') {
                                kShowToast(context, 'محصول موجود نیست');
                              } else if (args.product.stockStatus ==
                                  'instock') {
                                /// this loop does not let to put extra item in Brain.cartItem.
                                for (int i = 0; i < data.cartItem.length; i++) {
                                  if (args.product.name ==
                                      data.cartItem[i].name) {
                                    setState(() {
                                      isExist = true;
                                      index = i;
                                    });
                                  }
                                }
                                if (isExist) {
                                  data.cartItem[index].quantity =
                                      data.cartItem[index].quantity! + quantity;
                                } else {
                                  try {
                                    cartImages.add(WooCartItemImages(
                                        src: args.product.images[0].src));
                                    int price = 0;
                                    price += int.parse(args.product.price!) *
                                        quantity;
                                    // NetworkHelper().wooCommerce.addToMyCart(itemId: args.product.id.toString(), quantity: quantity.toString());
                                    data.setCartItem(WooCartItem(
                                      images: cartImages,
                                      quantity: quantity,
                                      name: args.product.name,
                                      price: price.toString(),
                                    ));
                                  } catch (e) {
                                    cartImages.add(WooCartItemImages(
                                        src:
                                            'assets/images/Pattern Success.png'));
                                    int price = 0;
                                    price += int.parse(args.product.price!) *
                                        quantity;
                                    // NetworkHelper().wooCommerce.addToMyCart(itemId: args.product.id.toString(), quantity: quantity.toString());
                                    data.setCartItem(WooCartItem(
                                      images: cartImages,
                                      quantity: quantity,
                                      name: args.product.name,
                                      price: price.toString(),
                                    ));
                                  }
                                }
                              }
                            },
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(
                              left: 10,
                              right: 5,
                              bottom: 8,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  FloatingActionButton(
                                    elevation: 0,
                                    backgroundColor:
                                        kSecondaryColor.withOpacity(0.2),
                                    onPressed: () {
                                      if (quantity >= 1) {
                                        quantity++;
                                        setState(() {});
                                      }
                                    },
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                  Text(quantity.toString()),
                                  FloatingActionButton(
                                    elevation: 0,
                                    backgroundColor:
                                        kSecondaryColor.withOpacity(0.2),
                                    foregroundColor: kPrimaryColor,
                                    onPressed: () {
                                      if (quantity > 1) {
                                        quantity--;
                                        setState(() {});
                                      }
                                    },
                                    child: Icon(Icons.remove),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
          body: ListView(
            children: [
              //PRODUCT IMAGES
              ProductImages(product: args.product),
              Container(
                // height: MediaQuery.of(context).size.height * 0.5,
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.only(top: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    //PRODUCT DESCRIPTION AND NAME
                    ProductDescription(
                      product: args.product,
                      off: args.off,
                      pressOnSeeMore: () {},
                    ),
                    // extra area for mor details can be use like weight color ....
                    /*TopRoundedContainer(
                    color: Color(0xFFF6F7F9),
                    child: Column(
                      children: [
                        // ColorDots(product: widget.product),
                      ],
                    ),
                  ),*/
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class ProductArguments {
  final WooProduct product;
  final int off;

  ProductArguments(this.product, this.off);
}
