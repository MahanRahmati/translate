import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/providers.dart';
import '/strings.dart';
import '/utils/debouncer.dart';
import '/utils/functions.dart';

class InputWidget extends ConsumerStatefulWidget {
  const InputWidget({required this.placeholder, super.key});
  final String placeholder;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends ConsumerState<InputWidget> {
  final Debouncer _debouncer = Debouncer(milliseconds: 1000);
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    controller.text = widget.placeholder;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //controller.text = ref.watch(inputProvider);
    return Padding(
      padding: Styles.small,
      child: ArnaTextField(
        controller: controller,
        onSubmitted: (String text) {
          ref.read(inputProvider.notifier).state = text;
          translate(context, ref);
        },
        onChanged: (String text) {
          if (text.isEmpty) {
            ref.read(outputProvider.notifier).state = '';
          } else {
            ref.read(inputProvider.notifier).state = text;
          }
          _debouncer.run(() {
            translate(context, ref);
          });
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
