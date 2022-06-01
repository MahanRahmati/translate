import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/providers.dart';
import '/screens/languages.dart';
import '/screens/settings.dart';
import '/strings.dart';
import '/utils/functions.dart';
import '/utils/languages.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool showBlur = ref.watch(blurProvider);
    final String sourceKey = ref.watch(sourceProvider);
    final String targetKey = ref.watch(targetProvider);
    final String source = languages[sourceKey]!;
    final String target = languages[targetKey]!;

    final String? outputText = ref.watch(outputProvider);

    final Widget linkedButtons = ArnaLinkedButtons(
      buttons: <ArnaLinkedButton>[
        ArnaLinkedButton(
          label: source,
          onPressed: () => showArnaPopupDialog(
            context: context,
            title: Strings.source,
            builder: (BuildContext context) => const Languages(source: true),
            useBlur: showBlur,
          ),
        ),
        ArnaLinkedButton(
          icon: Icons.compare_arrows_outlined,
          onPressed: sourceKey != 'auto'
              ? () {
                  final String s = sourceKey;
                  final String t = targetKey;
                  ref.read(sourceProvider.notifier).state = t;
                  ref.read(targetProvider.notifier).state = s;
                }
              : null,
          tooltipMessage: Strings.swap,
        ),
        ArnaLinkedButton(
          label: target,
          onPressed: () => showArnaPopupDialog(
            context: context,
            title: Strings.target,
            builder: (BuildContext context) => const Languages(source: false),
            useBlur: showBlur,
          ),
        ),
      ],
    );

    final Widget controllers = Container(
      color: ArnaDynamicColor.resolve(ArnaColors.headerColor, context),
      child: Row(
        children: <Widget>[
          Expanded(
            child: ArnaTextButton(
              label: source,
              onPressed: () => showArnaPopupDialog(
                context: context,
                title: Strings.source,
                builder: (BuildContext context) => const Languages(source: true),
                useBlur: showBlur,
              ),
            ),
          ),
          ArnaIconButton(
            icon: Icons.compare_arrows_outlined,
            onPressed: sourceKey != 'auto'
                ? () {
                    final String s = sourceKey;
                    final String t = targetKey;
                    ref.read(sourceProvider.notifier).state = t;
                    ref.read(targetProvider.notifier).state = s;
                  }
                : null,
            tooltipMessage: Strings.swap,
          ),
          Expanded(
            child: ArnaTextButton(
              label: target,
              onPressed: () => showArnaPopupDialog(
                context: context,
                title: Strings.target,
                builder: (BuildContext context) => const Languages(source: false),
                useBlur: showBlur,
              ),
            ),
          ),
        ],
      ),
    );

    final Widget input = Padding(
      padding: Styles.small,
      child: ArnaTextField(
        controller: controller,
        onSubmitted: (String text) => translate(context, sourceKey, targetKey, controller.text, ref),
        clearButtonMode: ArnaOverlayVisibilityMode.editing,
        hintText: Strings.text,
        maxLength: 5000,
        maxLines: null,
        textAlignVertical: TextAlignVertical.top,
      ),
    );

    final Widget output = ArnaCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: outputText == null
                ? const Center(child: ArnaProgressIndicator())
                : Padding(
                    padding: Styles.normal,
                    child: Text(
                      outputText.isEmpty ? Strings.empty : outputText,
                      style: outputText.isEmpty
                          ? ArnaTheme.of(context).textTheme.body!.copyWith(
                                color: ArnaDynamicColor.resolve(ArnaColors.secondaryTextColor, context),
                              )
                          : ArnaTheme.of(context).textTheme.body,
                    ),
                  ),
          ),
          const ArnaDivider(),
          Row(
            children: <Widget>[
              const Spacer(),
              ArnaIconButton(
                icon: Icons.copy_outlined,
                onPressed: outputText != null && outputText.isNotEmpty ? () => copyToClipboard(outputText) : null,
                tooltipMessage: Strings.copy,
              ),
            ],
          ),
        ],
      ),
    );

    return ArnaScaffold(
      headerBarLeading: ArnaTextButton(
        label: Strings.translate,
        onPressed: () => translate(context, sourceKey, targetKey, controller.text, ref),
        buttonType: ButtonType.colored,
      ),
      title: Strings.appName,
      headerBarMiddle: isExpanded(context) ? linkedButtons : null,
      actions: <Widget>[
        ArnaIconButton(
          icon: Icons.info_outlined,
          onPressed: () => showArnaAboutDialog(
            context: context,
            applicationIcon: Image.asset(
              'assets/images/AppIcon.png',
              height: Styles.base * 30,
              width: Styles.base * 30,
            ),
            applicationName: Strings.appName,
            developerName: 'Mahan Rahmati',
            applicationVersion: Strings.version,
            applicationUri: Uri(scheme: 'https', host: 'github.com', path: 'MahanRahmati/Arna/issues'),
            useBlur: showBlur,
          ),
          tooltipMessage: Strings.about,
        ),
        ArnaIconButton(
          icon: Icons.settings_outlined,
          onPressed: () => showArnaPopupDialog(
            context: context,
            title: Strings.settings,
            builder: (BuildContext context) => const Settings(),
            useBlur: showBlur,
          ),
          tooltipMessage: Strings.settings,
        ),
      ],
      body: isExpanded(context)
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(width: deviceWidth(context) / 2, child: input),
                SizedBox(width: deviceWidth(context) / 2, child: output),
              ],
            )
          : Column(
              children: <Widget>[
                controllers,
                const ArnaDivider(),
                Expanded(child: input),
                Expanded(child: SafeArea(top: false, child: output)),
              ],
            ),
    );
  }
}
