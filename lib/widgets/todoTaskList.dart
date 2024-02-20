import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tasks_app/models/todoTask.dart';

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
            trailing: Checkbox(
              value: task.isDone,
              onChanged: (value) {},
            ),
          );
        }),
    );
  }
}
