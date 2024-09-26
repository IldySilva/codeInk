import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:print_script/app/components/resizable_container.dart';

import 'components/code_editor.dart';
import 'components/toolbar.dart';

class App extends StatefulWidget {
  App({super.key});

  @override
  State<App> createState() => _AppState();
}


class _AppState extends State<App> {

  GlobalKey mainContainerKey = GlobalKey();

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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 10),
                            child: Text(
                                "Turn your code into stunning prints in seconds.",
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                          ),
                        ],
                      )),
                      Flexible(
                          flex: 8,
                          child: SingleChildScrollView(
                              child: CodeEditor(
                                key: mainContainerKey,
                              ))),
                    ],
                  )),
            ],
          ),
        ));
  }
}
