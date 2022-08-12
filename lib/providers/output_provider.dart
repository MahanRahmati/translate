import 'dart:convert';

import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '/db/history_db.dart';
import '/models/translation.dart';
import '/providers/input_provider.dart';
import '/providers/source_provider.dart';
import '/providers/target_provider.dart';

final StateNotifierProvider<OutputNotifier, Translation?> outputProvider =
    StateNotifierProvider<OutputNotifier, Translation?>(
  (Ref ref) => OutputNotifier(ref),
  name: 'OutputProvider',
);

class OutputNotifier extends StateNotifier<Translation?> {
  OutputNotifier(this.ref) : super(null) {
    _initializeOutput();
  }

  final Ref ref;

  Future<void> _initializeOutput() async {
    final String query = ref.watch(inputProvider);
    state = query.isEmpty ? null : await _fetch(query);
  }

  Future<Translation?> _fetch(String query) async {
    Translation? translation;
    final String sourceKey = ref.watch(sourceProvider);
    final String targetKey = ref.watch(targetProvider);
    try {
      final http.Response response = await http.get(
        Uri.https('lingva.ml', '/api/v1/$sourceKey/$targetKey/$query'),
      );

      translation = Translation.fromJson(
        json: json.decode(response.body) as Map<String, dynamic>,
      );

      if (translation.translation != null) {
        HistoryDB.instance.add(query, translation.translation!);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return translation;
  }
}
