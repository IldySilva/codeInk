
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/code_editor.dart';
import 'components/toolbar.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'CodInk',
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: Scaffold(
          body: Flex(
            direction: Axis.horizontal,
            children: [

              Flexible(
                  flex: 2,
                  child: CodeToolBar()),

              Flexible(
                flex: 8,
                child: SingleChildScrollView(
                  child: Column(children: [

                    const Text(
                      'Transform your code into stunning visuals. Drop your code or start typing to create code snippets in seconds.',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CodeEditor(),
                    ),

                  ],),
                ),),

            ],
          ),
        ));
  }
}
