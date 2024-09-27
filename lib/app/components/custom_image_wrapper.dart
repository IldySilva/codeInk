import 'package:flutter/material.dart';
import 'package:print_script/app/widget_to_image_controller.dart';

class WidgetsToImageWrapper extends StatelessWidget {
  final Widget? child;
  final WidgetsToImageController controller;

  const WidgetsToImageWrapper({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: controller.containerKey,
      child: child,
    );
  }
}
