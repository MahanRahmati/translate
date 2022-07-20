import 'package:flutter_riverpod/flutter_riverpod.dart';

final AutoDisposeStateProvider<String> sourceProvider =
    StateProvider.autoDispose<String>(
  (AutoDisposeStateProviderRef<String> ref) => 'auto',
);

final AutoDisposeStateProvider<String> targetProvider =
    StateProvider.autoDispose<String>(
  (AutoDisposeStateProviderRef<String> ref) => 'en',
);

final StateProvider<String> inputProvider = StateProvider<String>(
  (StateProviderRef<String> ref) => '',
);

final StateProvider<String?> outputProvider = StateProvider<String?>(
  (StateProviderRef<String?> ref) => '',
);
