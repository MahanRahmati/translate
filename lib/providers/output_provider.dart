import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '/db/history_db.dart';
import '/models/translation.dart';
import '/providers/input_provider.dart';
import '/providers/instance_provider.dart';
import '/providers/source_provider.dart';
import '/providers/target_provider.dart';

final StateNotifierProvider<OutputNotifier, AsyncValue<Translation?>>
    outputProvider =
    StateNotifierProvider<OutputNotifier, AsyncValue<Translation?>>(
  (Ref ref) => OutputNotifier(ref),
  name: 'OutputProvider',
);

class OutputNotifier extends StateNotifier<AsyncValue<Translation?>> {
  OutputNotifier(this.ref) : super(const AsyncValue<Translation?>.data(null)) {
    _initializeOutput();
  }

  final Ref ref;

  Future<void> _initializeOutput() async {
    final String query = ref.watch(inputProvider);
    if (query.isNotEmpty) {
      state = const AsyncValue<Translation?>.loading();
      state = await AsyncValue.guard(() => _fetch(query));
    }
  }

  Future<Translation?> _fetch(String query) async {
    Translation? translation;
    final String sourceKey = ref.watch(sourceProvider);
    final String targetKey = ref.watch(targetProvider);
    final String instance = ref.watch(instanceProvider);
    final String host = instance.isEmpty ? 'lingva.ml' : instance;
    final http.Response response = await http.get(
      Uri.https(host, '/api/v1/$sourceKey/$targetKey/$query'),
    );
    translation = Translation.fromRawJson(response.body);
    if (translation.translation != null) {
      HistoryDB.instance.add(query, translation.translation!);
    }
    return translation;
  }
}
