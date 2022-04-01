import 'package:flutter/material.dart';

class Product {
final String title;
final int price;
final int oldPrice;
final int count;
final List<String> imgPath;
final int id;
final bool isPopular;
final String category;
final bool isFavourite;
final String description;
final List<Color> colors;

Product({
 required this.id,
 required this.title,
  required this.price,
   this.oldPrice = 0,
  required this.count,
  required this.imgPath,
 this.isPopular = false,
 required this.category,
 this.isFavourite =false,
 this.description = '',
 this.colors=const [Colors.white],

});

}


