import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/providers.dart';
import '/strings.dart';

class Settings extends ConsumerWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Brightness? themeMode = ref.watch(themeProvider);
    final bool autoMode = ref.watch(autoProvider);
    final bool blurMode = ref.watch(blurProvider);
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
                onChanged: (_) => ref.read(themeProvider.notifier).state = null,
              ),
              ArnaRadioListTile<Brightness?>(
                value: Brightness.dark,
                groupValue: themeMode,
                title: Strings.dark,
                onChanged: (_) => ref.read(themeProvider.notifier).state = Brightness.dark,
              ),
              ArnaRadioListTile<Brightness?>(
                value: Brightness.light,
                groupValue: themeMode,
                title: Strings.light,
                onChanged: (_) => ref.read(themeProvider.notifier).state = Brightness.light,
              ),
            ],
          ),
          ArnaList(
            title: Strings.options,
            showDividers: true,
            showBackground: true,
            children: <Widget>[
              ArnaSwitchListTile(
                value: autoMode,
                title: Strings.auto,
                onChanged: (_) => ref.read(autoProvider.notifier).state = !autoMode,
              ),
              ArnaSwitchListTile(
                value: blurMode,
                title: Strings.blurMode,
                onChanged: (_) => ref.read(blurProvider.notifier).state = !blurMode,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
