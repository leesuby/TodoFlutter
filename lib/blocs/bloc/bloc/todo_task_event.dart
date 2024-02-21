part of 'todo_task_bloc.dart';

class TodoTaskEvent extends Equatable {
  const TodoTaskEvent();

  @override
  List<Object> get props => [];
}

class UpdateTodoTask extends TodoTaskEvent {
  final TodoTask task;
  const UpdateTodoTask ({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}

class AddTodoTask extends TodoTaskEvent {
  final TodoTask task;
  const AddTodoTask ({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}

class DeleteTodoTask extends TodoTaskEvent {
  final TodoTask task;
  const DeleteTodoTask ({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}

class ChangeTodoTask extends TodoTaskEvent {
  final TodoTask task;
  const ChangeTodoTask ({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}
