import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/providers.dart';
import '/strings.dart';
import '/utils/languages.dart';

class Languages extends ConsumerStatefulWidget {
  const Languages({
    super.key,
    required this.source,
  });

  final bool source;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LanguagesState();
}

class _LanguagesState extends ConsumerState<Languages> {
  late SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async => preferences = await SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    final String groupValue = widget.source ? ref.watch(sourceProvider) : ref.watch(targetProvider);
    final List<ArnaRadioListTile<String>> list = <ArnaRadioListTile<String>>[];

    languages.forEach((String key, String value) {
      list.add(
        ArnaRadioListTile<String>(
          value: key,
          groupValue: groupValue,
          title: languages[key]!,
          onChanged: (String? value) async {
            if (widget.source) {
              preferences.setString('source', value!);
              ref.read(sourceProvider.notifier).state = value;
            } else {
              preferences.setString('target', value!);
              ref.read(targetProvider.notifier).state = value;
            }
          },
        ),
      );
    });

    return SingleChildScrollView(
      child: ArnaList(
        title: Strings.language,
        showDividers: true,
        showBackground: true,
        children: list,
      ),
    );
  }
}
