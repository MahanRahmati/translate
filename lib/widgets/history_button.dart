import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/db/history_db.dart';
import '/models/history.dart';
import '/strings.dart';
import '/widgets/history_list.dart';

class HistoryButton extends ConsumerWidget {
  const HistoryButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Box<History> historyDB = HistoryDB.instance.historyDB;
    return ArnaIconButton(
      icon: Icons.history_outlined,
      onPressed: () => showArnaPopupDialog(
        context: context,
        title: Strings.history,
        actions: <Widget>[
          ArnaIconButton(
            icon: Icons.delete_outlined,
            onPressed: historyDB.isNotEmpty
                ? () => showArnaDialog<bool>(
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
                    })
                : null,
            tooltipMessage: Strings.deleteAll,
            buttonType: ButtonType.destructive,
          ),
        ],
        builder: (BuildContext context) => const HistoryList(),
      ),
      tooltipMessage: Strings.history,
    );
  }
}
