import '../../../../enums/language/languages/java.dart';
import '../../../../enums/language/languages/python.dart';
import '../../../../enums/language/highlight/mode.dart';
import 'abstract.dart';
import 'highlight.dart';
import 'java.dart';
import 'python.dart';

class FoldableBlockParserFactory {
  static AbstractFoldableBlockParser provideParser(Mode mode) {
    if (mode == python) {
      return PythonFoldableBlockParser();
    }
    if (mode == java) {
      return JavaFoldableBlockParser();
    }
    return HighlightFoldableBlockParser();
  }
}
