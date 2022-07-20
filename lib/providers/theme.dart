import 'package:arna/arna.dart' show Brightness;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/utils/storage.dart';

final StateNotifierProvider<ThemeNotifier, Brightness?> themeProvider =
    StateNotifierProvider<ThemeNotifier, Brightness?>(
  (StateNotifierProviderRef<ThemeNotifier, Brightness?> ref) => ThemeNotifier(),
);

class ThemeNotifier extends StateNotifier<Brightness?> {
  ThemeNotifier() : super(null) {
    _initializeTheme();
  }

  void _initializeTheme() {
    final SharedStorage storage = SharedStorage.instance;
    final String? theme = storage.theme;
    state = null;
    if (theme == 'dark') {
      state = Brightness.dark;
    } else if (theme == 'light') {
      state = Brightness.light;
    }
  }

  void setTheme(Brightness? brightness) {
    final SharedStorage storage = SharedStorage.instance;
    if (brightness == null) {
      storage.setTheme('system');
    } else if (brightness == Brightness.dark) {
      storage.setTheme('dark');
    } else if (brightness == Brightness.light) {
      storage.setTheme('light');
    }
    state = brightness;
  }
}
