import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/providers.dart';
import '/strings.dart';
import '/utils/functions.dart';
import '/widgets/about_button.dart';
import '/widgets/controllers.dart';
import '/widgets/controllers_buttons.dart';
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
    final String sourceKey = ref.watch(sourceProvider);
    final String targetKey = ref.watch(targetProvider);

    return ArnaScaffold(
      headerBarLeading: ArnaTextButton(
        label: Strings.translate,
        onPressed: () => translate(context, sourceKey, targetKey, controller.text, ref),
        buttonType: ButtonType.colored,
      ),
      title: Strings.appName,
      headerBarMiddle: isExpanded(context) ? const ControllersButtons() : null,
      actions: const <Widget>[
        AboutButton(),
        SettingsButton(),
      ],
      body: ArnaBody(
        expanded: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(width: deviceWidth(context) / 2, child: InputWidget(controller: controller)),
            SizedBox(width: deviceWidth(context) / 2, child: const OutputWidget()),
          ],
        ),
        compact: Column(
          children: <Widget>[
            const ControllersWidget(),
            const ArnaDivider(),
            Expanded(child: InputWidget(controller: controller)),
            const Expanded(child: SafeArea(top: false, child: OutputWidget())),
          ],
        ),
      ),
    );
  }
}
