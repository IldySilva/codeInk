import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/widgets.dart';

enum EditorFont {
  firaCode,
  sourceCodePro,
  poppins,
  robotoMono,
  inconsolata,
  ubuntuMono,
  jetBrainsMono,
  anonymousPro,
  shareTechMono,
  spaceMono,
  cousine,
  ptMono,
  overpassMono,
  dmMono,
  cutiveMono,
  oxygenMono,
  ibmPlexMono,
  redHatMono,
  monoton,
  monofett,
  asul,
  courierPrime,
  lekton,
  pressStart2P,
  novaMono,
  syneMono,
  righteous,
  amaticSc,
  alata,
}

extension CodingFontExtension on EditorFont {
  TextStyle getTextStyle({double fontSize = 14}) {
    switch (this) {
      case EditorFont.firaCode:
        return GoogleFonts.firaCode(fontSize: fontSize);
      case EditorFont.sourceCodePro:
        return GoogleFonts.sourceCodePro(fontSize: fontSize);
      case EditorFont.robotoMono:
        return GoogleFonts.robotoMono(fontSize: fontSize);
      case EditorFont.inconsolata:
        return GoogleFonts.inconsolata(fontSize: fontSize);
      case EditorFont.ubuntuMono:
        return GoogleFonts.ubuntuMono(fontSize: fontSize);
      case EditorFont.jetBrainsMono:
        return GoogleFonts.jetBrainsMono(fontSize: fontSize);
      case EditorFont.anonymousPro:
        return GoogleFonts.anonymousPro(fontSize: fontSize);
      case EditorFont.shareTechMono:
        return GoogleFonts.shareTechMono(fontSize: fontSize);
      case EditorFont.spaceMono:
        return GoogleFonts.spaceMono(fontSize: fontSize);
      case EditorFont.cousine:
        return GoogleFonts.cousine(fontSize: fontSize);
      case EditorFont.ptMono:
        return GoogleFonts.ptMono(fontSize: fontSize);
      case EditorFont.overpassMono:
        return GoogleFonts.overpassMono(fontSize: fontSize);
      case EditorFont.dmMono:
        return GoogleFonts.dmMono(fontSize: fontSize);
      case EditorFont.cutiveMono:
        return GoogleFonts.cutiveMono(fontSize: fontSize);
      case EditorFont.oxygenMono:
        return GoogleFonts.oxygenMono(fontSize: fontSize);
      case EditorFont.ibmPlexMono:
        return GoogleFonts.ibmPlexMono(fontSize: fontSize);
      case EditorFont.redHatMono:
        return GoogleFonts.redHatMono(fontSize: fontSize);
      case EditorFont.monoton:
        return GoogleFonts.monoton(fontSize: fontSize);
      case EditorFont.monofett:
        return GoogleFonts.monofett(fontSize: fontSize);
      case EditorFont.asul:
        return GoogleFonts.asul(fontSize: fontSize);
      case EditorFont.courierPrime:
        return GoogleFonts.courierPrime(fontSize: fontSize);
      case EditorFont.lekton:
        return GoogleFonts.lekton(fontSize: fontSize);
      case EditorFont.pressStart2P:
        return GoogleFonts.pressStart2p(fontSize: fontSize);
      case EditorFont.novaMono:
        return GoogleFonts.novaMono(fontSize: fontSize);
      case EditorFont.syneMono:
        return GoogleFonts.syneMono(fontSize: fontSize);
      case EditorFont.righteous:
        return GoogleFonts.righteous(fontSize: fontSize);
      case EditorFont.amaticSc:
        return GoogleFonts.amaticSc(fontSize: fontSize);
      case EditorFont.alata:
        return GoogleFonts.alata(fontSize: fontSize);
      case EditorFont.poppins:
        return GoogleFonts.poppins(fontSize: fontSize);

      }
  }
  String get cleanName {
    switch (this) {
      case EditorFont.firaCode:
        return "Fira Code";
      case EditorFont.sourceCodePro:
        return "Source Code Pro";
      case EditorFont.robotoMono:
        return "Roboto Mono";
      case EditorFont.inconsolata:
        return "Inconsolata";
      case EditorFont.ubuntuMono:
        return "Ubuntu Mono";
      case EditorFont.jetBrainsMono:
        return "JetBrains Mono";
      case EditorFont.anonymousPro:
        return "Anonymous Pro";
      case EditorFont.shareTechMono:
        return "Share Tech Mono";
      case EditorFont.spaceMono:
        return "Space Mono";
      case EditorFont.cousine:
        return "Cousine";
      case EditorFont.ptMono:
        return "PT Mono";
      case EditorFont.overpassMono:
        return "Overpass Mono";
      case EditorFont.dmMono:
        return "DM Mono";
      case EditorFont.cutiveMono:
        return "Cutive Mono";
      case EditorFont.oxygenMono:
        return "Oxygen Mono";
      case EditorFont.ibmPlexMono:
        return "IBM Plex Mono";
      case EditorFont.redHatMono:
        return "Red Hat Mono";
      case EditorFont.monofett:
        return "Monofett";
      case EditorFont.asul:
        return "Asul";
      case EditorFont.courierPrime:
        return "Courier Prime";
      case EditorFont.lekton:
        return "Lekton";
      case EditorFont.pressStart2P:
        return "Press Start 2P";
      case EditorFont.novaMono:
        return "Nova Mono";
      case EditorFont.syneMono:
        return "Syne Mono";
      case EditorFont.righteous:
        return "Righteous";

      case EditorFont.amaticSc:
        return "Amatic SC";
      case EditorFont.alata:
        return "Alata";

      case EditorFont.poppins:
        return 'Poppins';
      case EditorFont.monoton:
        return 'Monoton';
    }
  }
}
