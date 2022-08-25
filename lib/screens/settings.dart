import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/providers/instance_provider.dart';
import '/providers/theme_provider.dart';
import '/providers/use_instance_provider.dart';
import '/strings.dart';

class Settings extends ConsumerWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Brightness? themeMode = ref.watch(themeProvider);
    final bool useInstance = ref.watch(useInstanceProvider);
    final String? instance = ref.watch(instanceProvider);
    return ListView(
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
        ArnaList(
          title: context.localizations.instance,
          showDividers: useInstance,
          showBackground: true,
          children: <Widget>[
            ArnaSwitchListTile(
              value: useInstance,
              onChanged: (bool use) {
                ref.read(useInstanceProvider.notifier).useInstance(
                      useInstance: use,
                    );
              },
              title: context.localizations.customInstance,
            ),
            AnimatedContainer(
              height: useInstance ? Styles.base * 7 : 0,
              duration: Styles.basicDuration,
              curve: Styles.basicCurve,
              child: ArnaTextField(
                controller: TextEditingController(
                  text: useInstance ? instance : null,
                ),
                onChanged: ref.read(instanceProvider.notifier).setInstance,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
