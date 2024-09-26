
import 'dart:convert';

import 'package:print_script/app/theme/language/languages/delphi.dart';

import 'languages/ada.dart';
import 'languages/apache.dart';
import 'languages/arcade.dart';
import 'languages/arduino.dart';
import 'languages/bash.dart';
import 'languages/basic.dart';
import 'languages/brainfuck.dart';
import 'languages/clojure.dart';
import 'languages/cmake.dart';
import 'languages/coffeescript.dart';
import 'languages/cpp.dart';
import 'languages/cs.dart';
import 'languages/css.dart';
import 'languages/d.dart';
import 'languages/dart.dart';
import 'languages/diff.dart';
import 'languages/django.dart';
import 'languages/dockerfile.dart';
import 'languages/dos.dart';
import 'languages/dsconfig.dart';
import 'languages/elixir.dart';
import 'languages/erlang.dart';
import 'languages/excel.dart';
import 'languages/fortran.dart';
import 'languages/fsharp.dart';
import 'languages/go.dart';
import 'languages/gradle.dart';
import 'languages/groovy.dart';
import 'languages/haskell.dart';
import 'languages/java.dart';
import 'languages/javascript.dart';
import 'languages/julia.dart';
import 'languages/kotlin.dart';
import 'languages/livescript.dart';
import 'languages/lua.dart';
import 'languages/makefile.dart';
import 'languages/markdown.dart';
import 'languages/matlab.dart';
import 'languages/nginx.dart';
import 'languages/objectivec.dart';
import 'languages/perl.dart';
import 'languages/pgsql.dart';
import 'languages/php.dart';
import 'languages/plaintext.dart';
import 'languages/powershell.dart';
import 'languages/processing.dart';
import 'languages/properties.dart';
import 'languages/python.dart';
import 'languages/r.dart';
import 'languages/roboconf.dart';
import 'languages/ruby.dart';
import 'languages/ruleslanguage.dart';
import 'languages/rust.dart';
import 'languages/scala.dart';
import 'languages/scheme.dart';
import 'languages/scss.dart';
import 'languages/shell.dart';
import 'languages/sql.dart';
import 'languages/swift.dart';
import 'languages/typescript.dart';
import 'languages/vbnet.dart';
import 'languages/vbscript.dart';
import 'languages/xml.dart';
import 'languages/xquery.dart';
import 'languages/yaml.dart';
import 'src/mode.dart';

enum LanguageTypes {
  ada,
  apache,
  arcade,
  arduino,
  autoit,
  bash,
  basic,
  brainfuck,
  clojure,
  cmake,
  coffeescript,
  cpp,
  cs,
  css,
  d,
  dart,
  delphi,
  diff,
  django,
  dockerfile,
  dos,
  dsconfig,
  elixir,
  erlang,
  excel,
  fortran,
  fsharp,
  go,
  gradle,
  groovy,
  haskell,
  htmlbars,
  http,
  ini,
  java,
  javascript,
  json,
  julia,
  kotlin,
  lua,
  makefile,
  markdown,
  matlab,
  nginx,
  nsis,
  objectivec,
  perl,
  pgsql,
  php,
  plaintext,
  powershell,
  processing,
  properties,
  python,
  r,
  rib,
  ruby,
  ruleslanguage,
  rust,
  scala,
  scilab,
  scss,
  shell,
  sql,
  stylus,
  swift,
  typescript,
  vbnet,
  vbscriptHtml,
  vbscript,
  x86Asm,
  xml,
  xquery,
  yaml,
}

 Map<LanguageTypes, dynamic> builtinLanguagesMap = {
  LanguageTypes.ada: ada,
  LanguageTypes.apache: apache,
  LanguageTypes.arcade: arcade,
  LanguageTypes.arduino: arduino,
  LanguageTypes.bash: bash,
  LanguageTypes.basic: basic,
  LanguageTypes.brainfuck: brainfuck,
  LanguageTypes.clojure: clojure,
  LanguageTypes.cmake: cmake,
  LanguageTypes.coffeescript: coffeescript,
  LanguageTypes.cpp: cpp,
  LanguageTypes.cs: cs,
  LanguageTypes.css: css,
  LanguageTypes.d: d,
  LanguageTypes.dart: dart,
  LanguageTypes.delphi: delphi,
  LanguageTypes.diff: diff,
  LanguageTypes.django: django,
  LanguageTypes.dockerfile: dockerfile,
  LanguageTypes.dos: dos,
  LanguageTypes.dsconfig: dsconfig,
  LanguageTypes.elixir: elixir,
  LanguageTypes.erlang: erlang,
  LanguageTypes.excel: excel,
  LanguageTypes.fortran: fortran,
  LanguageTypes.fsharp: fsharp,
  LanguageTypes.go: go,
  LanguageTypes.gradle: gradle,
  LanguageTypes.groovy: groovy,
  LanguageTypes.haskell: haskell,
  LanguageTypes.java: java,
  LanguageTypes.javascript: javascript,
  LanguageTypes.json: json,
  LanguageTypes.julia: julia,
  LanguageTypes.kotlin: kotlin,
  LanguageTypes.lua: lua,
  LanguageTypes.makefile: makefile,
  LanguageTypes.markdown: markdown,
  LanguageTypes.matlab: matlab,
  LanguageTypes.nginx: nginx,
  LanguageTypes.objectivec: objectivec,
  LanguageTypes.perl: perl,
  LanguageTypes.pgsql: pgsql,
  LanguageTypes.php: php,
  LanguageTypes.plaintext: plaintext,
  LanguageTypes.powershell: powershell,
  LanguageTypes.processing: processing,
  LanguageTypes.properties: properties,
  LanguageTypes.python: python,
  LanguageTypes.r: r,
  LanguageTypes.ruby: ruby,
  LanguageTypes.ruleslanguage: ruleslanguage,
  LanguageTypes.rust: rust,
  LanguageTypes.scala: scala,
  LanguageTypes.scss: scss,
  LanguageTypes.shell: shell,
  LanguageTypes.sql: sql,
  LanguageTypes.swift: swift,
  LanguageTypes.typescript: typescript,
  LanguageTypes.vbnet: vbnet,
  LanguageTypes.vbscript: vbscript,
  LanguageTypes.xml: xml,
  LanguageTypes.xquery: xquery,
  LanguageTypes.yaml: yaml,
};

extension BuiltinLanguageTypeExtension on LanguageTypes {
  String get cleanName {
    return toString()
        .split('.')
        .last // Remove 'BuiltinLanguageType.'
        .replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(0)}')
        .trim();
  }

  Mode get languageValue {
    return builtinLanguagesMap[this];
  }
}

