import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateProvider<String> inputProvider = StateProvider<String>(
  (StateProviderRef<String> ref) => '',
);
