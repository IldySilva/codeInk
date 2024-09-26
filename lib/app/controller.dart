import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:highlight/languages/javascript.dart' show javascript;
import 'package:print_script/app/const_default_gradients.dart';
import 'package:print_script/app/theme/enum_theme_type.dart';

import 'const_default_code.dart';

class Controller extends ChangeNotifier {
  static final Controller _instance = Controller._internal();

  Controller._internal();

  factory Controller() {
    return _instance;
  }




  static ValueNotifier<ThemeType> selectedTheme=ValueNotifier(ThemeType.dracula);
  static final textEditorController = CodeController(

      text: defaultCode, // Initial code
      language: javascript);

  static ValueNotifier<bool> showLineNumbers=ValueNotifier(true);
  static ValueNotifier<List<Color>> backgroundColor =
      ValueNotifier<List<Color>>([...gradients.first]);
  static ValueNotifier<double> padding = ValueNotifier(25);
  setColor(List<Color> newColor) {
    backgroundColor.value = newColor;
    notifyListeners();
  }

  setPadding(double newPaddin) {
    padding.value = newPaddin;
    notifyListeners();
  }
}
