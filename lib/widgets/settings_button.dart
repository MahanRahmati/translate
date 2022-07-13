import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/screens/settings.dart';
import '/strings.dart';
import '/widgets/about_button.dart';

class SettingsButton extends ConsumerWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ArnaIconButton(
      icon: Icons.settings_outlined,
      onPressed: () => showArnaPopupDialog(
        context: context,
        title: Strings.settings,
        actions: const <Widget>[
          AboutButton(),
        ],
        builder: (BuildContext context) => const Settings(),
      ),
      tooltipMessage: Strings.settings,
    );
  }
}
