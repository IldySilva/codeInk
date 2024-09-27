import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app/theme/language/languages/all.dart';
import 'app/theme/language/src/highlight.dart';

final highlight = Highlight()..registerLanguages(allLanguages);
void main() {
  runApp( App());
}
