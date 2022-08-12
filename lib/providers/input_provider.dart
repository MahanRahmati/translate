import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/utils/debouncer.dart';

final StateNotifierProvider<InputNotifier, String> inputProvider =
    StateNotifierProvider<InputNotifier, String>(
  (Ref ref) => InputNotifier(),
  name: 'InputNotifier',
);

class InputNotifier extends StateNotifier<String> {
  InputNotifier() : super('');

  final Debouncer debouncer = Debouncer(milliseconds: 1500);

  void updateInput(String query) {
    if (query.isEmpty) {
      state = query;
    } else {
      debouncer.run(() => state = query);
    }
  }
}
