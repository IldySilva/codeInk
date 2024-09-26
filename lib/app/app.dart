import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
sliderTheme: SliderThemeData(overlayShape: SliderComponentShape.noThumb),

             inputDecorationTheme: InputDecorationTheme(

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
          textTheme: GoogleFonts.poppinsTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent,brightness: Brightness.dark),
        ),
        home: Scaffold(
          body: Flex(
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(flex: 2, child: CodeToolBar()),
              Flexible(
                  flex: 8,
                  child: Flex(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                    Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white)),
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
