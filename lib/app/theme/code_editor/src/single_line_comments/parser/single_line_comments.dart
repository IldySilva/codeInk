import '../../../../language/languages/dart.dart';
import '../../../../language/languages/go.dart';
import '../../../../language/languages/java.dart';
import '../../../../language/languages/php.dart';
import '../../../../language/languages/python.dart';
import '../../../../language/languages/scala.dart';
import '../../../../language/languages/vhdl.dart';
import '../../../../language/src/mode.dart';

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
