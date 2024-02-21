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
    on<SortTodoTask>(_onSortTodoTask);
    on<SearchTodoTask>(_onSearchTodoTask);
  }

  void _onAddTodoTask(AddTodoTask event, Emitter<TodoTaskState> emit) {
    final state = this.state;
    emit(TodoTaskState(
      listTodoTasks: List.from(state.listTodoTasks)..add(event.task),
      listTodoTasksOrigin: List.from(state.listTodoTasks)..add(event.task),
    ));
  }

  void _onDeleteTodoTask(DeleteTodoTask event, Emitter<TodoTaskState> emit) {
    final state = this.state;
    emit(TodoTaskState(
        listTodoTasks: List.from(state.listTodoTasks)..remove(event.task),
        listTodoTasksOrigin: List.from(state.listTodoTasks)
          ..remove(event.task)));
  }

  void _onUpdateTodoTask(UpdateTodoTask event, Emitter<TodoTaskState> emit) {
    final state = this.state;
    final task = event.task;
    final int index = state.listTodoTasks.indexOf(task);

    List<TodoTask> allTodoTasks = List.from(state.listTodoTasks)..remove(task);
    allTodoTasks.insert(index, task.copyWith(isDone: task.isDone == false));

    emit(TodoTaskState(
        listTodoTasks: allTodoTasks, listTodoTasksOrigin: allTodoTasks));
  }

  void _onSortTodoTask(SortTodoTask event, Emitter<TodoTaskState> emit) {
    final state = this.state;
    final sortType = event.sortType;
    List<TodoTask> listTodoTasksFilter =
        List<TodoTask>.from(state.listTodoTasksOrigin).where(
      (element) {
        if (sortType == 0) {
          return true;
        }

        DateTime now = DateTime.now();
        if (sortType < 0) {
          return element.time.year == now.year &&
              element.time.month == now.month &&
              element.time.day == now.day;
        }

        if (sortType > 0) {
          return element.time.millisecondsSinceEpoch >
              now.millisecondsSinceEpoch;
        }

        return false;
      },
    ).toList();

    emit(TodoTaskState(
        listTodoTasks: listTodoTasksFilter,
        listTodoTasksOrigin: state.listTodoTasksOrigin));
  }

  void _onSearchTodoTask(SearchTodoTask event, Emitter<TodoTaskState> emit) {
    final state = this.state;
    final keyword = event.keyword;
    if (keyword.isEmpty) {
      emit(TodoTaskState(
        listTodoTasks: state.listTodoTasksOrigin,
        listTodoTasksOrigin: state.listTodoTasksOrigin));
        return;
    }

    List<TodoTask> listTodoTasksFilter =
        List<TodoTask>.from(state.listTodoTasks).where(
      (element) {
        return element.title.contains(keyword);
      },
    ).toList();

    emit(TodoTaskState(
        listTodoTasks: listTodoTasksFilter,
        listTodoTasksOrigin: state.listTodoTasksOrigin));
  }
}
