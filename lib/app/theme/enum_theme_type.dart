import 'theme_map.dart';

enum ThemeType {
  a11yDark,
  a11yLight,
  agate,
  anOldHope,
  androidstudio,
  arduinoLight,
  arta,
  ascetic,
  atelierCaveDark,
  atelierCaveLight,
  atelierEstuaryLight,
  atelierForestLight,
  atelierHeathLight,
  atelierPlateauDark,
  atelierSavannaDark,
  atelierSulphurpoolDark,
  atomOneDarkReasonable,
  atomOneDark,
  atomOneLight,
  codepenEmbed,
  colorBrewer,
  darcula,
  dark,
  defaultTheme,
  docco,
  dracula,
  github,
  gml,
  googlecode,
  gradientDark,
  grayscale,
  hopscotch,
  idea,
  irBlack,
  lightfair,
  magula,
  monoBlue,
  monokaiSublime,
  monokai,
  nightOwl,
  obsidian,
  ocean,
  paraisoDark,
  pojoaque,
  purebasic,
  rainbow,
  schoolBook,
  solarizedDark,
  solarizedLight,
  tomorrowNightBlue,
  tomorrowNightBright,
  tomorrowNightEighties,
  vs,
  vs2015,
  xcode
}

extension ThemeTypeExtension on ThemeType {
  String get cleanName {
    return toString()
        .split('.')
        .last
        .replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(0)}')
        .trim();
  }

  dynamic get themeValue {
    return themeMap[this];
  }
}
