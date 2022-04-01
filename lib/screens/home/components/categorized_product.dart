import 'package:flutter/material.dart';

class CategorizedProduct extends StatelessWidget {
  final String categoryTitle;
  CategorizedProduct({required this.categoryTitle});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$categoryTitle',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "بیشتر",
                  style: TextStyle(color: Color(0xFFBBBBBB)),
                ),
              ),
            ],
          ),
        ),
        //end of popular title box
        // SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   child: Row(
        //     children: [
        //       ...List.generate(
        //         product.length,
        //             (index) {
        //           if (product[index].category == categoryTitle)
        //             return ProductCard(product: product[index]);
        //
        //           return SizedBox
        //               .shrink(); // here by default width and height is 0
        //         },
        //       ),
        //       SizedBox(width: 20),
        //     ],
        //   ),
        // )
      ],
    );
  }
}
