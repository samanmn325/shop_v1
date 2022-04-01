import 'models/cart.dart';
import 'models/category.dart';
import 'models/product.dart';
import 'package:flutter/material.dart';

List<Category> categories=[
  Category(title: 'موبایل', iconPath: 'assets/icons/Game Icon.svg'),
  Category(title: 'لوازم تزئیناتی', iconPath: 'assets/icons/Gift Icon.svg'),
  Category(title: 'شرکتی و اداری', iconPath: 'assets/icons/Flash Icon.svg'),
  Category(title: 'لوازم خانگی', iconPath: 'assets/icons/Bill Icon.svg'),
];

List<Product>  product=[
  Product(
    id: 1,
    title:'دسته پلی استیشن ۴',
    price:260000,
    oldPrice:295000,
    count:2,
    imgPath:[
      "assets/images/ps4_console_white_1.png",
      "assets/images/ps4_console_white_2.png",
      "assets/images/ps4_console_white_3.png",
      "assets/images/ps4_console_white_4.png",
    ],
    isPopular: true,
    category: 'لوازم جانبی',
      isFavourite: true,
    description: descript,
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
  ),
  Product(
      id: 2,
      title:'محصول دوم',
      price:1250000,
      oldPrice:1420000,
      count:4,
      imgPath:['assets/images/Image Popular Product 2.png'],
      category: 'لوازم جانبی',
      isFavourite: false,
    description: descript,
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
  ),
  Product(
    id: 3,
    title: "دستکش های ورزشی پلیگان",
    imgPath: ["assets/images/glap.png"],
    count: 2,
    oldPrice: 0,
    price: 36000,
    //description: description,
    //rating: 4.1,
    isPopular: true,
      category: 'لوازم جانبی',
    isFavourite: true,
    description: descript,
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
  ),
  Product(
    id: 4,
    title: "هدفون بی سیم سونی",
    imgPath: ["assets/images/wireless headset.png"],
    count: 1,
    oldPrice: 0,
    price: 128000,
    //description: description,
    //rating: 4.1,
    isPopular: true,
      category: 'لوازم جانبی',
      isFavourite: false,
    description: descript,
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
  )
];
List<Cart> demoCarts = [
  Cart(product: product[0], numOfItem: 2),
  Cart(product: product[1], numOfItem: 1),
  Cart(product: product[3], numOfItem: 1),
];
const String descript ="  لورم ایپسوم یا طرح‌نما (به انگلیسی: Lorem ipsum) به متنی آزمایشی و بی‌معنی در صنعت چاپ، صفحه‌آرایی و طراحی گرافیک گفته می‌شود.";