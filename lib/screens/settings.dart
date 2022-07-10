import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/providers.dart';
import '/strings.dart';
import '/utils/storage.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {
  final SharedStorage storage = SharedStorage.instance;

  @override
  Widget build(BuildContext context) {
    final Brightness? themeMode = ref.watch(themeProvider);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ArnaList(
            title: Strings.theme,
            showDividers: true,
            showBackground: true,
            children: <Widget>[
              ArnaRadioListTile<Brightness?>(
                value: null,
                groupValue: themeMode,
                title: Strings.system,
                onChanged: (_) async {
                  storage.setTheme(0);
                  ref.read(themeProvider.notifier).state = null;
                },
              ),
              ArnaRadioListTile<Brightness?>(
                value: Brightness.dark,
                groupValue: themeMode,
                title: Strings.dark,
                onChanged: (_) async {
                  storage.setTheme(1);
                  ref.read(themeProvider.notifier).state = Brightness.dark;
                },
              ),
              ArnaRadioListTile<Brightness?>(
                value: Brightness.light,
                groupValue: themeMode,
                title: Strings.light,
                onChanged: (_) async {
                  storage.setTheme(2);
                  ref.read(themeProvider.notifier).state = Brightness.light;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
