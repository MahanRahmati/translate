import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/providers/theme.dart';
import '/screens/home.dart';
import '/utils/hive.dart';
import '/utils/storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  registerHiveAdapters();
  await initializeDBs();
  await SharedStorage.instance.initialize();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ArnaApp(
      debugShowCheckedModeBanner: false,
      theme: ArnaThemeData(
        brightness: ref.watch(themeProvider),
        accentColor: const Color(0xFF2EC27E),
      ),
      home: const Home(),
    );
  }
}
