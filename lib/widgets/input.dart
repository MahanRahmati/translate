import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/providers.dart';
import '/strings.dart';
import '/utils/debouncer.dart';
import '/utils/functions.dart';

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
      ref.read(outputProvider.notifier).state = '';
    }
    ref.read(inputProvider.notifier).state = text;
    _debouncer.run(() => translate(context, ref));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Styles.small,
      child: ArnaTextField(
        controller: controller,
        onChanged: onChanged,
        clearButtonMode: ArnaOverlayVisibilityMode.editing,
        hintText: Strings.text,
        maxLength: 5000,
        maxLines: null,
        textAlignVertical: TextAlignVertical.top,
      ),
    );
  }
}
