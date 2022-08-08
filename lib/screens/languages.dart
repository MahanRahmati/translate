import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/providers.dart';
import '/strings.dart';
import '/utils/languages.dart';
import '/utils/storage.dart';

class Languages extends ConsumerStatefulWidget {
  const Languages({
    super.key,
    required this.isSource,
  });

  final bool isSource;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LanguagesState();
}

class _LanguagesState extends ConsumerState<Languages> {
  TextEditingController controller = TextEditingController();
  final List<ArnaRadioListTile<String>> list = <ArnaRadioListTile<String>>[];
  late String sourceKey;
  late String targetKey;
  late String groupValue;

  void addItem(String key) {
    final ArnaRadioListTile<String> item = ArnaRadioListTile<String>(
      value: key,
      groupValue: groupValue,
      title: languagesList[key]!,
      onChanged: (String? value) async => setLanguage(key, value!),
    );
    list.add(item);
  }

  void setLanguage(String key, String value) {
    final SharedStorage storage = SharedStorage.instance;
    if (widget.isSource && key != sourceKey) {
      storage.setSource(value);
      ref.read(sourceProvider.notifier).state = value;
    } else if (key != targetKey) {
      storage.setTarget(value);
      ref.read(targetProvider.notifier).state = value;
    }
    Navigator.pop(context);
  }

  void search(String query) {
    if (query.isEmpty) {
      list.clear();
    } else {
      list.clear();
      languagesList.forEach((String key, String value) {
        if (key == 'auto' && !widget.isSource) {
          return; // Target language can't be 'Auto'
        }
        if ((key == sourceKey && !widget.isSource) ||
            (key == targetKey && widget.isSource)) {
          return; // Not translating a language to itself
        }
        if (languagesList[key]!.toLowerCase().contains(query.toLowerCase())) {
          addItem(key);
        }
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    sourceKey = ref.watch(sourceProvider);
    targetKey = ref.watch(targetProvider);
    groupValue = widget.isSource ? sourceKey : targetKey;

    if (controller.text.isEmpty) {
      languagesList.forEach((String key, String value) {
        if (key == 'auto' && !widget.isSource) {
          return; // Target language can't be 'Auto'
        }
        if ((key == sourceKey && !widget.isSource) ||
            (key == targetKey && widget.isSource)) {
          return; // Not translating a language to itself
        }
        addItem(key);
      });
    }

    return Column(
      children: <Widget>[
        ArnaSearchField(
          showSearch: true,
          controller: controller,
          onChanged: search,
          hintText: Strings.search,
          autofocus: true,
        ),
        const ArnaDivider(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ArnaList(
                  title: Strings.languages,
                  showDividers: true,
                  showBackground: true,
                  children: list,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
