import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/db/history_db.dart';
import '/models/history.dart';
import '/providers.dart';
import '/screens/settings.dart';
import '/strings.dart';
import '/utils/storage.dart';
import '/utils/system_overlay.dart';
import '/widgets/controllers.dart';
import '/widgets/controllers_buttons.dart';
import '/widgets/history_list.dart';
import '/widgets/input.dart';
import '/widgets/output.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final Box<History> historyDB = HistoryDB.instance.historyDB;

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

  void onHistoryPressed() {
    showArnaPopupDialog(
      context: context,
      title: Strings.history,
      actions: <Widget>[
        ArnaIconButton(
          icon: Icons.delete_outlined,
          onPressed: () => showArnaDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return ArnaAlertDialog(
                title: Strings.deleteTitle,
                content: Text(
                  Strings.deleteDescription,
                  style: ArnaTheme.of(context).textTheme.subtitle,
                  textAlign: TextAlign.center,
                ),
                actions: <Widget>[
                  ArnaTextButton(
                    label: Strings.clear,
                    onPressed: () => Navigator.pop(context, true),
                    buttonType: ButtonType.destructive,
                  ),
                  ArnaTextButton(
                    label: Strings.cancel,
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              );
            },
          ).then((bool? value) async {
            if (value != null) {
              if (value) {
                historyDB.clear();
                Navigator.pop(context);
              }
            }
          }),
          tooltipMessage: Strings.deleteAll,
        ),
      ],
      builder: (BuildContext context) => const HistoryList(),
    );
  }

  void onSettingsPressed() {
    showArnaPopupDialog(
      context: context,
      title: Strings.settings,
      builder: (BuildContext context) => const Settings(),
    );
  }

  void onAboutPressed() {
    showArnaAboutDialog(
      context: context,
      applicationIcon: Image.asset(
        'assets/images/AppIcon.png',
        height: Styles.base * 30,
        width: Styles.base * 30,
      ),
      applicationName: Strings.appName,
      developerName: 'Mahan Rahmati',
      applicationVersion: Strings.version,
      applicationUri: Uri(
        scheme: 'https',
        host: 'github.com',
        path: 'MahanRahmati/translate/issues',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    updateSystemUIOverlayStyle(context);
    final bool isExpanded = ArnaHelpers.isExpanded(context);

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
      headerBarMiddle: isExpanded ? const ControllersButtons() : null,
      actions: <Widget>[
        ArnaPopupMenuButton<int>(
          itemBuilder: (BuildContext context) => <ArnaPopupMenuEntry<int>>[
            ArnaPopupMenuItem<int>(
              enabled: historyDB.isNotEmpty,
              value: 0,
              child: const Text(Strings.history),
            ),
            const ArnaPopupMenuDivider(),
            const ArnaPopupMenuItem<int>(
              value: 1,
              child: Text(Strings.settings),
            ),
            const ArnaPopupMenuItem<int>(
              value: 2,
              child: Text(Strings.about),
            ),
          ],
          onSelected: (int index) {
            switch (index) {
              case 0:
                onHistoryPressed();
                break;
              case 1:
                onSettingsPressed();
                break;
              case 2:
                onAboutPressed();
                break;
            }
          },
        ),
      ],
      headerBarBottom: isExpanded ? null : const ControllersWidget(),
      body: ArnaBody(
        expanded: expanded,
        compact: compact,
      ),
    );
  }
}
