import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/providers.dart';
import '/strings.dart';
import '/utils/storage.dart';

class SwapButton extends ConsumerStatefulWidget {
  const SwapButton({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SwapButtonState();
}

class _SwapButtonState extends ConsumerState<SwapButton> {
  final SharedStorage storage = SharedStorage.instance;

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
              storage.setSource(t);
              storage.setTarget(s);
              ref.read(sourceProvider.notifier).state = t;
              ref.read(targetProvider.notifier).state = s;
            }
          : null,
      tooltipMessage: Strings.swap,
    );
  }
}
