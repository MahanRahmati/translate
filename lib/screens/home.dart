import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/providers.dart';
import '/strings.dart';
import '/utils/storage.dart';
import '/utils/system_overlay.dart';
import '/widgets/controllers.dart';
import '/widgets/controllers_buttons.dart';
import '/widgets/history_button.dart';
import '/widgets/input.dart';
import '/widgets/output.dart';
import '/widgets/settings_button.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  void initState() {
    final SharedStorage storage = SharedStorage.instance;
    final String? source = storage.source;
    if (source != null) {
      ref.read(sourceProvider.notifier).state = source;
    }

    final String? target = storage.target;
    if (target != null) {
      ref.read(targetProvider.notifier).state = target;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    updateSystemUIOverlayStyle(context);

    final Widget input = InputWidget(
      input: ref.read(inputProvider),
    );

    final Widget expanded = Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          width: ArnaHelpers.deviceWidth(context) / 2,
          child: input,
        ),
        SizedBox(
          width: ArnaHelpers.deviceWidth(context) / 2,
          child: const OutputWidget(),
        ),
      ],
    );

    final Widget compact = Column(
      children: <Widget>[
        Expanded(child: input),
        const Expanded(
          child: SafeArea(
            top: false,
            child: OutputWidget(),
          ),
        ),
      ],
    );

    return ArnaScaffold(
      title: Strings.appName,
      headerBarMiddle:
          ArnaHelpers.isExpanded(context) ? const ControllersButtons() : null,
      actions: const <Widget>[
        HistoryButton(),
        SettingsButton(),
      ],
      headerBarBottom:
          ArnaHelpers.isExpanded(context) ? null : const ControllersWidget(),
      body: ArnaBody(
        expanded: expanded,
        compact: compact,
      ),
    );
  }
}
