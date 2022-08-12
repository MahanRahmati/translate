import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/translation.dart';
import '/providers/output_provider.dart';
import '/strings.dart';
import '/widgets/copy_button.dart';

class OutputWidget extends ConsumerWidget {
  const OutputWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Translation? translation = ref.watch(outputProvider);
    return ArnaCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: Styles.normal,
              child: translation != null
                  ? ArnaSelectableText(
                      translation.translation!,
                      style: ArnaTheme.of(context).textTheme.body,
                    )
                  : Text(
                      context.localizations.translation,
                      style: ArnaTheme.of(context).textTheme.body!.copyWith(
                            color: ArnaColors.secondaryTextColor
                                .resolveFrom(context),
                          ),
                    ),
            ),
          ),
          const ArnaDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              CopyButton(translation: translation?.translation),
            ],
          ),
        ],
      ),
    );
  }
}
