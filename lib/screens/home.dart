import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/strings.dart';
import '/utils/functions.dart';
import '/utils/system_overlay.dart';
import '/widgets/about_button.dart';
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
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    updateSystemUIOverlayStyle(context);
    final Widget input = InputWidget(
      controller: controller,
    );
    return ArnaScaffold(
      headerBarLeading: ArnaTextButton(
        label: Strings.translate,
        onPressed: () => translate(context, controller.text, ref),
        buttonType: ButtonType.colored,
      ),
      title: Strings.appName,
      headerBarMiddle: isExpanded(context) ? const ControllersButtons() : null,
      actions: const <Widget>[
        HistoryButton(),
        AboutButton(),
        SettingsButton(),
      ],
      body: ArnaBody(
        expanded: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              width: deviceWidth(context) / 2,
              child: input,
            ),
            SizedBox(
              width: deviceWidth(context) / 2,
              child: const OutputWidget(),
            ),
          ],
        ),
        compact: Column(
          children: <Widget>[
            const ControllersWidget(),
            const ArnaDivider(),
            Expanded(
              child: input,
            ),
            const Expanded(
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
