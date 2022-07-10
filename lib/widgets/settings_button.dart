import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/screens/settings.dart';
import '/strings.dart';

class SettingsButton extends ConsumerWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ArnaIconButton(
      icon: Icons.settings_outlined,
      onPressed: () => showArnaPopupDialog(
        context: context,
        title: Strings.settings,
        builder: (BuildContext context) => const Settings(),
      ),
      tooltipMessage: Strings.settings,
    );
  }
}
