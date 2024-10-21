import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:print_script/app/enums/fonts.dart';

import 'app/app.dart';
import 'app/enums/language/languages/all.dart';
import 'app/enums/language/highlight/highlight.dart';

final highlight = Highlight()..registerLanguages(languages);
void main() async {

await WidgetsFlutterBinding.ensureInitialized();
await GoogleFonts.pendingFonts([...EditorFont.values.map((e)=>e.getTextStyle())]);
  runApp(App());
}
