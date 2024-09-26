import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:print_script/app/consts/const_default_gradients.dart';
import 'package:print_script/app/theme/enum_theme_type.dart';
import 'package:print_script/app/theme/language/enum_languages.dart';

import 'consts/const_default_code.dart';
import 'theme/code_editor/flutter_code_editor.dart';

class Controller extends ChangeNotifier {
  static final Controller _instance = Controller._internal();

  Controller._internal();

  factory Controller() {
    return _instance;
  }


  static String code=defaultCode;
  static ValueNotifier<LanguageTypes> selectedLanguage =
      ValueNotifier(LanguageTypes.sql);
  static ValueNotifier<ThemeType> selectedTheme =
      ValueNotifier(ThemeType.dracula);

  static ValueNotifier<bool> showLineNumbers = ValueNotifier(true);
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
