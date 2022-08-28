import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/providers/instance_provider.dart';
import '/strings.dart';

class CustomInstanceWidget extends ConsumerStatefulWidget {
  const CustomInstanceWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InstanceState();
}

class _InstanceState extends ConsumerState<CustomInstanceWidget> {
  final TextEditingController textController = TextEditingController();
  bool editing = false;
  bool hasError = false;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String instance = ref.watch(instanceProvider);
    final bool useInstance = instance != 'lingva.ml';
    return ArnaList(
      title: context.localizations.instance,
      showDividers: useInstance,
      showBackground: true,
      children: <Widget>[
        ArnaSwitchListTile(
          value: useInstance,
          onChanged: (bool use) {
            textController.text = useInstance ? instance : '';
            if (use) {
              ref.read(instanceProvider.notifier).setInstance('');
            } else {
              ref.read(instanceProvider.notifier).setInstance('lingva.ml');
            }
          },
          title: context.localizations.customInstance,
        ),
        AnimatedContainer(
          height: useInstance ? Styles.base * 7 : 0,
          duration: Styles.basicDuration,
          curve: Styles.basicCurve,
          child: Row(
            children: <Widget>[
              Expanded(
                child: ArnaTextField(
                  controller: textController,
                ),
              ),
              if (!editing)
                ArnaIconButton(
                  icon: Icons.check_outlined,
                  onPressed: () async {
                    setState(() => editing = !editing);
                    if (editing) {
                      hasError = !await ref
                          .read(instanceProvider.notifier)
                          .checkInstance(textController.text);
                      setState(() => editing = !editing);
                    }
                  },
                  tooltipMessage: 'Check URL',
                ),
              if (editing) const ArnaProgressIndicator(),
            ],
          ),
        ),
      ],
    );
  }
}
