import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/providers.dart';
import '/strings.dart';

class OutputWidget extends ConsumerWidget {
  const OutputWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? outputText = ref.watch(outputProvider);
    return ArnaCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: outputText == null
                ? const Center(child: ArnaProgressIndicator())
                : Padding(
                    padding: Styles.normal,
                    child: outputText.isEmpty
                        ? Text(
                            Strings.translation,
                            style: ArnaTheme.of(context).textTheme.body!.copyWith(
                                  color: ArnaDynamicColor.resolve(ArnaColors.secondaryTextColor, context),
                                ),
                          )
                        : ArnaSelectableText(outputText, style: ArnaTheme.of(context).textTheme.body),
                  ),
          ),
          const ArnaDivider(),
          Row(
            children: <Widget>[
              const Spacer(),
              ArnaIconButton(
                icon: Icons.copy_outlined,
                onPressed: outputText != null && outputText.isNotEmpty
                    ? () {
                        copyToClipboard(outputText);
                        showArnaSnackbar(context: context, message: Strings.copyToast);
                      }
                    : null,
                tooltipMessage: Strings.copy,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
