// import 'language_syntax/brackets_counting.dart';
import '../../../language/languages/dart.dart';
import '../../../language/languages/go.dart';
import '../../../language/languages/java.dart';
import '../../../language/languages/python.dart';
import '../../../language/languages/scala.dart';
import '../../../language/src/mode.dart';
import 'language_syntax/golang_syntax.dart';
import 'language_syntax/java_dart_syntax.dart';
import 'language_syntax/python_syntax.dart';
import 'language_syntax/scala_syntax.dart';

Map<int, String> getErrorsMap(String text, Mode? language) {
  Map<int, String> errors = {};

  // This check is temporarily disabled because unclosed ' and "
  // characters in comments cause false positive errors
  // errors.addAll(countingBrackets(text));

  if (language == java || language == dart) {
    errors.addAll(findJavaDartErrors(text));
  } else if (language == go) {
    errors.addAll(findGolangErrors(text));
  } else if (language == python) {
    errors.addAll(findPythonErrorTabs(text));
  } else if (language == scala) {
    errors.addAll(findScalaErrors(text));
  }

  return errors;
}
