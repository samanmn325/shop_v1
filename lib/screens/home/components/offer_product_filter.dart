
import '../../../../net/brain.dart';




getProductDates() {
  for (int k = 0; k < Brain.publicProductList.length; k++) {

      if (Brain.publicProductList[k].dateOnSaleTo != null) {
        Brain.fiteredProducts.add(Brain.publicProductList[k]);
      }
    
  }
  

}
