import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateProvider<String> targetProvider = StateProvider<String>(
  (Ref ref) => 'en',
  name: 'TargetProvider',
);
