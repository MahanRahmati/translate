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
  final Color backgroundColor = ArnaColors.backgroundColor.resolveFrom(context);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: backgroundColor,
      systemNavigationBarIconBrightness: systemNavigationBarIconBrightness,
      systemNavigationBarDividerColor: ArnaColors.transparent,
    ),
  );
}
