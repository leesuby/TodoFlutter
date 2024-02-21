import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';
import 'package:flutter_tasks_app/widgets/todoTaskList.dart';
import 'package:intl/intl.dart';

import '../models/todoTask.dart';

// ignore: must_be_immutable
class TodoScreen extends StatefulWidget {
  TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  void _addTodoTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: const AddTaskBottomSheet(),
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
                onPressed: () => _addTodoTask(context),
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

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({Key? key}) : super(key: key);
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  TextEditingController timeTodoTaskController = TextEditingController();
  TextEditingController titleTodoTaskController = TextEditingController();

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
          TextField(
            controller: timeTodoTaskController,
            decoration: const InputDecoration(
                icon: Icon(Icons.timer), labelText: "Enter Time"),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101));

              if (pickedDate != null) {
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                setState(() {
                  timeTodoTaskController.text =
                      formattedDate; //set output date to TextField value.
                });
              }
            }
          ),
          const SizedBox(
            height: 10,
          ),
          if (timeTodoTaskController.text.isEmpty ||
              titleTodoTaskController.text.isEmpty)
            const Text(
              '*Necessary information fields cannot be left blank',
              style: TextStyle(color: Colors.deepOrange) ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  DateTime parsedDate =
                      DateTime.parse(timeTodoTaskController.text);
                  var task = TodoTask(
                      title: titleTodoTaskController.text, time: parsedDate);
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
