import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 1)
class Note {
  @HiveField(0)
  String heading;

  @HiveField(1)
  String description;

  @HiveField(2)
  DateTime date;

  Note({required this.heading, required this.description, required this.date});
}
