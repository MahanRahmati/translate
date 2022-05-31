import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/providers.dart';
import '/strings.dart';
import '/utils/languages.dart';

class Languages extends ConsumerWidget {
  const Languages({
    super.key,
    required this.source,
  });

  final bool source;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String groupValue = source ? ref.watch(sourceProvider) : ref.watch(targetProvider);
    final List<ArnaRadioListTile<String>> list = <ArnaRadioListTile<String>>[];

    languages.forEach((String key, String value) {
      list.add(
        ArnaRadioListTile<String>(
          value: key,
          groupValue: groupValue,
          title: languages[key]!,
          onChanged: (String? value) {
            source
                ? ref.read(sourceProvider.notifier).state = value!
                : ref.read(targetProvider.notifier).state = value!;
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
