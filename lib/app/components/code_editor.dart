import 'package:flutter/material.dart';
import 'package:flutter_box_transform/flutter_box_transform.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:print_script/app/controller.dart';

import 'package:print_script/app/components/toolbar.dart';
import 'package:print_script/app/widget_to_image_wrapper.dart';
import 'package:flutter_highlight/themes/dracula.dart';


class CodeEditor extends StatelessWidget {
  CodeEditor({super.key});

  @override
  Widget build(BuildContext context) {

    return WidgetsToImageWrapper(
      controller: widgetsToImageController,
      child: ListenableBuilder(
        builder: (context, value) {
          return Container(
            padding: EdgeInsets.all(Controller.padding.value),
            decoration: BoxDecoration(
                gradient:
                LinearGradient(colors: Controller.backgroundColor.value)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CodeTheme(
                  data: CodeThemeData(styles: draculaTheme),
                  child: CodeField(
expands: true,
                    gutterStyle: GutterStyle(
                        background: Colors.transparent,
                        showFoldingHandles: false,
                        showErrors: false,
                        showLineNumbers: Controller.showLineNumbers.value),
                    controller: Controller.textEditorController,
                  )),
            ),
          );
        },
        listenable: Controller(),
      ),
    );
  }
}
