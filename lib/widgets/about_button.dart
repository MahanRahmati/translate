import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/providers.dart';
import '/strings.dart';

class AboutButton extends ConsumerWidget {
  const AboutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool showBlur = ref.watch(blurProvider);
    return ArnaIconButton(
      icon: Icons.info_outlined,
      onPressed: () => showArnaAboutDialog(
        context: context,
        applicationIcon: Image.asset(
          'assets/images/AppIcon.png',
          height: Styles.base * 30,
          width: Styles.base * 30,
        ),
        applicationName: Strings.appName,
        developerName: 'Mahan Rahmati',
        applicationVersion: Strings.version,
        applicationUri: Uri(scheme: 'https', host: 'github.com', path: 'MahanRahmati/translate/issues'),
        useBlur: showBlur,
      ),
      tooltipMessage: Strings.about,
    );
  }
}
