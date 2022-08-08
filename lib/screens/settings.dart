import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/providers/theme_provider.dart';
import '/strings.dart';

class Settings extends ConsumerWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Brightness? themeMode = ref.watch(themeProvider);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ArnaList(
            title: context.localizations.theme,
            showDividers: true,
            showBackground: true,
            children: <Widget>[
              ArnaRadioListTile<Brightness?>(
                value: null,
                groupValue: themeMode,
                title: context.localizations.system,
                onChanged: (_) {
                  ref.read(themeProvider.notifier).setTheme(null);
                },
              ),
              ArnaRadioListTile<Brightness?>(
                value: Brightness.dark,
                groupValue: themeMode,
                title: context.localizations.dark,
                onChanged: (_) {
                  ref.read(themeProvider.notifier).setTheme(Brightness.dark);
                },
              ),
              ArnaRadioListTile<Brightness?>(
                value: Brightness.light,
                groupValue: themeMode,
                title: context.localizations.light,
                onChanged: (_) {
                  ref.read(themeProvider.notifier).setTheme(Brightness.light);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
