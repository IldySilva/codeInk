import 'package:flutter/material.dart';

class WindowHeader extends StatelessWidget {
  const WindowHeader({super.key});

  final backgroundColor = const Color(0xff262626);
  final windowSize = 50.0;
  final redColor = const Color(0xffff5f57);
  final yellowColor = const Color(0xfffebc2e);
  final greenColor = const Color(0xff28c840);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: windowSize,
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildCircle(redColor),
                buildCircle(yellowColor),
                buildCircle(greenColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Círculo preenchido com cor
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
