import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/providers/input_provider.dart';
import '/strings.dart';
import '/utils/debouncer.dart';

class InputWidget extends ConsumerWidget {
  const InputWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: Styles.small,
      child: ArnaTextField(
        controller: TextEditingController(text: ref.read(inputProvider)),
        onChanged: (String text) {
          if (text.isEmpty) {
            ref.read(inputProvider.notifier).state = text;
          } else {
            final Debouncer debouncer = Debouncer(milliseconds: 1500);
            debouncer.run(() => ref.read(inputProvider.notifier).state = text);
          }
        },
        clearButtonMode: ArnaOverlayVisibilityMode.editing,
        hintText: context.localizations.text,
        maxLength: 5000,
        maxLines: null,
        textAlignVertical: TextAlignVertical.top,
      ),
    );
  }
}
