part of 'todo_task_bloc.dart';

class TodoTaskState extends Equatable {
  final List<TodoTask> listTodoTasks;
  final List<TodoTask> listTodoTasksOrigin;
  const TodoTaskState({
    this.listTodoTasks = const <TodoTask>[],
    this.listTodoTasksOrigin = const <TodoTask>[]
  });
  
  @override
  List<Object> get props => [listTodoTasks];
}