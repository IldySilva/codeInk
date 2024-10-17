import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:print_script/app/app_theme.dart';

import 'app_home.dart';

class App extends StatelessWidget {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KodeInk',
      theme: AppTheme.themeData,
      home: HomePage(),
    );
  }
}
