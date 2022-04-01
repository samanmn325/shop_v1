import 'package:flutter/material.dart';
import 'package:woocommerce/models/products.dart';

import '../../../constants.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.product,
  }) : super(key: key);

  final WooProduct product;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: SizedBox(
            width: 238,
            height: MediaQuery.of(context).size.height * 0.3,
            child: AspectRatio(
              aspectRatio: 1,
              child: Hero(
                tag: widget.product.id.toString(),
                child: displayMedia(),
              ),
            ),
          ),
        ),
       
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(widget.product.images.length,
                      (index) => buildSmallProductPreview(index)),
            ],
          ),
        )
      ],
    );
  }
  /// displayMedia check imageProduct .when product has not image to show 'displayMedia return a default image'.
  Widget displayMedia() {
    try {
      return FadeInImage.assetNetwork(
        placeholder: 'assets/images/Pattern Success.png',
        image: widget.product.images[selectedImage].src!,
        fit: BoxFit.contain,
      );
    } catch (e) {
      print(e);
      return Image.asset("assets/images/Pattern Success.png");
    }
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;

        });
      },
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: EdgeInsets.only(right: 15,top: 4),
        padding: EdgeInsets.all(8),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: Image.network(widget.product.images[index].src!),
      ),
    );
  }
}