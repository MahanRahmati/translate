import 'package:hive_flutter/hive_flutter.dart';

import '/db/history_db.dart';
import '/models/history.dart';

Future<void> initializeHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HistoryAdapter());
  await HistoryDB.instance.initialize();
}
