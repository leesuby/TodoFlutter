import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tasks_app/models/todoTask.dart';

part 'todo_task_event.dart';
part 'todo_task_state.dart';

class TodoTaskBloc extends Bloc<TodoTaskEvent, TodoTaskState> {
  TodoTaskBloc() : super(const TodoTaskState()) {
    on<UpdateTodoTask>(_onUpdateTodoTask);
    on<AddTodoTask>(_onAddTodoTask);
    on<DeleteTodoTask>(_onDeleteTodoTask);
    on<ChangeTodoTask>(_onChangeTodoTask);
  }

  void _onAddTodoTask(AddTodoTask event, Emitter<TodoTaskState> emit) {
    final state = this.state;
    emit(TodoTaskState(
      listTodoTasks: List.from(state.listTodoTasks)..add(event.task),
    ));
  }

  void _onDeleteTodoTask(DeleteTodoTask event, Emitter<TodoTaskState> emit) {
    final state = this.state;
    emit(TodoTaskState(listTodoTasks: List.from(state.listTodoTasks)..remove(event.task)));
  }

  void _onUpdateTodoTask(UpdateTodoTask event, Emitter<TodoTaskState> emit) {
    final state = this.state;
    final task = event.task;
    final int index = state.listTodoTasks.indexOf(task);

    List<TodoTask> allTodoTasks = List.from(state.listTodoTasks)..remove(task);
    allTodoTasks.insert(index,task.copyWith(isDone: task.isDone == false));

    emit(TodoTaskState(listTodoTasks: allTodoTasks));
  }

  void _onChangeTodoTask(ChangeTodoTask event, Emitter<TodoTaskState> emit) {
    final state = this.state;
    emit(TodoTaskState(
      listTodoTasks: List.from(state.listTodoTasks)..add(event.task),
    ));
  }
}
