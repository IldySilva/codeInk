import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:print_script/app/controller.dart';

import 'package:print_script/app/components/toolbar.dart';
import 'package:print_script/app/widget_to_image_wrapper.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';

class CodeEditor extends StatelessWidget {
  CodeEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: WidgetsToImageWrapper(
        controller: widgetsToImageController,
        child: ListenableBuilder(
          builder: (context,value) {
            return Container(
            
              decoration:  BoxDecoration(gradient: LinearGradient(colors: Controller.backgroundColor.value)),
              child: Padding(
                padding:  EdgeInsets.all(Controller.padding.value),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CodeTheme(
                      data: CodeThemeData(styles: atomOneDarkTheme),
                      child: CodeField(
                        wrap: true,
                        controller: Controller.textEditorController,
                      )),
                ),
              ),
            );
          }, listenable: Controller(),
        ),
      ),
    );
  }
}
