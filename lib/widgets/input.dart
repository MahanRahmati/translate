import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/providers/input_provider.dart';
import '/strings.dart';

class InputWidget extends ConsumerWidget {
  const InputWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: Styles.small,
      child: ArnaTextField(
        controller: TextEditingController(text: ref.read(inputProvider)),
        onChanged: (String text) {
          ref.read(inputProvider.notifier).updateInput(text);
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
