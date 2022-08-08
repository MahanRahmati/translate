import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateProvider<String> sourceProvider = StateProvider<String>(
  (StateProviderRef<String> ref) => 'auto',
);
