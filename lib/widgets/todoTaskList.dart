import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tasks_app/blocs/bloc/bloc/todo_task_bloc.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';
import 'package:flutter_tasks_app/models/todoTask.dart';
import 'package:intl/intl.dart';

class TodoTasksList extends StatelessWidget {
  const TodoTasksList({
    Key? key,
    required this.todoTasks,
  }) : super(key: key);

  final List<TodoTask> todoTasks;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: todoTasks.length,
        itemBuilder: (context,index) {
          var task = todoTasks[index]; 
          return ListTile(
            title: Text(task.title),
            subtitle: Text(task.time == null? "No Time" : "Time: " + DateFormat('yyyy-MM-dd').format(task.time)),
            trailing: Checkbox(
              value: task.isDone,
              onChanged: (value) {
                context.read<TodoTaskBloc>().add(UpdateTodoTask(task: task));
              },
            ),
            onLongPress: () => context.read<TodoTaskBloc>().add(DeleteTodoTask(task: task)),
          );
        }),
    );
  }
}
