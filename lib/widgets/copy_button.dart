import 'package:arna/arna.dart';

import '/strings.dart';

class CopyButton extends StatelessWidget {
  const CopyButton({
    super.key,
    required this.translation,
  });

  final String? translation;

  @override
  Widget build(BuildContext context) {
    return ArnaIconButton(
      icon: Icons.copy_outlined,
      onPressed: translation != null && translation!.isNotEmpty
          ? () {
              ArnaHelpers.copyToClipboard(translation!);
              showArnaSnackbar(
                context: context,
                message: context.localizations.copyToast,
              );
            }
          : null,
      tooltipMessage: context.localizations.copy,
    );
  }
}
