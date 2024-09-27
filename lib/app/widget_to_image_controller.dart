import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

import 'utils/file_name_generator.dart';

class WidgetsToImageController {
  final GlobalKey containerKey = GlobalKey();
  final double _pixelRatio = 4;
  Future<Uint8List?> capture() async {
    if (containerKey.currentContext == null) {
      return null;
    }

    final RenderRepaintBoundary? boundary = containerKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary?;

    if (boundary == null) {
      return null;
    }

    final ui.Image image = await boundary.toImage(pixelRatio: _pixelRatio);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData == null) {
      return null;
    }

    final pngBytes =
        await compute(_convertToBytes, byteData.buffer.asUint8List());
    await compute(save, pngBytes);
    return pngBytes;
  }

  Uint8List _convertToBytes(Uint8List byteData) {
    return byteData;
  }

  save(bytes) async {
    await FileSaver.instance.saveFile(name: generateName, bytes: bytes);
  }
}
