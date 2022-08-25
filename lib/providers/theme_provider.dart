import 'package:arna/arna.dart' show Brightness;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/utils/storage.dart';

final StateNotifierProvider<ThemeNotifier, Brightness?> themeProvider =
    StateNotifierProvider<ThemeNotifier, Brightness?>(
  (Ref ref) => ThemeNotifier(),
  name: 'ThemeProvider',
);

class ThemeNotifier extends StateNotifier<Brightness?> {
  ThemeNotifier() : super(null) {
    _initializeTheme();
  }

  final SharedStorage storage = SharedStorage.instance;

  void _initializeTheme() {
    final String? theme = storage.theme;
    switch (theme) {
      case 'dark':
        state = Brightness.dark;
        break;
      case 'light':
        state = Brightness.light;
        break;
      default:
        state = null;
        break;
    }
  }

  void setTheme(Brightness? brightness) {
    switch (brightness) {
      case Brightness.dark:
        storage.setTheme('dark');
        break;
      case Brightness.light:
        storage.setTheme('light');
        break;
      case null:
        storage.setTheme('system');
        break;
    }
    state = brightness;
  }
}
