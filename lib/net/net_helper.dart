import 'package:woocommerce/woocommerce.dart';
import 'package:html/parser.dart';
import 'brain.dart';

///betashop.epicsite
// const String baseUrl = "https://betashop.epicsite.ir/";
// const String consumerKey = "ck_ee80c4557d35c6e5fbb97b4bb4ded66e108a885c";
// const String consumerSecret = "cs_b55304e54c8977048227e670db75fd82db6b3344";

/// test.epicsite
// const String baseUrl = "https://test.epicsite.ir/";
// const String consumerKey = "ck_3676d375f6158fcb8cd8b6d0d45a2b50736313d4";
// const String consumerSecret = "cs_aed1dfc74ee0468bb93e4ec7ee5f6b05dc3b9902";

///avangtalaee
// const String baseUrl = "https://avangtalaee.com/";
// const String consumerKey = "ck_7da725063caad3ea318860cc9cd62e76a0b8b7e0";
// const String consumerSecret = "cs_da37c91609237a66727407db62371a28e426bcce";

///avangtalaee new
const String baseUrl = "https://avangtalaee.com/";
const String consumerKey = "ck_6e2d78917e611fb71d848f7cd964306279bb3fa2";
const String consumerSecret = "cs_20afcc0056424f263e8a6637e2bd8db28ac01672";

class NetworkHelper {
  WooCommerce wooCommerce = WooCommerce(
    baseUrl: baseUrl,
    consumerKey: consumerKey,
    consumerSecret: consumerSecret,
    isDebug: true,
  );

  /// the getProducts is here for get online Product from epicsite
  getProduct() async {
    Brain.allProductList = await NetworkHelper().wooCommerce.getProducts();
    for (int i = 0; i < Brain.allProductList.length; i++) {
      if (Brain.allProductList[i].status == 'publish') {
        Brain.publicProductList.add(Brain.allProductList[i]);
      }
    }
    Brain.productCategory =
        await NetworkHelper().wooCommerce.getProductCategories();
  }

  getCart() async {
    Brain.cartItem = await NetworkHelper().wooCommerce.getMyCartItems();
    // WelcomeScreen.myCart = await NetworkHelper().wooCommerce.getMyCart();
  }

  ///The parseHtmlString is here for convert htmlString to String
  String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;
    return parsedString;
  }

  /// the addToCart is for adding product to online cartItem
  addToCart() async {
    // check user is login or not . if user logged in add item to user cart.
    if (Brain.isLoggedIn) {
      for (var temp in Brain.cartItem) {
        Brain.cartItem.add(await NetworkHelper().wooCommerce.addToMyCart(
            itemId: temp.id.toString(), quantity: temp.quantity.toString()));

        print(
            '###################################################################');
        print(temp.id);
        print(
            '###################################################################');
      }
    }
  }

  late int id;

  /// the getCustomer is for get customer information.
  Future<bool> getCustomer() async {
    this.id = (await NetworkHelper().wooCommerce.fetchLoggedInUserId())!;

    Brain.customer = await NetworkHelper().wooCommerce.getCustomerById(id: id);
    if (Brain.customer.email != null &&
        Brain.customer.email != "" &&
        Brain.customer.firstName != null &&
        Brain.customer.firstName != "" &&
        Brain.customer.lastName != null &&
        Brain.customer.lastName != "" &&
        Brain.customer.billing!.phone != null &&
        Brain.customer.billing!.phone != "" &&
        Brain.customer.billing!.city != null &&
        Brain.customer.billing!.city != "" &&
        Brain.customer.billing!.state != null &&
        Brain.customer.billing!.state != "" &&
        Brain.customer.billing!.address1 != null &&
        Brain.customer.billing!.address1 != "") {
      return Brain.isCustomerInfoFull = true;
    } else {
      return Brain.isCustomerInfoFull = false;
    }
  }
}
