import 'package:tuple/tuple.dart';

import '../../../../enums/language/languages/java.dart';
import '../../single_line_comments/parser/single_line_comments.dart';
import 'fallback.dart';

class JavaFallbackFoldableBlockParser extends FallbackFoldableBlockParser {
  JavaFallbackFoldableBlockParser()
      : super(
          singleLineCommentSequences: SingleLineComments.byMode[java] ?? [],
          importPrefixes: ['package ', 'import '],
          multilineCommentSequences: [const Tuple2('/*', '*/')],
        );
}
