import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  final GestureTapCallback press;
  final String title;
  final List<Widget> children;
  Section({
    required this.title ,
    required this.children ,
    required this.press,
});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //title Row Start
      Padding(
        padding: const EdgeInsets.only( left: 14.0, right: 14.0),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          GestureDetector(
            onTap: press,
            child: Text(
              "بیشتر",
              style: TextStyle(color: Color(0xFFBBBBBB)),
            ),
          ),
        ],
    ),
      ),
        //title Row Ends
        Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Wrap(
                spacing: 24.0,
                children: children,
              ),
            ),
          ),
        )
      ],
    );
  }
}
