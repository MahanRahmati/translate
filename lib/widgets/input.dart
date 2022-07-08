import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/providers.dart';
import '/strings.dart';
import '/utils/debouncer.dart';
import '/utils/functions.dart';

class InputWidget extends ConsumerStatefulWidget {
  const InputWidget({super.key, required this.controller});

  final TextEditingController controller;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends ConsumerState<InputWidget> {
  final Debouncer _debouncer = Debouncer(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    final bool autoMode = ref.watch(autoProvider);
    return Padding(
      padding: Styles.small,
      child: ArnaTextField(
        controller: widget.controller,
        onSubmitted: (String text) => translate(context, widget.controller.text, ref),
        onChanged: (String text) {
          if (autoMode) {
            _debouncer.run(() => translate(context, widget.controller.text, ref));
          }
        },
        clearButtonMode: ArnaOverlayVisibilityMode.editing,
        hintText: Strings.text,
        maxLength: 5000,
        maxLines: null,
        textAlignVertical: TextAlignVertical.top,
      ),
    );
  }
}
