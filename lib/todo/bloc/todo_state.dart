// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_bloc.dart';

@immutable
sealed class TodoState {}

final class TodoInitial extends TodoState {}

abstract class TodoActionState extends TodoState {}

class TodoLoadingState extends TodoState {}

class TodoSuccessState extends TodoState {
  final Box<TodoModel> box;
  TodoSuccessState({
    required this.box,
  });
}

class TodoErrorState extends TodoState {}

class TodoAddActionState extends TodoActionState {}

class TodoDeletActionState extends TodoActionState {}

class TodoUpdateActionState extends TodoActionState {}
