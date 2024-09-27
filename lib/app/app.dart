import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

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
          sliderTheme:
              SliderThemeData(overlayShape: SliderComponentShape.noThumb),
          inputDecorationTheme: InputDecorationTheme(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
          textTheme: GoogleFonts.poppinsTextTheme(),
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurpleAccent, brightness: Brightness.dark),
        ),
        home: Scaffold(
          body: Flex(
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(flex: 2, child: CodeToolBar()),
              Expanded(
                  flex: 6,
                  child: Flex(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    direction: Axis.vertical,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 20),
                        child: Text(
                            "Turn your code into stunning prints in seconds.",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: Colors.white)),
                      ),
                      Expanded(
                        child: Center(
                          child: SingleChildScrollView(
                              child: CodeEditor(
                            key: mainContainerKey,
                          )),
                        ),
                      ),
                      AppBar(
                        backgroundColor: Colors.transparent,
                        primary: false,
                        title: Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton.icon(
                                label: const Text(
                                  "Made by ildeberto",
                                ),
                                icon: const Icon(FontAwesome.fire_solid),
                                onPressed: () {},
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              TextButton.icon(
                                label: const Text(
                                  "Github",
                                ),
                                icon: const Icon(FontAwesome.github_alt_brand),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ));
  }
}
