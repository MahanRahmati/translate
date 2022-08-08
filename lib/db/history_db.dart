import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '/models/history.dart';

class HistoryDB {
  HistoryDB._();

  static final HistoryDB instance = HistoryDB._();

  late Box<History> historyDB;

  Future<void> initialize() async {
    historyDB = await Hive.openBox<History>('historyBox');
  }

  Future<void> add(String query, String translation) async {
    const Uuid uuid = Uuid();
    final History history = History(
      id: uuid.v4(),
      input: query,
      output: translation,
      dateTime: DateTime.now(),
    );
    await historyDB.add(history);
  }

  void disposeDB() => historyDB.close();
}
