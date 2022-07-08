import 'package:arna/arna.dart';

import '/strings.dart';

class EmptyHistory extends StatelessWidget {
  const EmptyHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.history_toggle_off_outlined,
          size: Styles.base * 30,
          color: ArnaDynamicColor.resolve(ArnaColors.iconColor, context),
        ),
        Padding(
          padding: Styles.normal,
          child: Text(
            Strings.emptyHistory,
            style: ArnaTheme.of(context).textTheme.title,
          ),
        ),
        Padding(
          padding: Styles.normal,
          child: Text(
            Strings.emptyHistoryDescription,
            style: ArnaTheme.of(context).textTheme.body,
          ),
        ),
      ],
    );
  }
}
