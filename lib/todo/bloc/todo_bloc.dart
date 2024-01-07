import 'package:bloc/bloc.dart';
import 'package:demo_bloc/todo/models/todo_model.dart';
import 'package:flutter/physics.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    Box<TodoModel> box = Hive.box('todo');
    on<TodoInitialEvent>((event, emit) async {
      emit(TodoLoadingState());
      await Future.delayed(Duration(seconds: 1));

      emit(TodoSuccessState(box: box));

      on<TodoAddEvent>((event, emit) async {
        await box.add(event.todo).then((value) => emit(TodoAddActionState()));
        emit(TodoSuccessState(box: box));
      });
      on<TodoRemoveEvent>((event, emit) async {
        await box
            .deleteAt(event.index)
            .then((value) => emit(TodoDeletActionState()));
        emit(TodoSuccessState(box: box));
      });
      on<TodoUpdateEvent>((event, emit) async {
        await box
            .putAt(event.index, event.todo)
            .then((value) => emit(TodoUpdateActionState()));
        emit(TodoSuccessState(box: box));
      });
    });
    // add(TodoInitialEvent());
  }
}
