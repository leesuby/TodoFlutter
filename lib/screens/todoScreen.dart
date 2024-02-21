import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_tasks_app/blocs/bloc/bloc/todo_task_bloc.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';
import 'package:flutter_tasks_app/widgets/todoTaskList.dart';
import 'package:intl/intl.dart';

import '../models/todoTask.dart';

// ignore: must_be_immutable
const List<Widget> filterType = <Widget>[
  Text('All'),
  Text('Today'),
  Text('Upcoming')
];

class TodoScreen extends StatefulWidget {
  TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final List<bool> _selectedFilter = <bool>[true, false, false];
  TextEditingController searchController = TextEditingController();
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
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
                width: 360,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 246, 217, 252),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Search for Items",
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: Colors.black,
                    contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  ),
                  onChanged: (value) {
                    setState(() {
                      context
                          .read<TodoTaskBloc>()
                          .add(SearchTodoTask(keyword: value));
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ToggleButtons(
                direction: Axis.horizontal,
                onPressed: (int index) {
                  setState(() {
                    // The button that is tapped is set to true, and the others to false.
                    for (int i = 0; i < _selectedFilter.length; i++) {
                      _selectedFilter[i] = i == index;
                    }

                    if (index == 0)
                      context
                          .read<TodoTaskBloc>()
                          .add(SortTodoTask(sortType: 0));

                    if (index == 1)
                      context
                          .read<TodoTaskBloc>()
                          .add(SortTodoTask(sortType: -1));

                    if (index == 2)
                      context
                          .read<TodoTaskBloc>()
                          .add(SortTodoTask(sortType: 1));
                  });
                },
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                selectedBorderColor: Color.fromARGB(255, 227, 150, 238),
                selectedColor: Colors.white,
                fillColor: Color.fromARGB(255, 244, 173, 239),
                color: Color.fromARGB(255, 190, 42, 161),
                constraints: const BoxConstraints(
                  minHeight: 40.0,
                  minWidth: 80.0,
                ),
                isSelected: _selectedFilter,
                children: filterType,
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
               DatePicker.showDateTimePicker(context, showTitleActions: true,
                      onChanged: (date) {
                    print('change $date in time zone ' +
                        date.timeZoneOffset.inHours.toString());
                  }, onConfirm: (date) {
                    String formattedDate =
                      DateFormat('yyyy-MM-dd hh:mm:ss').format(date);
                  setState(() {
                    timeTodoTaskController.text =
                        formattedDate; //set output date to TextField value.
                  });
                  }, currentTime: DateTime.now());
                // DateTime? pickedDate = await showDatePicker(
                //     context: context,
                //     initialDate: DateTime.now(),
                //     firstDate: DateTime(2000),
                //     lastDate: DateTime(2101));

                // if (pickedDate != null) {
                //   String formattedDate =
                //       DateFormat('yyyy-MM-dd').format(pickedDate);
                //   setState(() {
                //     timeTodoTaskController.text =
                //         formattedDate; //set output date to TextField value.
                //   });
                // }
              }),
          const SizedBox(
            height: 10,
          ),
          if (timeTodoTaskController.text.isEmpty ||
              titleTodoTaskController.text.isEmpty)
            const Text('*Necessary information fields cannot be left blank',
                style: TextStyle(color: Colors.deepOrange)),
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
