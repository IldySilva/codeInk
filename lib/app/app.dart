import 'package:flutter/material.dart';
import 'package:flutter_box_transform/flutter_box_transform.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/code_editor.dart';
import 'components/resizable_container.dart';
import 'components/toolbar.dart';

class App extends StatefulWidget {
  App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
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
              Flexible(flex: 2, child: CodeToolBar()),
              Flexible(
                  flex: 8,
                  child: Flex(
                    direction: Axis.vertical,
                    children: [
                      Expanded(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left:20.0,top: 10),
                                child: Text(
                                    "Turn your code into stunning prints in seconds.",
                                    style: Theme.of(context).textTheme.headlineSmall),
                              ),
                            ],
                          )),
                      Flexible(
                          flex: 8,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: CodeEditor(),
                          )),
                    ],
                  )),
            ],
          ),
        ));
  }
}
