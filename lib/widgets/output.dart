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
    final AsyncValue<Translation?> translation = ref.watch(outputProvider);
    return ArnaCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: translation.when(
              loading: () => const Center(child: ArnaProgressIndicator()),
              error: (Object err, StackTrace? stack) {
                return Padding(
                  padding: Styles.normal,
                  child: Text(
                    context.localizations.error,
                    style: ArnaTheme.of(context).textTheme.body!.copyWith(
                          color: ArnaColors.secondaryTextColor
                              .resolveFrom(context),
                        ),
                  ),
                );
              },
              data: (Translation? t) {
                return translation.isLoading
                    ? const Center(child: ArnaProgressIndicator())
                    : Padding(
                        padding: Styles.normal,
                        child: t != null
                            ? ArnaSelectableText(
                                t.translation!,
                                style: ArnaTheme.of(context).textTheme.body,
                              )
                            : Text(
                                context.localizations.translation,
                                style: ArnaTheme.of(context)
                                    .textTheme
                                    .body!
                                    .copyWith(
                                      color: ArnaColors.secondaryTextColor
                                          .resolveFrom(context),
                                    ),
                              ),
                      );
              },
            ),
          ),
          const ArnaDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              CopyButton(translation: translation.value?.translation),
            ],
          ),
        ],
      ),
    );
  }
}
