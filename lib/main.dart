import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/providers.dart';
import '/screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    preferences = await SharedPreferences.getInstance();

    final int? theme = preferences.getInt('theme');
    if (theme == 0) {
      ref.read(themeProvider.notifier).state = null;
    } else if (theme == 1) {
      ref.read(themeProvider.notifier).state = Brightness.dark;
    } else if (theme == 2) {
      ref.read(themeProvider.notifier).state = Brightness.light;
    }

    final bool? auto = preferences.getBool('auto');
    if (auto != null) {
      ref.read(autoProvider.notifier).state = auto;
    }

    final bool? blur = preferences.getBool('blur');
    if (blur != null) {
      ref.read(blurProvider.notifier).state = blur;
    }

    final String? source = preferences.getString('source');
    if (source != null) {
      ref.read(sourceProvider.notifier).state = source;
    }

    final String? target = preferences.getString('target');
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
