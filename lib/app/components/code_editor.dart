import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:print_script/app/controller.dart';

import 'package:print_script/app/components/toolbar.dart';
import 'package:print_script/app/widget_to_image_wrapper.dart';
import 'package:flutter_highlight/themes/dracula.dart';

class CodeEditor extends StatefulWidget {
  CodeEditor({super.key});

  @override
  State<CodeEditor> createState() => _CodeEditorState();
}

class _CodeEditorState extends State<CodeEditor> {
  double? containerWidth;

  double? containerHeight;
  ValueNotifier<double>dragAreaSize = ValueNotifier(100);
  ValueNotifier<bool>resizing = ValueNotifier(false);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: containerWidth,
      child: WidgetsToImageWrapper(
        controller: widgetsToImageController,
        child: ListenableBuilder(
          builder: (context, value) {
            return Container(
              padding: EdgeInsets.all(Controller.padding.value),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: Controller.backgroundColor.value)),
              child: Flexible(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CodeTheme(
                          data: CodeThemeData(styles: draculaTheme),
                          child: CodeField(
                            wrap: true,
                            gutterStyle: GutterStyle(
                                showFoldingHandles: false,
                                showErrors: false,
                                showLineNumbers:
                                    Controller.showLineNumbers.value),
                            controller: Controller.textEditorController,
                          )),
                    ),
                    Positioned(
                     right: 1,
                      top: 0.7,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.resizeLeft,
                        onHover: (v){
                          resizing.value=true;
                        },
                        onExit: (v){
                          resizing.value=false;

                        },
                        child: GestureDetector(

                          onPanUpdate: (details) {
                            if (containerWidth == null) {
                              final box = (widget.key as GlobalKey)
                                  .currentContext!
                                  .findRenderObject() as RenderBox;
                              print("Nova Altura da caixa");
                              print(box.size.width);
                              print(box.size.height);
                              containerHeight = box.size.height;
                              containerWidth = box.size.width;
                            }

                            setState(() {
                              if (containerWidth != null && containerHeight != null) {
                                containerWidth = containerWidth! + details.delta.dx;
                                dragAreaSize.value+=details.delta.dy;
                              }
                            });
                          },
                          child: ValueListenableBuilder(
                            builder: (context,onHover,_) {
                              return AnimatedContainer(
                                  duration:const Duration(milliseconds: 200),
                                  decoration: BoxDecoration(
                                    color: onHover? Theme.of(context).primaryColor:Colors.transparent,

                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(10),bottomLeft: Radius.circular(10)),
                                  ),
                                  width: 10,
                                  height: 400
                              );
                            }, valueListenable: resizing,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          listenable: Controller(),
        ),
      ),
    );
  }
}
