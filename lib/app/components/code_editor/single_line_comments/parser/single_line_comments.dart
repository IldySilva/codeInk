import '../../../../enums/language/languages/dart.dart';
import '../../../../enums/language/languages/go.dart';
import '../../../../enums/language/languages/java.dart';
import '../../../../enums/language/languages/php.dart';
import '../../../../enums/language/languages/python.dart';
import '../../../../enums/language/languages/scala.dart';
import '../../../../enums/language/languages/vhdl.dart';
import '../../../../enums/language/highlight/mode.dart';

class SingleLineComments {
  const SingleLineComments._();

  static final byMode = <Mode, List<String>>{
    dart: [_slashes],
    go: [_slashes],
    java: [_slashes],
    php: [_slashes, _hash],
    python: [_hash],
    scala: [_slashes],
    vhdl: [_hyphenMinuses],
  };

  static const _slashes = '//';
  static const _hash = '#';
  static const _hyphenMinuses = '--';
}
