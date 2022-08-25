import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/utils/storage.dart';

final StateNotifierProvider<InstanceNotifier, String?> instanceProvider =
    StateNotifierProvider<InstanceNotifier, String?>(
  (Ref ref) => InstanceNotifier(),
  name: 'InstanceNotifier',
);

class InstanceNotifier extends StateNotifier<String?> {
  InstanceNotifier() : super(null) {
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
    storage.setInstanceUrl(instance);
    state = instance;
  }
}
