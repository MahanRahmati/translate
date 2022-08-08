import 'dart:convert';

import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '/db/history_db.dart';
import '/models/translation.dart';
import '/providers/input_provider.dart';
import '/providers/source_provider.dart';
import '/providers/target_provider.dart';

final FutureProvider<Translation?> outputProvider =
    FutureProvider<Translation?>((FutureProviderRef<Translation?> ref) async {
  final String query = ref.watch(inputProvider);
  if (query.isEmpty) {
    return null;
  }
  final String sourceKey = ref.watch(sourceProvider);
  final String targetKey = ref.watch(targetProvider);

  Translation? translation;

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
});
