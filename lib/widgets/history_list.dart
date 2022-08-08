import 'package:arna/arna.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '/db/history_db.dart';
import '/models/history.dart';
import '/strings.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final Box<History> historyDB = HistoryDB.instance.historyDB;
    final List<History> history = historyDB.values.toList().cast<History>();
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: history.length,
      itemBuilder: (BuildContext context, int index) => ArnaList(
        showBackground: true,
        title: DateFormat.yMMMMd().format(history[index].dateTime),
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: Styles.normal,
                  child: Text(
                    Strings.text,
                    style: ArnaTheme.of(context).textTheme.subtitle,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: Styles.normal,
                  child: Text(
                    Strings.translation,
                    style: ArnaTheme.of(context).textTheme.subtitle,
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: Styles.normal,
                  child: ArnaSelectableText(
                    history[index].input,
                    style: ArnaTheme.of(context).textTheme.body,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: Styles.normal,
                  child: ArnaSelectableText(
                    history[index].output,
                    style: ArnaTheme.of(context).textTheme.body,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
