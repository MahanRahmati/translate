import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/providers.dart';
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

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  final SharedStorage storage = SharedStorage.instance;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    final int? theme = storage.theme;
    if (theme == 0) {
      ref.read(themeProvider.notifier).state = null;
    } else if (theme == 1) {
      ref.read(themeProvider.notifier).state = Brightness.dark;
    } else if (theme == 2) {
      ref.read(themeProvider.notifier).state = Brightness.light;
    }

    final bool? auto = storage.auto;
    if (auto != null) {
      ref.read(autoProvider.notifier).state = auto;
    }

    final bool? blur = storage.blur;
    if (blur != null) {
      ref.read(blurProvider.notifier).state = blur;
    }

    final String? source = storage.source;
    if (source != null) {
      ref.read(sourceProvider.notifier).state = source;
    }

    final String? target = storage.target;
    if (target != null) {
      ref.read(targetProvider.notifier).state = target;
    }
  }

  @override
  Widget build(BuildContext context) {
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
