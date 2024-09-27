import 'package:flutter/material.dart';
import 'package:print_script/app/consts/const_default_gradients.dart';
import 'package:print_script/app/controller.dart';

import 'package:print_script/app/components/custom_side_tool_bar.dart';
import 'package:print_script/app/theme/enum_theme_type.dart';
import 'package:print_script/app/components/custom_image_wrapper.dart';
import 'package:print_script/app/theme/language/enum_languages.dart';

import '../theme/code_editor/flutter_code_editor.dart';

class CodeEditor extends StatefulWidget {
  CodeEditor({super.key});

  @override
  State<CodeEditor> createState() => _CodeEditorState();
}

class _CodeEditorState extends State<CodeEditor> {
  ValueNotifier<double?> containerWidth = ValueNotifier(null);

  double? containerHeight;
  ValueNotifier<double> dragAreaSize = ValueNotifier(100);
  ValueNotifier<bool> resizing = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (context, value, _) {
        return SizedBox(
          width: containerWidth.value,
          child: WidgetsToImageWrapper(
            controller: widgetsToImageController,
            child: ListenableBuilder(
              builder: (context, value) {
                return AnimatedContainer(
                  padding: EdgeInsets.all(Controller.padding.value),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: Controller.backgroundColor.value.gradient)),
                  duration: const Duration(milliseconds: 400),
                  child: Flexible(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                              Controller.borderRadius.value),
                          child: ValueListenableBuilder(
                            builder: (context, theme, _) {
                              return CodeTheme(
                                  data: CodeThemeData(styles: theme.themeValue),
                                  child: AnimatedOpacity(
                                    opacity: Controller.opactity.value,
                                    duration: const Duration(milliseconds: 300),
                                    child: Builder(builder: (context) {
                                      return CodeField(
                                          onChanged: (x) => Controller.code = x,
                                          wrap: true,
                                          gutterStyle: GutterStyle(
                                              showFoldingHandles: false,
                                              showErrors: false,
                                              showLineNumbers:
                                                  Controller.showLines.value),
                                          controller: CodeController(
                                              text: Controller.code,
                                              language: Controller
                                                  .selectedLanguage
                                                  .value
                                                  .languageValue));
                                    }),
                                  ));
                            },
                            valueListenable: Controller.selectedTheme,
                          ),
                        ),
                        Positioned(
                          right: 1,
                          top: 0.7,
                          child: MouseRegion(
                            cursor: SystemMouseCursors.resizeLeft,
                            onHover: (v) {
                              resizing.value = true;
                            },
                            onExit: (v) {
                              resizing.value = false;
                            },
                            child: GestureDetector(
                              onPanUpdate: (details) {
                                if (containerWidth.value == null) {
                                  final box = (widget.key as GlobalKey)
                                      .currentContext!
                                      .findRenderObject() as RenderBox;
                                  containerWidth.value = box.size.width;
                                }

                                if (containerWidth.value != null) {
                                  containerWidth.value =
                                      containerWidth.value! + details.delta.dx;
                                  dragAreaSize.value += details.delta.dy;
                                }
                              },
                              child: ValueListenableBuilder(
                                builder: (context, onHover, _) {
                                  return AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      decoration: BoxDecoration(
                                        color: onHover
                                            ? Theme.of(context)
                                                .colorScheme
                                                .onPrimaryContainer
                                            : Colors.transparent,
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10)),
                                      ),
                                      width: 10,
                                      height: 400);
                                },
                                valueListenable: resizing,
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
      },
      valueListenable: containerWidth,
    );
  }
}
