import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/utils/storage.dart';

final StateNotifierProvider<UseInstanceNotifier, bool> useInstanceProvider =
    StateNotifierProvider<UseInstanceNotifier, bool>(
  (Ref ref) => UseInstanceNotifier(),
  name: 'UseInstanceNotifier',
);

class UseInstanceNotifier extends StateNotifier<bool> {
  UseInstanceNotifier() : super(false) {
    _initialize();
  }

  final SharedStorage storage = SharedStorage.instance;

  void _initialize() {
    final bool useInstance = storage.useInstance;
    if (useInstance) {
      state = useInstance;
    }
  }

  void useInstance({bool useInstance = false}) {
    storage.setUseInstance(useInstance: useInstance);
    state = useInstance;
  }
}
