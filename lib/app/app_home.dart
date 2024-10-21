import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:print_script/app/utils/file_name_generator.dart';

import 'components/wrapped_code_editor.dart';
import 'components/sidebar.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey mainContainerKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        return Flex(
          direction: Axis.horizontal,
          children: [
            Flexible(flex: 2, child: AppToolBar()),
            Expanded(
              flex: 6,
              child: Container(
                color: Theme.of(context).colorScheme.secondaryContainer,
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Expanded(
                      child: Container(child: Center(
                        child: SingleChildScrollView(

                            child: CodeEditor(
                              key: mainContainerKey,
                            )),
                      ),)
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton.icon(
                            label: const Text(
                              "Made by ildeberto",
                            ),
                            icon: const Icon(FontAwesome.fire_solid),
                            onPressed: () => launchDevProfile(),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          TextButton.icon(
                              label: const Text(
                                "Github",
                              ),
                              icon: const Icon(FontAwesome.github_alt_brand),
                              onPressed: () => launchGithub()),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
