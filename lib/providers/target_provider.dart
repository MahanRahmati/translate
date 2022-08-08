import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateProvider<String> targetProvider = StateProvider<String>(
  (StateProviderRef<String> ref) => 'en',
);
