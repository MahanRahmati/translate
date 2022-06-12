import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/providers.dart';
import '/screens/languages.dart';
import '/strings.dart';
import '/utils/languages.dart';

class ControllersButtons extends ConsumerStatefulWidget {
  const ControllersButtons({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ControllersButtonsState();
}

class _ControllersButtonsState extends ConsumerState<ControllersButtons> {
  late SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async => preferences = await SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    final bool showBlur = ref.watch(blurProvider);
    final String sourceKey = ref.watch(sourceProvider);
    final String targetKey = ref.watch(targetProvider);
    final String source = languages[sourceKey]!;
    final String target = languages[targetKey]!;
    return ArnaLinkedButtons(
      buttons: <ArnaLinkedButton>[
        ArnaLinkedButton(
          label: source,
          onPressed: () => showArnaPopupDialog(
            context: context,
            title: Strings.source,
            builder: (BuildContext context) => const Languages(source: true),
            useBlur: showBlur,
          ),
        ),
        ArnaLinkedButton(
          icon: Icons.compare_arrows_outlined,
          onPressed: sourceKey != 'auto'
              ? () async {
                  final String s = sourceKey;
                  final String t = targetKey;
                  preferences.setString('source', t);
                  preferences.setString('target', s);
                  ref.read(sourceProvider.notifier).state = t;
                  ref.read(targetProvider.notifier).state = s;
                }
              : null,
          tooltipMessage: Strings.swap,
        ),
        ArnaLinkedButton(
          label: target,
          onPressed: () => showArnaPopupDialog(
            context: context,
            title: Strings.target,
            builder: (BuildContext context) => const Languages(source: false),
            useBlur: showBlur,
          ),
        ),
      ],
    );
  }
}
