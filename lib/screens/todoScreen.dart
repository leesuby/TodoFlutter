import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';
import 'package:flutter_tasks_app/widgets/todoTaskList.dart';

import '../models/todoTask.dart';

// ignore: must_be_immutable
class TodoScreen extends StatelessWidget {
  TodoScreen({Key? key}) : super(key: key);

  TextEditingController titleTodoTaskController = TextEditingController();

  void _addTodoTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: AddTaskBottomSheet(
                    titleTodoTaskController: titleTodoTaskController),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoTaskBloc, TodoTaskState>(
      builder: (context, state) {
        List<TodoTask> todoTaskList = state.listTodoTasks;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Todo App'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add),
              )
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Chip(
                  label: Text(
                    'Tasks:',
                  ),
                ),
              ),
              TodoTasksList(todoTasks: todoTaskList),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _addTodoTask(context),
            tooltip: 'Add Task',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}

class AddTaskBottomSheet extends StatelessWidget {
  const AddTaskBottomSheet({
    Key? key,
    required this.titleTodoTaskController,
  }) : super(key: key);

  final TextEditingController titleTodoTaskController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          const Text(
            'Add Task',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
              controller: titleTodoTaskController,
              autofocus: true,
              decoration: const InputDecoration(
                label: Text('Title'),
                border: OutlineInputBorder(),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  var task = TodoTask(title: titleTodoTaskController.text);
                  context.read<TodoTaskBloc>().add(AddTodoTask(task: task));
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
