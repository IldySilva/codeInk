import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:print_script/app/app_controller.dart';
import 'package:print_script/app/enums/language/enum_languages.dart';
import 'package:print_script/app/enums/editor_themes.dart';
import 'package:print_script/app/widget_to_image_controller.dart';
import '../consts/const_default_gradients.dart';

class CodeToolBar extends StatelessWidget {
  CodeToolBar({super.key});
  final Controller controller = Controller();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: const TextSpan(
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    children: [
                      TextSpan(text: 'Code'),
                      TextSpan(
                          text: 'Ink',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ]),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ValueListenableBuilder(
              builder: (context, value, _) {
                return DropdownButtonFormField2<GradientPalette>(
                  decoration: const InputDecoration(
                    labelText: 'Background',
                  ),
                  isExpanded: true,
                  value: value,
                  onChanged: (GradientPalette? newValue) {
                    controller.setColor(newValue!);
                  },
                  items: GradientPalette.values
                      .map<DropdownMenuItem<GradientPalette>>(
                          (GradientPalette theme) {
                    return DropdownMenuItem<GradientPalette>(
                      value: theme,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            theme.cleanName,
                            style: const TextStyle(color: Colors.white),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient:
                                      LinearGradient(colors: theme.gradient)),
                              height: 16,
                              width: 16),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
              valueListenable: Controller.backgroundColor,
            ),
            const SizedBox(
              height: 16,
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.start,
              children: [
                for (GradientPalette gradient
                    in GradientPalette.values.getRange(0, 8))
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                    child: InkWell(
                      onTap: () {
                        controller.setColor(gradient);
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
            ValueListenableBuilder(
              builder: (context, value, _) {
                return DropdownButtonFormField2<ThemeType>(
                  decoration: const InputDecoration(
                    labelText: "Theme",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                  ),
                  isExpanded: true,
                  value: value,
                  onChanged: (ThemeType? newValue) {
                    Controller.selectedTheme.value = newValue!;
                  },
                  items: ThemeType.values
                      .map<DropdownMenuItem<ThemeType>>((ThemeType theme) {
                    return DropdownMenuItem<ThemeType>(
                      value: theme,
                      child: Text(theme.cleanName,
                          style: const TextStyle(color: Colors.white)),
                    );
                  }).toList(),
                );
              },
              valueListenable: Controller.selectedTheme,
            ),
            const SizedBox(
              height: 20,
            ),
            ValueListenableBuilder(
              builder: (context, value, _) {
                return DropdownButtonFormField2<LanguageTypes>(
                  decoration: const InputDecoration(
                    labelText: "Language",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                  ),
                  isExpanded: true,
                  value: value,
                  onChanged: (LanguageTypes? newValue) {
                    Controller.selectedLanguage.value = newValue!;
                    Controller.selectedTheme.notifyListeners();
                  },
                  items: LanguageTypes.values
                      .map<DropdownMenuItem<LanguageTypes>>(
                          (LanguageTypes theme) {
                    return DropdownMenuItem<LanguageTypes>(
                      value: theme,
                      child: Text(
                        theme.cleanName,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                );
              },
              valueListenable: Controller.selectedLanguage,
            ),
            ValueListenableBuilder(
              builder: (context, value, _) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Line numbers",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Switch(
                          value: value,
                          onChanged: (v) => controller.setShowLines(v))
                    ],
                  ),
                );
              },
              valueListenable: Controller.showLines,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
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
                      return Slider.adaptive(
                          min: 0,
                          max: 100,
                          value: value,
                          onChanged: (v) {
                            controller.setPadding(v);
                          });
                    },
                    valueListenable: Controller.padding,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
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
                      return Slider.adaptive(
                          min: 0.6,
                          max: 1,
                          value: value,
                          onChanged: (v) {
                            controller.setOpactivity(v);
                          });
                    },
                    valueListenable: Controller.opactity,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
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
                      return Slider.adaptive(
                          min: 0,
                          max: 100,
                          value: value,
                          onChanged: (v) => controller.setBorderRadius(v));
                    },
                    valueListenable: Controller.borderRadius,
                  )
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: () async {
                      Controller().setLoading(true);
                      await widgetsToImageController.capture();
                      Controller().setLoading(false);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ValueListenableBuilder(
                        builder: (context, value, _) {
                          if (value)
                            return Center(child: LinearProgressIndicator());
                          return Text(
                            "Export image",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          );
                        },
                        valueListenable: Controller.exporting,
                      ),
                    )),
                MaterialButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: () async {
                      Controller().reset();
                      ;
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Reset",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).colorScheme.primaryContainer),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

WidgetsToImageController widgetsToImageController = WidgetsToImageController();
