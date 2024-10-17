import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app/enums/language/languages/all.dart';
import 'app/enums/language/highlight/highlight.dart';

final highlight = Highlight()..registerLanguages(languages);
void main() {
  runApp(App());
}
