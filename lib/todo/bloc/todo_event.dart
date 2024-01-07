// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

class TodoInitialEvent extends TodoEvent {}

class TodoAddEvent extends TodoEvent {
  final TodoModel todo;
  TodoAddEvent({
    required this.todo,
  });
}

class TodoRemoveEvent extends TodoEvent {
  final int index;
  TodoRemoveEvent({
    required this.index,
  });
}

class TodoUpdateEvent extends TodoEvent {
  final int index;
  final TodoModel todo;
  TodoUpdateEvent({
    required this.index,
    required this.todo,
  });
}
