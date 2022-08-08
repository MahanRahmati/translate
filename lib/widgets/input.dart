import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/providers/input_provider.dart';
import '/strings.dart';
import '/utils/debouncer.dart';

class InputWidget extends ConsumerStatefulWidget {
  const InputWidget({
    super.key,
    required this.input,
  });

  final String input;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends ConsumerState<InputWidget> {
  final Debouncer _debouncer = Debouncer(milliseconds: 1000);
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.input;
    super.initState();
  }

  void onChanged(String text) {
    if (text.isEmpty) {
      ref.read(inputProvider.notifier).state = text;
    } else {
      _debouncer.run(() => ref.read(inputProvider.notifier).state = text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Styles.small,
      child: ArnaTextField(
        controller: controller,
        onChanged: onChanged,
        clearButtonMode: ArnaOverlayVisibilityMode.editing,
        hintText: context.localizations.text,
        maxLength: 5000,
        maxLines: null,
        textAlignVertical: TextAlignVertical.top,
      ),
    );
  }
}
