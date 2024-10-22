import 'package:flutter/material.dart';
import 'package:print_script/app/components/code_editor/window_header/components/colored_circle_buttons.dart';

class WindowHeader extends StatelessWidget {
  const WindowHeader({super.key});

  final windowSize = 50.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: windowSize,
      color: Colors.black.withOpacity(0.09),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ColoredCircleButtons(),
          ],
        ),
      ),
    );
  }
}
