part of 'todo_task_bloc.dart';

class TodoTaskState extends Equatable {
  final List<TodoTask> listTodoTasks;
  const TodoTaskState({
    this.listTodoTasks = const <TodoTask>[],
  });
  
  @override
  List<Object> get props => [listTodoTasks];
}