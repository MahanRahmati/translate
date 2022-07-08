import 'package:arna/arna.dart';
import 'package:flutter/services.dart' show SystemChrome, SystemUiOverlayStyle;

void updateSystemUIOverlayStyle(BuildContext context) {
  Brightness? systemNavigationBarIconBrightness;
  switch (ArnaTheme.of(context).brightness) {
    case Brightness.dark:
      systemNavigationBarIconBrightness = Brightness.light;
      break;
    case Brightness.light:
      systemNavigationBarIconBrightness = Brightness.dark;
      break;
    case null:
      systemNavigationBarIconBrightness = null;
      break;
  }
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: ArnaDynamicColor.resolve(ArnaColors.backgroundColor, context),
      systemNavigationBarIconBrightness: systemNavigationBarIconBrightness,
      systemNavigationBarDividerColor: ArnaColors.transparent,
    ),
  );
}
