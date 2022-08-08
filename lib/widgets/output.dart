import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/translation.dart';
import '/providers/output_provider.dart';
import '/strings.dart';

class OutputWidget extends ConsumerWidget {
  const OutputWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Translation?> translation = ref.watch(outputProvider);

    return ArnaCard(
      child: translation.when(
        loading: () => const Center(child: ArnaProgressIndicator()),
        error: (Object err, StackTrace? stack) => Text('Error: $err'),
        data: (Translation? t) {
          return t != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: Styles.normal,
                        child: t.translation!.isEmpty
                            ? Text(
                                context.localizations.translation,
                                style: ArnaTheme.of(context)
                                    .textTheme
                                    .body!
                                    .copyWith(
                                      color: ArnaColors.secondaryTextColor
                                          .resolveFrom(context),
                                    ),
                              )
                            : ArnaSelectableText(
                                t.translation!,
                                style: ArnaTheme.of(context).textTheme.body,
                              ),
                      ),
                    ),
                    const ArnaDivider(),
                    Row(
                      children: <Widget>[
                        const Spacer(),
                        ArnaIconButton(
                          icon: Icons.copy_outlined,
                          onPressed: (t.translation!) != null &&
                                  t.translation!.isNotEmpty
                              ? () {
                                  ArnaHelpers.copyToClipboard(
                                    t.translation!,
                                  );
                                  showArnaSnackbar(
                                    context: context,
                                    message: context.localizations.copyToast,
                                  );
                                }
                              : null,
                          tooltipMessage: context.localizations.copy,
                        ),
                      ],
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: Styles.normal,
                        child: Text(
                          context.localizations.translation,
                          style: ArnaTheme.of(context).textTheme.body!.copyWith(
                                color: ArnaColors.secondaryTextColor
                                    .resolveFrom(context),
                              ),
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
