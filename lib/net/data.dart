// ignore_for_file: unused_field

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woocommerce/models/customer.dart';
import 'package:woocommerce/woocommerce.dart';

import 'brain.dart';

class Data extends ChangeNotifier {
  SharedPreferences? _pref;
  List<WooCartItem> _pCartItem = [];
  List<WooProduct> _pPublicProductList = [];
  List<WooProduct> _pAllProductList = [];
  List<WooProductCategory> _pProductCategory = [];
  //List<WooProductDates> _pProductDates = [];
  List<WooProduct> _pFilteredProducts = [];
  List<String> _pHPCategoryProduct = [];
  WooCustomer _pCustomer = WooCustomer();
  Billing _pBilling = Billing();
  Shipping _pShopping = Shipping();
  WooCart? _pMyCart;
  bool _pIsLoggedIn = false;
  bool _pIsCustomerInfoFull = false;
  int totalPrice = 0;

  SharedPreferences get pref => _pref!;

  setPref(List<String> value) async {
    _pref = await SharedPreferences.getInstance();
    _pref!.setStringList('stringList', ['orage', 'apple', 'banana']);
    notifyListeners();
  }

  /// calculateTotalPrice is for calculate [totalPrice] and change it form String to Integer
  calculateTotalPrice() {
    totalPrice = 0;
    for (int i = 0; i < _pCartItem.length; i++) {
      for (int j = 0; j < Brain.publicProductList.length; j++) {
        if (Brain.publicProductList[j].name == _pCartItem[i].name ||
            Brain.publicProductList[j].id == _pCartItem[i].id) {
          setPrice(i, Brain.publicProductList[j].price);
          int temp = changePrice(_pCartItem[i].price!) * _pCartItem[i].quantity!;
          totalPrice += temp;
        }
      }
      notifyListeners();
    }
  }

  int changePrice(String price) {
    int changedPrice = int.parse(price);
    return changedPrice;
  }

  ///. AllProductList ///////////////////////////////////////////////////
  List<WooProduct> get pAllProductList => _pAllProductList;
  void setAllProductList(List<WooProduct> value) {
    _pAllProductList = value;
    for (int i = 0; i < _pAllProductList.length; i++) {
      if (_pAllProductList[i].status == 'publish') {
        setPublicProductList(_pAllProductList[i]);
        // _pPublicProductList.add(_pAllProductList[i]);
      }
    }
    notifyListeners();
  }

  ///. PublicProductList ///////////////////////////////////////////////////
  List<WooProduct> get pPublicProductList => _pPublicProductList;
  void setPublicProductList(WooProduct value) {
    _pPublicProductList.add(value);
    notifyListeners();
  }

  ///. ProductCategory ///////////////////////////////////////////////////
  List<WooProductCategory> get pProductCategory => _pProductCategory;
  void setProductCategory(List<WooProductCategory> value) {
    _pProductCategory = value;
    notifyListeners();
  }

  ///. HPCategoryProduct ///////////////////////////////////////////////////
  List<String> get pHPCategoryProduct => _pHPCategoryProduct;
  void setHPCategoryProduct(String value) {
    _pHPCategoryProduct.add(value);
    notifyListeners();
  }

  ///. CartItem ///////////////////////////////////////////////////
  List<WooCartItem> get cartItem => _pCartItem;
  void setCartItem(WooCartItem value) {
    _pCartItem.add(value);
    notifyListeners();
  }

  void setCartQuantity(int? id, bool temp) {
    for (WooCartItem cart in _pCartItem) {
      if (cart.id == id) {
        if (temp) {
          cart.quantity = cart.quantity! + 1;
        } else {
          cart.quantity = cart.quantity! - 1;
        }
      }
      notifyListeners();
    }
  }

  void setCartItems(List<WooCartItem> value) {
    _pCartItem = value;
    notifyListeners();
  }

  void setPrice(int index, String? newPrice) {
    cartItem[index].price = newPrice;
    notifyListeners();
  }

  void removeCartItem(WooCartItem value) {
    _pCartItem.remove(value);
    notifyListeners();
  }

  ///. ProductDates ////////////////////////////////////////////////
  /*List<WooProductDates> get pProductDates => _pProductDates;
  void setProductDates(List<WooProductDates> onlineProduct) {
    _pProductDates = onlineProduct;
    notifyListeners();
  }*/

  ///. FilteredProducts ///////////////////////////////////////////
  List<WooProduct> get pFilteredProducts => _pFilteredProducts;
  void setFilteredProducts(WooProduct value) {
    _pFilteredProducts.add(value);
    notifyListeners();
  }

  ///.////////////////////////////////////
  int _counter = 0;
  int get counter => _counter;
  void addCount() {
    _counter++;
    notifyListeners();
  }
}
