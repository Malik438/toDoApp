import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant/constant.dart';
import '../view/SingleDoneToDoView.dart';
import '../Model/TaskProvider.dart';
import '../view/SingleToDoView.dart';

class DoneToDos extends StatefulWidget {
  const DoneToDos({super.key});

  @override
  State<DoneToDos> createState() => _DoneToDosState();
}

class _DoneToDosState extends State<DoneToDos> {
  @override
  Widget build(BuildContext context) {
    var taskModel = context.watch<TaskModel>();
    List<Task> tasks =
        taskModel.tasks.where((element) => element.isChecked!).toList();

    return Container(
      color: Colors.brown,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
        child: ListView.separated(
            itemBuilder: (context, index) => DoneToDoView(
                  task: tasks[index],
                  onDelete: () {
                    setState(() {
                      taskModel.updateStatus(tasks[index].id);
                    });
                  },
                )
            // dependency injection
            ,
            separatorBuilder: (context, index) => const SizedBox(
                  height: 5,
                ),
            itemCount: tasks.length),
      ),
    );
  }
}
