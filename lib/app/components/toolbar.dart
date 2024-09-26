import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:print_script/app/controller.dart';
import 'package:print_script/app/theme/language/enum_languages.dart';
import 'package:print_script/app/utils/widget_to_image_controller.dart';
import '../consts/const_default_gradients.dart';
import '../utils/file_name_generator.dart';
import '../theme/enum_theme_type.dart';

class CodeToolBar extends StatelessWidget {
  CodeToolBar({super.key});
  Controller controller = Controller();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: const TextSpan(style: TextStyle(fontSize: 20), children: [
                  TextSpan(text: 'Code'),
                  TextSpan(
                      text: 'Ink',
                      style: TextStyle(fontWeight: FontWeight.bold))
                ]),
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Background",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.start,
              children: [
                for (List<Color> gradient in gradients)
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
                                gradient: LinearGradient(colors: gradient)),
                            height: 35,
                            width: 35),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(4),
                    child: Container(
                      color: Colors.transparent,
                      height: 30,
                      width: 30,
                      child: const Icon(Icons.add),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Padding",
                    style: TextStyle(fontWeight: FontWeight.bold),
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
            ValueListenableBuilder(
              builder: (context, value, _) {
                return DropdownButtonFormField2<ThemeType>(
                  decoration: const InputDecoration(
                    label: Row(children: [Text("Theme"),Icon(Icons.palette)],),
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
                      child: Text(theme.cleanName),
                    );
                  }).toList(),
                );
              },
              valueListenable: Controller.selectedTheme,
            ),
            const SizedBox(height: 20,),
            ValueListenableBuilder(
              builder: (context, value, _) {
                return DropdownButtonFormField2<LanguageTypes>(
                  decoration:  const InputDecoration(
                    label: Row(children: [Text("Language"),Icon(Icons.language)],),
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
                      .map<DropdownMenuItem<LanguageTypes>>((LanguageTypes theme) {
                    return DropdownMenuItem<LanguageTypes>(
                      value: theme,
                      child: Text(theme.cleanName),
                    );
                  }).toList(),
                );
              },
              valueListenable: Controller.selectedLanguage,
            ),
            ElevatedButton(
                onPressed: () async {
                  var bytes = await widgetsToImageController.capture();
                  await FileSaver.instance
                      .saveFile(name: generateName, bytes: bytes);
                },
                child: const Text("Export")),
          ],
        ),
      ),
    );
  }
}

WidgetsToImageController widgetsToImageController = WidgetsToImageController();
