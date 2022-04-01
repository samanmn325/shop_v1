import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSurffixIcon extends StatelessWidget {
  final String svgIcon;
  final Color color;
  CustomSurffixIcon({
    required this.svgIcon,
    this.color = Colors.black54,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 20, 20),
      child: SvgPicture.asset(
        svgIcon,
        height: 18,
        color: color,
      ),
    );
  }
}
