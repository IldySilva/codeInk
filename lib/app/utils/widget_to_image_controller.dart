import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

class WidgetsToImageController {
  GlobalKey containerKey = GlobalKey();
  Future<Uint8List?> capture({
    double pixelRatio = 6,
  }) async {
    try {
      RenderRepaintBoundary? boundary = containerKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary?;

      final image = await boundary!.toImage(pixelRatio: pixelRatio);

      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData?.buffer.asUint8List();
      return pngBytes;
    } catch (e) {
      rethrow;
    }
  }
}