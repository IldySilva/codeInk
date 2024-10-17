import 'dart:convert';

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
import 'languages/dart.dart';
import 'languages/delphi.dart';
import 'languages/django.dart';
import 'languages/dsconfig.dart';
import 'languages/elixir.dart';
import 'languages/erlang.dart';
import 'languages/fortran.dart';
import 'languages/fsharp.dart';
import 'languages/go.dart';
import 'languages/gradle.dart';
import 'languages/groovy.dart';
import 'languages/haskell.dart';
import 'languages/java.dart';
import 'languages/javascript.dart';
import 'languages/kotlin.dart';
import 'languages/lua.dart';
import 'languages/makefile.dart';
import 'languages/markdown.dart';
import 'languages/matlab.dart';
import 'languages/objectivec.dart';
import 'languages/perl.dart';
import 'languages/pgsql.dart';
import 'languages/php.dart';
import 'languages/plaintext.dart';
import 'languages/powershell.dart';
import 'languages/processing.dart';
import 'languages/python.dart';
import 'languages/r.dart';
import 'languages/ruby.dart';
import 'languages/rust.dart';
import 'languages/scala.dart';
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
import 'highlight/mode.dart';

enum LanguageTypes {
  arduino,
  bash,
  basic,
  brainfuck,
  clojure,
  cmake,
  coffeescript,
  cpp,
  cs,
  css,
  dart,
  delphi,
  django,
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
  java,
  javascript,
  json,
  kotlin,
  lua,
  makefile,
  markdown,
  matlab,
  objectivec,
  perl,
  pgsql,
  php,
  plaintext,
  powershell,
  processing,
  python,
  r,
  rib,
  ruby,
  rust,
  scala,
  scss,
  shell,
  sql,
  swift,
  typescript,
  vbnet,
  vbscriptHtml,
  vbscript,
  xml,
  xquery,
  yaml,
}

Map<LanguageTypes, dynamic> builtinLanguagesMap = {
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
  LanguageTypes.dart: dart,
  LanguageTypes.delphi: delphi,
  LanguageTypes.django: django,
  LanguageTypes.dsconfig: dsconfig,
  LanguageTypes.elixir: elixir,
  LanguageTypes.erlang: erlang,
  LanguageTypes.fortran: fortran,
  LanguageTypes.fsharp: fsharp,
  LanguageTypes.go: go,
  LanguageTypes.gradle: gradle,
  LanguageTypes.groovy: groovy,
  LanguageTypes.haskell: haskell,
  LanguageTypes.java: java,
  LanguageTypes.javascript: javascript,
  LanguageTypes.json: json,
  LanguageTypes.kotlin: kotlin,
  LanguageTypes.lua: lua,
  LanguageTypes.makefile: makefile,
  LanguageTypes.markdown: markdown,
  LanguageTypes.matlab: matlab,
  LanguageTypes.objectivec: objectivec,
  LanguageTypes.perl: perl,
  LanguageTypes.pgsql: pgsql,
  LanguageTypes.php: php,
  LanguageTypes.plaintext: plaintext,
  LanguageTypes.powershell: powershell,
  LanguageTypes.processing: processing,
  LanguageTypes.python: python,
  LanguageTypes.r: r,
  LanguageTypes.ruby: ruby,
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
        .last
        .replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(0)}')
        .trim();
  }

  Mode get languageValue {
    return builtinLanguagesMap[this];
  }
}
