import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/providers.dart';
import '/strings.dart';

class SwapButton extends ConsumerStatefulWidget {
  const SwapButton({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SwapButtonState();
}

class _SwapButtonState extends ConsumerState<SwapButton> {
  late SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async => preferences = await SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    final String sourceKey = ref.watch(sourceProvider);
    final String targetKey = ref.watch(targetProvider);
    return ArnaIconButton(
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
    );
  }
}
