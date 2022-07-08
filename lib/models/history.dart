import 'package:hive/hive.dart';

part 'history.g.dart';

@HiveType(typeId: 0)
class History {
  History({
    required this.id,
    required this.input,
    required this.output,
    required this.dateTime,
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String input;

  @HiveField(2)
  final String output;

  @HiveField(3)
  final DateTime dateTime;
}
