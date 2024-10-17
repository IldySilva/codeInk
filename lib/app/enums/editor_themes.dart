import '../components/code_editor/code_theme/themes/a11y-dark.dart';
import '../components/code_editor/code_theme/themes/a11y-light.dart';
import '../components/code_editor/code_theme/themes/agate.dart';
import '../components/code_editor/code_theme/themes/an-old-hope.dart';
import '../components/code_editor/code_theme/themes/androidstudio.dart';
import '../components/code_editor/code_theme/themes/arduino-light.dart';
import '../components/code_editor/code_theme/themes/arta.dart';
import '../components/code_editor/code_theme/themes/ascetic.dart';
import '../components/code_editor/code_theme/themes/atelier-cave-dark.dart';
import '../components/code_editor/code_theme/themes/atelier-cave-light.dart';
import '../components/code_editor/code_theme/themes/atelier-estuary-light.dart';
import '../components/code_editor/code_theme/themes/atelier-forest-light.dart';
import '../components/code_editor/code_theme/themes/atelier-heath-light.dart';
import '../components/code_editor/code_theme/themes/atelier-plateau-dark.dart';
import '../components/code_editor/code_theme/themes/atelier-savanna-dark.dart';
import '../components/code_editor/code_theme/themes/atelier-sulphurpool-dark.dart';
import '../components/code_editor/code_theme/themes/atom-one-dark-reasonable.dart';
import '../components/code_editor/code_theme/themes/atom-one-dark.dart';
import '../components/code_editor/code_theme/themes/atom-one-light.dart';
import '../components/code_editor/code_theme/themes/codepen-embed.dart';
import '../components/code_editor/code_theme/themes/color-brewer.dart';
import '../components/code_editor/code_theme/themes/darcula.dart';
import '../components/code_editor/code_theme/themes/dark.dart';
import '../components/code_editor/code_theme/themes/default.dart';
import '../components/code_editor/code_theme/themes/docco.dart';
import '../components/code_editor/code_theme/themes/dracula.dart';
import '../components/code_editor/code_theme/themes/github.dart';
import '../components/code_editor/code_theme/themes/gml.dart';
import '../components/code_editor/code_theme/themes/googlecode.dart';
import '../components/code_editor/code_theme/themes/gradient-dark.dart';
import '../components/code_editor/code_theme/themes/grayscale.dart';
import '../components/code_editor/code_theme/themes/hopscotch.dart';
import '../components/code_editor/code_theme/themes/idea.dart';
import '../components/code_editor/code_theme/themes/ir-black.dart';
import '../components/code_editor/code_theme/themes/lightfair.dart';
import '../components/code_editor/code_theme/themes/magula.dart';
import '../components/code_editor/code_theme/themes/mono-blue.dart';
import '../components/code_editor/code_theme/themes/monokai-sublime.dart';
import '../components/code_editor/code_theme/themes/monokai.dart';
import '../components/code_editor/code_theme/themes/night-owl.dart';
import '../components/code_editor/code_theme/themes/obsidian.dart';
import '../components/code_editor/code_theme/themes/ocean.dart';
import '../components/code_editor/code_theme/themes/paraiso-dark.dart';
import '../components/code_editor/code_theme/themes/pojoaque.dart';
import '../components/code_editor/code_theme/themes/purebasic.dart';
import '../components/code_editor/code_theme/themes/rainbow.dart';
import '../components/code_editor/code_theme/themes/school-book.dart';
import '../components/code_editor/code_theme/themes/solarized-dark.dart';
import '../components/code_editor/code_theme/themes/solarized-light.dart';
import '../components/code_editor/code_theme/themes/tomorrow-night-blue.dart';
import '../components/code_editor/code_theme/themes/tomorrow-night-bright.dart';
import '../components/code_editor/code_theme/themes/tomorrow-night-eighties.dart';
import '../components/code_editor/code_theme/themes/vs.dart';
import '../components/code_editor/code_theme/themes/xcode.dart';

const Map<ThemeType, dynamic> themeMap = {
  ThemeType.a11yDark: a11yDarkTheme,
  ThemeType.a11yLight: a11yLightTheme,
  ThemeType.agate: agateTheme,
  ThemeType.anOldHope: anOldHopeTheme,
  ThemeType.androidstudio: androidstudioTheme,
  ThemeType.arduinoLight: arduinoLightTheme,
  ThemeType.arta: artaTheme,
  ThemeType.ascetic: asceticTheme,
  ThemeType.atelierCaveDark: atelierCaveDarkTheme,
  ThemeType.atelierCaveLight: atelierCaveLightTheme,
  ThemeType.atelierEstuaryLight: atelierEstuaryLightTheme,
  ThemeType.atelierForestLight: atelierForestLightTheme,
  ThemeType.atelierHeathLight: atelierHeathLightTheme,
  ThemeType.atelierPlateauDark: atelierPlateauDarkTheme,
  ThemeType.atelierSavannaDark: atelierSavannaDarkTheme,
  ThemeType.atelierSulphurpoolDark: atelierSulphurpoolDarkTheme,
  ThemeType.atomOneDarkReasonable: atomOneDarkReasonableTheme,
  ThemeType.atomOneDark: atomOneDarkTheme,
  ThemeType.atomOneLight: atomOneLightTheme,
  ThemeType.codepenEmbed: codepenEmbedTheme,
  ThemeType.colorBrewer: colorBrewerTheme,
  ThemeType.darcula: darculaTheme,
  ThemeType.dark: darkTheme,
  ThemeType.defaultTheme: defaultTheme,
  ThemeType.docco: doccoTheme,
  ThemeType.dracula: draculaTheme,
  ThemeType.github: githubTheme,
  ThemeType.gml: gmlTheme,
  ThemeType.googlecode: googlecodeTheme,
  ThemeType.gradientDark: gradientDarkTheme,
  ThemeType.grayscale: grayscaleTheme,
  ThemeType.hopscotch: hopscotchTheme,
  ThemeType.idea: ideaTheme,
  ThemeType.irBlack: irBlackTheme,
  ThemeType.lightfair: lightfairTheme,
  ThemeType.magula: magulaTheme,
  ThemeType.monoBlue: monoBlueTheme,
  ThemeType.monokaiSublime: monokaiSublimeTheme,
  ThemeType.monokai: monokaiTheme,
  ThemeType.nightOwl: nightOwlTheme,
  ThemeType.obsidian: obsidianTheme,
  ThemeType.ocean: oceanTheme,
  ThemeType.paraisoDark: paraisoDarkTheme,
  ThemeType.pojoaque: pojoaqueTheme,
  ThemeType.purebasic: purebasicTheme,
  ThemeType.rainbow: rainbowTheme,
  ThemeType.schoolBook: schoolBookTheme,
  ThemeType.solarizedDark: solarizedDarkTheme,
  ThemeType.solarizedLight: solarizedLightTheme,
  ThemeType.tomorrowNightBlue: tomorrowNightBlueTheme,
  ThemeType.tomorrowNightBright: tomorrowNightBrightTheme,
  ThemeType.tomorrowNightEighties: tomorrowNightEightiesTheme,
  ThemeType.vs: vsTheme,
  ThemeType.xcode: xcodeTheme
};

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
