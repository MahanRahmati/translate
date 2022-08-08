import 'package:arna/arna.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class Strings {
  static const String appName = 'Arna Translate';
  static const String version = '2.0.5';
}

extension Localization on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this)!;
}
