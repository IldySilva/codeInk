
import 'package:flutter/material.dart';

final gradients = [
  // 0. White
  [Colors.white, Colors.white],

  // 1. Sunset
  [const Color(0xFFD7B8FF), const Color(0xFFD7B8FF)],

  // 2. Ocean Breeze
  [const Color(0xFF00B4DB), const Color(0xFF0083B0)],

  // 3. Peachy
  [const Color(0xFFFF9A8B), const Color(0xFFFF6A88), const Color(0xFFFF99AC)],

  // 4. Cool Blues
  [const Color(0xFF2193B0), const Color(0xFF6DD5ED)],

  // 5. Purple Haze
  [const Color(0xFF9D50BB), const Color(0xFF6E48AA)],

  // 6. Pink Dream
  [const Color(0xFFF857A6), const Color(0xFFFF5858)],

  // 7. Emerald Water
  [const Color(0xFF348F50), const Color(0xFF56B4D3)],

  // 8. Citrus
  [const Color(0xFFFDC830), const Color(0xFFF37335)],

  // 9. Light Green Tea
  [const Color(0xFF96E6A1), const Color(0xFFD4FC79)],

  // 10. Cherry Blossom
  [const Color(0xFFFFC3A0), const Color(0xFFFFAFBD)],

  // 11. Space Violet
  [const Color(0xFF4776E6), const Color(0xFF8E54E9)],

  // 12. Aqua Splash
  [const Color(0xFF13547A), const Color(0xFF80D0C7)],

  // 13. Mystic Sunset
  [const Color(0xFFFC5C7D), const Color(0xFF6A82FB)],

  // 14. Warm Flame
  [const Color(0xFFFF9A9E), const Color(0xFFFAD0C4)],

  // 15. Frozen Dreams
  [const Color(0xFF00C6FF), const Color(0xFF0072FF)],

  // 16. Deep Sea
  [const Color(0xFF00C9FF), const Color(0xFF92FE9D)],

  // 17. Neon Life
  [const Color(0xFFB3FFAB), const Color(0xFF12FFF7)],

  // 18. Burning Sunrise
  [const Color(0xFFF2994A), const Color(0xFFF2C94C)],

  // 19. Electric Violet
  [const Color(0xFF833AB4), const Color(0xFFFF4081)],

  // 20. Mono Red
  [const Color(0xFFFF3E3E), const Color(0xFFFF6363)],

  // 21. Mono Blue
  [const Color(0xFF3E50FF), const Color(0xFF637CFF)],

  // 22. Mono Green
  [const Color(0xFF3EFF6A), const Color(0xFF63FFA1)],

  // 23. Mono Purple
  [const Color(0xFFA63EFF), const Color(0xFFC563FF)],

  // 24. Mono Yellow
  [const Color(0xFFFFF23E), const Color(0xFFFFF563)],

  // 25. Mono Gray
  [const Color(0xFF828282), const Color(0xFFB0B0B0)],

  // 26. Mono Teal
  [const Color(0xFF3EFFDF), const Color(0xFF63FFEC)],

  // 27. Mono Orange
  [const Color(0xFFFF7F3E), const Color(0xFFFFA263)],

  // 28. Smoky Mountain
  [const Color(0xFF434343), const Color(0xFF1F1F1F)],
];

enum GradientPalette {
  White,
  Sunset,
  OceanBreeze,
  Peachy,
  CoolBlues,
  PurpleHaze,
  PinkDream,
  EmeraldWater,
  Citrus,
  LightGreenTea,
  CherryBlossom,
  SpaceViolet,
  AquaSplash,
  MysticSunset,
  WarmFlame,
  FrozenDreams,
  DeepSea,
  NeonLife,
  BurningSunrise,
  ElectricViolet,
  MonoRed,
  MonoBlue,
  MonoGreen,
  MonoPurple,
  MonoYellow,
  MonoGray,
  MonoTeal,
  MonoOrange,
  SmokyMountain,
}

extension GradientPaletteExtension on GradientPalette {
  String get cleanName {
    switch (this) {
      case GradientPalette.White:
        return "White";
      case GradientPalette.Sunset:
        return "Sunset";
      case GradientPalette.OceanBreeze:
        return "Ocean Breeze";
      case GradientPalette.Peachy:
        return "Peachy";
      case GradientPalette.CoolBlues:
        return "Cool Blues";
      case GradientPalette.PurpleHaze:
        return "Purple Haze";
      case GradientPalette.PinkDream:
        return "Pink Dream";
      case GradientPalette.EmeraldWater:
        return "Emerald Water";
      case GradientPalette.Citrus:
        return "Citrus";
      case GradientPalette.LightGreenTea:
        return "Light Green Tea";
      case GradientPalette.CherryBlossom:
        return "Cherry Blossom";
      case GradientPalette.SpaceViolet:
        return "Space Violet";
      case GradientPalette.AquaSplash:
        return "Aqua Splash";
      case GradientPalette.MysticSunset:
        return "Mystic Sunset";
      case GradientPalette.WarmFlame:
        return "Warm Flame";
      case GradientPalette.FrozenDreams:
        return "Frozen Dreams";
      case GradientPalette.DeepSea:
        return "Deep Sea";
      case GradientPalette.NeonLife:
        return "Neon Life";
      case GradientPalette.BurningSunrise:
        return "Burning Sunrise";
      case GradientPalette.ElectricViolet:
        return "Electric Violet";
      case GradientPalette.MonoRed:
        return "Mono Red";
      case GradientPalette.MonoBlue:
        return "Mono Blue";
      case GradientPalette.MonoGreen:
        return "Mono Green";
      case GradientPalette.MonoPurple:
        return "Mono Purple";
      case GradientPalette.MonoYellow:
        return "Mono Yellow";
      case GradientPalette.MonoGray:
        return "Mono Gray";
      case GradientPalette.MonoTeal:
        return "Mono Teal";
      case GradientPalette.MonoOrange:
        return "Mono Orange";

      case GradientPalette.SmokyMountain:
        return "Smoky Mountain";
    }
  }

  List<Color> get gradient {
    return gradients[index];
  }
}
