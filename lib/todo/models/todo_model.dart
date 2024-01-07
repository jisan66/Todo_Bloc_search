// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive_flutter/hive_flutter.dart';
part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoModel extends HiveObject {
  @HiveField(0)
  final String titile;
  @HiveField(1)
  final String? description;
  @HiveField(2)
  final bool? done;
  TodoModel({
    required this.titile,
    this.description,
    this.done = false,
  });
}
