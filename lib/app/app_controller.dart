import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:print_script/app/consts/const_default_gradients.dart';
import 'package:print_script/app/enums/language/enum_languages.dart';
import 'package:print_script/app/enums/editor_themes.dart';

import 'consts/const_default_code.dart';

class Controller extends ChangeNotifier {
  static final Controller _instance = Controller._internal();

  Controller._internal();

  factory Controller() {
    return _instance;
  }

  static String code = defaultCode;
  static ValueNotifier<LanguageTypes> selectedLanguage =
      ValueNotifier(LanguageTypes.javascript);
  static ValueNotifier<ThemeType> selectedTheme =
      ValueNotifier(ThemeType.dracula);

  static ValueNotifier<GradientPalette> backgroundColor =
      ValueNotifier<GradientPalette>(GradientPalette.OceanBreeze);
  static ValueNotifier<double> padding = ValueNotifier(60);
  static ValueNotifier<double> opactity = ValueNotifier(0.8);
  static ValueNotifier<bool> showLines = ValueNotifier(true);
  static ValueNotifier<double> borderRadius = ValueNotifier(20);
  static ValueNotifier<bool> exporting = ValueNotifier(false);

  setLoading(bool v) {
    exporting.value = v;
  }

  setColor(GradientPalette newColor) {
    backgroundColor.value = newColor;
    notifyListeners();
  }

  setOpactivity(double newOpactity) {
    opactity.value = newOpactity;
    notifyListeners();
  }

  setPadding(double newPaddin) {
    padding.value = newPaddin;
    notifyListeners();
  }

  setShowLines(bool v) {
    showLines.value = v;
    notifyListeners();
  }

  void setBorderRadius(double v) {
    borderRadius.value = v;
    notifyListeners();
  }

  //TODO: Reset all the config values
  void reset() {}
}
