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

class SortTodoTask extends TodoTaskEvent {
  final int sortType; // <0: Today, 0: All, >0 Upcoming
  const SortTodoTask ({
    required this.sortType
  });

  @override
  List<Object> get props => [sortType];
}

class SearchTodoTask extends TodoTaskEvent {
  final String keyword;
  const SearchTodoTask ({
    required this.keyword
  });

  @override
  List<Object> get props => [keyword];
}

class ResetTodoTask extends TodoTaskEvent {
  const ResetTodoTask ();

  @override
  List<Object> get props => [];
}
