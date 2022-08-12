import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateProvider<String> sourceProvider = StateProvider<String>(
  (Ref ref) => 'auto',
  name: 'SourceProvider',
);
