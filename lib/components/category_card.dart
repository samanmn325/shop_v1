import '../screens/drawer/drawer.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    this.icon = "",
    required this.text,
    required this.press,
  });

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
          width: 130,
          child: Container(
            padding: EdgeInsets.only(top: 2),
            height: 80,
            width: 130,
            decoration: BoxDecoration(
              color: Color(0xFFFFECDF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isNullContainer(icon),
                  SizedBox(height: 5),
                  Text(text, textAlign: TextAlign.center)
                ]),
          )),
    );
  }
}

isNullContainer(String icon) {
  if (icon == "") {
    return Container(
        // height: 30,
        // width: 30,

        );
  } else
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: NetworkImage(icon),
      )),
    );
}

class DrawerCategoryCard extends StatelessWidget {
  DrawerCategoryCard({
    required this.text,
    required this.press,
  });

  final String? text;
  final GestureTapCallback? press;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          height: 1,
          endIndent: 100,
          indent: 10,
          thickness: 1,
        ),
        RoundedMenuItem(
          text: text!,
          press: press,
        ),
      ],
    );
  }
}
