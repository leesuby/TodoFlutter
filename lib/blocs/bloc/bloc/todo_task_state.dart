
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'listTodoTasks': listTodoTasks.map((x) => x.toMap()).toList(),
      'listTodoTasksOrigin': listTodoTasksOrigin.map((x) => x.toMap()).toList(),
    };
  }

  factory TodoTaskState.fromMap(Map<String, dynamic> map) {
    return TodoTaskState(
      listTodoTasks: List<TodoTask>.from((map['listTodoTasks'] as List<int>).map<TodoTask>((x) => TodoTask.fromMap(x as Map<String,dynamic>),),),
      listTodoTasksOrigin: List<TodoTask>.from((map['listTodoTasksOrigin'] as List<int>).map<TodoTask>((x) => TodoTask.fromMap(x as Map<String,dynamic>),),),
    );
  }

}
