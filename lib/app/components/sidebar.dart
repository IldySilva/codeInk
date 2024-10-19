import 'package:flutter/material.dart';
import 'package:print_script/app/app_controller.dart';
import 'package:print_script/app/enums/language/enum_languages.dart';
import 'package:print_script/app/enums/editor_themes.dart';
import 'package:print_script/app/widget_to_image_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../consts/const_default_gradients.dart';
import '../enums/fonts.dart';

class AppToolBar extends StatelessWidget {
  AppToolBar({super.key});
  final Controller _controller = Controller();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 16, left: 8),
              child: Row(
                children: [
                  Image.asset("assets/getink_icon.png",scale: 12,),
                  SizedBox(width: 8,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('SnapInk',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,fontSize: 20)),
                      Text("Take a beautiful snap of your code")
                    ],
                  ),
                ],
              ),
            ),
            Flex(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              direction: Axis.horizontal,
              children: [
                Text("Background"),
                ValueListenableBuilder(
                  builder: (context, value, _) {
                    return Flexible(
                      child: ShadSelect<GradientPalette>(
                        initialValue: value,
                        onChanged: (GradientPalette? newValue) {
                          _controller.setColor(newValue!);
                        },
                        selectedOptionBuilder: (context, value) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                value.cleanName,
                                style: const TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                          colors: value.gradient)),
                                  height: 16,
                                  width: 50),
                            ],
                          );
                        },
                        options: GradientPalette.values.map((e) => ShadOption(
                              value: e,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    e.cleanName,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                              colors: e.gradient)),
                                      height: 16,
                                      width: 16),
                                ],
                              ),
                            )),
                      ),
                    );
                  },
                  valueListenable: Controller.backgroundColor,
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (GradientPalette gradient
                    in GradientPalette.values.getRange(0, 8))
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, bottom: 8, right: 8),
                    child: InkWell(
                      onTap: () {
                        _controller.setColor(gradient);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Container(
                            decoration: BoxDecoration(
                                gradient:
                                    LinearGradient(colors: gradient.gradient)),
                            height: 18,
                            width: 18),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Theme"),
                ValueListenableBuilder(
                  builder: (context, value, _) {
                    return Flexible(
                        child: ShadSelect<ThemeType>(
                      initialValue: value,
                      onChanged: (ThemeType? newValue) {
                        Controller().setTheme(newValue!);
                      },
                      selectedOptionBuilder: (context, value) {
                        return Text(
                          value.cleanName,
                          style: const TextStyle(color: Colors.white),
                        );
                      },
                      options: ThemeType.values.map((e) => ShadOption(
                            value: e,
                            child: Text(
                              e.cleanName,
                              style: const TextStyle(color: Colors.white),
                            ),
                          )),
                    ));
                  },
                  valueListenable: Controller.selectedTheme,
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Language"),
                ValueListenableBuilder(
                  builder: (context, value, _) {
                    return Flexible(
                        child: ShadSelect<LanguageTypes>(
                      initialValue: value,
                      onChanged: (LanguageTypes? newValue) {
                        Controller.selectedLanguage.value = newValue!;
                        Controller.selectedTheme.notifyListeners();
                      },
                      selectedOptionBuilder: (context, value) {
                        return Text(
                          value.cleanName,
                          style: const TextStyle(color: Colors.white),
                        );
                      },
                      options: LanguageTypes.values.map((e) => ShadOption(
                            value: e,
                            child: Text(
                              e.cleanName,
                              style: const TextStyle(color: Colors.white),
                            ),
                          )),
                    ));
                  },
                  valueListenable: Controller.selectedLanguage,
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Font"),
                ValueListenableBuilder(
                  builder: (context, value, _) {
                    return Flexible(
                        child: ShadSelect<EditorFont>(
                          initialValue: value,
                          onChanged: (EditorFont? newValue) {

                            Controller().setFont=newValue!;

                          },
                          selectedOptionBuilder: (context, value) {
                            return Text(
                              value.cleanName,
                              style: const TextStyle(color: Colors.white),
                            );
                          },
                          options: EditorFont.values.map((e) => ShadOption(
                            value: e,
                            child: Text(
                              e.cleanName,
                              style: const TextStyle(color: Colors.white),
                            ),
                          )),
                        ));
                  },
                  valueListenable: Controller.selectedFont,
                ),
              ],
            ),
            ValueListenableBuilder(
              builder: (context, value, _) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Line numbers",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      ShadSwitch(
                        value: value,
                        onChanged: (v) {
                          _controller.setShowLines(v);
                        },
                      )
                    ],
                  ),
                );
              },
              valueListenable: Controller.showLines,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Padding",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  ValueListenableBuilder(
                    builder: (context, value, _) {
                      return ShadSlider(
                          min: 0,
                          max: 100,
                          controller: ShadSliderController(initialValue: value),
                          onChanged: (v) {
                            _controller.setPadding(v);
                          });
                    },
                    valueListenable: Controller.padding,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Opacity",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  ValueListenableBuilder(
                    builder: (context, value, _) {
                      return ShadSlider(
                          min: 0.6,
                          max: 1,
                          controller: ShadSliderController(initialValue: value),
                          onChanged: (v) {
                            _controller.setOpactivity(v);
                          });
                    },
                    valueListenable: Controller.opactity,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Flex(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                direction: Axis.horizontal,
                children: [
                  Flexible(
                    child: const Text(
                      "Roundness",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  ValueListenableBuilder(
                    builder: (context, value, _) {
                      return ShadSlider(
                          min: 0,
                          max: 100,
                          controller: ShadSliderController(initialValue: value),
                          onChanged: (v) => _controller.setBorderRadius(v));
                    },
                    valueListenable: Controller.borderRadius,
                  )
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShadButton(
                  child: ValueListenableBuilder(
                    builder: (context, value, _) {
                      if (value)
                        return Center(child: LinearProgressIndicator());
                      return Text(
                        "Export image",
                      );
                    },
                    valueListenable: Controller.exporting,
                  ),
                  onPressed: () async {
                    Controller().setLoading(true);
                    await widgetsToImageController.capture();
                    Controller().setLoading(false);
                  },
                ),
                ShadButton.secondary(
                  onPressed: () {
                    Controller().reset();
                  },
                  child: Text(
                    "Reset",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

WidgetsToImageController widgetsToImageController = WidgetsToImageController();
