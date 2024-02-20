import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tasks_app/models/todoTask.dart';

part 'todo_task_event.dart';
part 'todo_task_state.dart';

class TodoTaskBloc extends Bloc<TodoTaskEvent, TodoTaskState> {
  TodoTaskBloc() : super(const TodoTaskState()) {
    on<AddTodoTask>(_onAddTodoTask);
    on<DeleteTodoTask>(_onDeleteTodoTask);
  }

  void _onAddTodoTask(AddTodoTask event, Emitter<TodoTaskState> emit) {
    final state = this.state;
    emit(TodoTaskState(
      listTodoTasks: List.from(state.listTodoTasks)..add(event.task),
    ));
  }

  void _onDeleteTodoTask(DeleteTodoTask event, Emitter<TodoTaskState> emit) {
    final state = this.state;
    emit(TodoTaskState(
      listTodoTasks: List.from(state.listTodoTasks)..add(event.task),
    ));
  }
}
