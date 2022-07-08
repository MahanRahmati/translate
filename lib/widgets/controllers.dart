import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/providers.dart';
import '/screens/languages.dart';
import '/strings.dart';
import '/utils/languages.dart';
import 'swap_button.dart';

class ControllersWidget extends ConsumerWidget {
  const ControllersWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool showBlur = ref.watch(blurProvider);
    final String sourceKey = ref.watch(sourceProvider);
    final String targetKey = ref.watch(targetProvider);
    final String source = languages[sourceKey]!;
    final String target = languages[targetKey]!;
    return Container(
      color: ArnaDynamicColor.resolve(ArnaColors.headerColor, context),
      child: Row(
        children: <Widget>[
          Expanded(
            child: ArnaTextButton(
              label: source,
              onPressed: () => showArnaPopupDialog(
                context: context,
                title: Strings.source,
                builder: (BuildContext context) => const Languages(source: true),
                useBlur: showBlur,
              ),
              buttonSize: ButtonSize.huge,
            ),
          ),
          const SwapButton(),
          Expanded(
            child: ArnaTextButton(
              label: target,
              onPressed: () => showArnaPopupDialog(
                context: context,
                title: Strings.target,
                builder: (BuildContext context) => const Languages(source: false),
                useBlur: showBlur,
              ),
              buttonSize: ButtonSize.huge,
            ),
          ),
        ],
      ),
    );
  }
}
