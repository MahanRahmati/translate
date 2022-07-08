import 'package:hive_flutter/hive_flutter.dart';

import '/db/history_db.dart';
import '/models/history.dart';

void registerHiveAdapters() {
  Hive.registerAdapter(HistoryAdapter());
}

Future<void> initializeDBs() async {
  await HistoryDB.instance.initialize();
}
