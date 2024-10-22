import 'package:flutter/material.dart';

class ColoredCircleButtons extends StatelessWidget {
  const ColoredCircleButtons({super.key});

  final redColor = const Color(0xffff5f57);
  final yellowColor = const Color(0xfffebc2e);
  final greenColor = const Color(0xff28c840);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildCircle(redColor),
        buildCircle(yellowColor),
        buildCircle(greenColor),
      ],
    );
  }

  Widget buildCircle(Color color) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: 15,
      height: 15,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
