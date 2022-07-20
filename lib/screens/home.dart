import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/strings.dart';
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
  Widget build(BuildContext context) {
    updateSystemUIOverlayStyle(context);
    const Widget input = InputWidget();
    return ArnaScaffold(
      title: Strings.appName,
      headerBarMiddle:
          ArnaHelpers.isExpanded(context) ? const ControllersButtons() : null,
      actions: const <Widget>[
        HistoryButton(),
        SettingsButton(),
      ],
      body: ArnaBody(
        expanded: Row(
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
        ),
        compact: Column(
          children: const <Widget>[
            ControllersWidget(),
            ArnaDivider(),
            Expanded(
              child: input,
            ),
            Expanded(
              child: SafeArea(
                top: false,
                child: OutputWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
