import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '/utils/storage.dart';
import '../models/translation.dart';

final StateNotifierProvider<InstanceNotifier, String> instanceProvider =
    StateNotifierProvider<InstanceNotifier, String>(
  (Ref ref) => InstanceNotifier(),
  name: 'InstanceNotifier',
);

class InstanceNotifier extends StateNotifier<String> {
  InstanceNotifier() : super('lingva.ml') {
    _initialize();
  }

  final SharedStorage storage = SharedStorage.instance;

  void _initialize() {
    final String? instance = storage.instanceUrl;
    if (instance != null) {
      state = instance;
    }
  }

  void setInstance(String instance) {
    if (instance.isNotEmpty) {
      storage.setInstanceUrl(instance);
    }
    state = instance;
  }

  Future<bool> test(String url) async {
    Translation? translation;
    try {
      final http.Response response = await http.get(
        Uri.https(url, '/api/v1/auto/en/hello'),
      );
      translation = Translation.fromRawJson(response.body);
      return translation != null;
    } catch (e) {
      return false;
    }

    //return response.statusCode == 200;
  }

  Future<bool> checkInstance(String url) async {
    if (await test(url)) {
      setInstance(url);
      return true;
    } else {}
    return false;
  }
}
