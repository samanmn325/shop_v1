import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class bannerSlider extends StatelessWidget {
  final List<String> imgPath;
  bannerSlider(this.imgPath);
  @override
  Widget build(BuildContext context) {
    if (imgPath.length > 0)
      return Container(
        height: 160,
        margin: EdgeInsets.only(top: 15, bottom: 5),
        child: CarouselSlider(
          options: CarouselOptions(
            height: 160.0,
          ),
          items: imgPath.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                        width: 500,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: NetworkImage(i), fit: BoxFit.fill),
                        )));
              },
            );
          }).toList(),
        ),
      );
    else {
      return Container();
    }
  }
}
/*
Container(
        height: 150,
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                '$imgPath',
              ),
              fit: BoxFit.cover

          ),
          color: Color(0xFF4A3298),
          borderRadius: BorderRadius.circular(20),
        ),

      ),
   */