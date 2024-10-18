import 'package:print_script/app/consts/const_default_code.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
String get generateName =>
    "SnapInk-${DateTime.now().millisecondsSinceEpoch}.png";


launchGithub()=>launcher.launchUrl(Uri.parse(githuburl));
launchDevProfile()=>launcher.launchUrl(Uri.parse("https://github.com/ildysilva"));


