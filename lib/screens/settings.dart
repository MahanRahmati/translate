import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/providers/instance_provider.dart';
import '/providers/theme_provider.dart';
import '/strings.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {
  final TextEditingController textController = TextEditingController();
  bool editing = false;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Brightness? themeMode = ref.watch(themeProvider);
    final String instance = ref.watch(instanceProvider);
    final bool useInstance = instance == 'lingva.ml';
    textController.text = useInstance ? '' : instance;
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
              value: !useInstance,
              onChanged: (bool use) {
                if (use) {
                  ref.read(instanceProvider.notifier).setInstance('');
                } else {
                  ref.read(instanceProvider.notifier).setInstance('lingva.ml');
                }
              },
              title: context.localizations.customInstance,
            ),
            AnimatedContainer(
              height: !useInstance ? Styles.base * 7 : 0,
              duration: Styles.basicDuration,
              curve: Styles.basicCurve,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ArnaTextField(
                      controller: textController,
                    ),
                  ),
                  if (!editing)
                    ArnaIconButton(
                      icon: Icons.check_outlined,
                      onPressed: () async {
                        setState(() {
                          editing = !editing;
                        });
                        if (editing) {
                          await ref
                              .read(instanceProvider.notifier)
                              .checkInstance(textController.text);
                          setState(() {
                            editing = !editing;
                          });
                        }
                      },
                      tooltipMessage: 'Check URL',
                    ),
                  if (editing) const ArnaProgressIndicator(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
