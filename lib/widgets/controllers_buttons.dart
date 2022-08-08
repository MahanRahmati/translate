import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/providers.dart';
import '/screens/languages.dart';
import '/strings.dart';
import '/utils/languages.dart';
import '/utils/storage.dart';

class ControllersButtons extends ConsumerWidget {
  const ControllersButtons({
    super.key,
    required this.top,
  });

  final bool top;

  void onSourcePressed(BuildContext context) {
    showArnaPopupDialog(
      context: context,
      title: Strings.source,
      builder: (_) => const Languages(source: true),
    );
  }

  void onSwapPressed(String sourceKey, String targetKey, WidgetRef ref) {
    final String s = sourceKey;
    final String t = targetKey;
    final SharedStorage storage = SharedStorage.instance;
    storage.setSource(t);
    storage.setTarget(s);
    ref.read(sourceProvider.notifier).state = t;
    ref.read(targetProvider.notifier).state = s;
  }

  void onTargetPressed(BuildContext context) {
    showArnaPopupDialog(
      context: context,
      title: Strings.target,
      builder: (_) => const Languages(source: false),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String sourceKey = ref.watch(sourceProvider);
    final String targetKey = ref.watch(targetProvider);
    final String source = languages[sourceKey]!;
    final String target = languages[targetKey]!;
    return top
        ? ArnaLinkedButtons(
            buttons: <ArnaLinkedButton>[
              ArnaLinkedButton(
                label: source,
                onPressed: () => onSourcePressed(context),
              ),
              ArnaLinkedButton(
                icon: Icons.compare_arrows_outlined,
                onPressed: sourceKey != 'auto'
                    ? () => onSwapPressed(sourceKey, targetKey, ref)
                    : null,
                tooltipMessage: Strings.swap,
              ),
              ArnaLinkedButton(
                label: target,
                onPressed: () => onTargetPressed(context),
              ),
            ],
          )
        : Row(
            children: <Widget>[
              Expanded(
                child: ArnaTextButton(
                  label: source,
                  onPressed: () => onSourcePressed(context),
                  buttonSize: ButtonSize.huge,
                ),
              ),
              ArnaBorderlessButton(
                icon: Icons.compare_arrows_outlined,
                onPressed: sourceKey != 'auto'
                    ? () => onSwapPressed(sourceKey, targetKey, ref)
                    : null,
                tooltipMessage: Strings.swap,
              ),
              Expanded(
                child: ArnaTextButton(
                  label: target,
                  onPressed: () => onTargetPressed(context),
                  buttonSize: ButtonSize.huge,
                ),
              ),
            ],
          );
  }
}
