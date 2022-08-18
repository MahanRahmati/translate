import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/db/history_db.dart';
import '/models/history.dart';
import '/providers/source_provider.dart';
import '/providers/target_provider.dart';
import '/screens/settings.dart';
import '/strings.dart';
import '/utils/storage.dart';
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
      title: context.localizations.history,
      actions: <Widget>[
        ArnaIconButton(
          icon: Icons.delete_outlined,
          onPressed: () => showArnaDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return ArnaAlertDialog(
                title: context.localizations.deleteTitle,
                content: Text(
                  context.localizations.deleteDescription,
                  style: ArnaTheme.of(context).textTheme.subtitle,
                  textAlign: TextAlign.center,
                ),
                actions: <Widget>[
                  ArnaTextButton(
                    label: context.localizations.clear,
                    onPressed: () => Navigator.pop(context, true),
                    buttonType: ButtonType.destructive,
                  ),
                  ArnaTextButton(
                    label: context.localizations.cancel,
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
          tooltipMessage: context.localizations.deleteAll,
        ),
      ],
      builder: (BuildContext context) => const HistoryList(),
    );
  }

  void onSettingsPressed() {
    showArnaPopupDialog(
      context: context,
      title: context.localizations.settings,
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
    ArnaHelpers.setNavigationBarStyle(context);
    final bool isExpanded = ArnaHelpers.isExpanded(context);

    const Widget input = InputWidget();

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
      children: const <Widget>[
        Expanded(child: input),
        Expanded(
          child: SafeArea(
            top: false,
            child: OutputWidget(),
          ),
        ),
      ],
    );

    return ArnaScaffold(
      title: Strings.appName,
      headerBarMiddle: isExpanded ? const ControllersButtons(top: true) : null,
      actions: <Widget>[
        ArnaPopupMenuButton<int>(
          itemBuilder: (BuildContext context) => <ArnaPopupMenuEntry<int>>[
            ArnaPopupMenuItem<int>(
              enabled: historyDB.isNotEmpty,
              value: 0,
              child: Text(context.localizations.history),
            ),
            const ArnaPopupMenuDivider(),
            ArnaPopupMenuItem<int>(
              value: 1,
              child: Text(context.localizations.settings),
            ),
            ArnaPopupMenuItem<int>(
              value: 2,
              child: Text(context.localizations.about),
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
      headerBarBottom: isExpanded ? null : const ControllersButtons(top: false),
      body: ArnaBody(
        expanded: expanded,
        compact: compact,
      ),
    );
  }
}
