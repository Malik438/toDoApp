import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Model/TaskProvider.dart';
import '../constant/constant.dart';
import '../view/SingleToDoView.dart';

class AlToDos extends StatefulWidget {
  const AlToDos({Key? key});

  @override
  State<AlToDos> createState() => _AlToDosState();
}

class _AlToDosState extends State<AlToDos> {
  bool? flag = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var taskModel = context.watch<TaskModel>();
    List<Task> tasks =
        taskModel.todos.where((element) => element.isChecked == false).toList();

    return Container(
      color: const Color(0xffF5F5F5),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25), // Rounded corners
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.search), // Search icon
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Search",
                        focusColor: Colors.lightBlue,
                        border: InputBorder.none,
                      ),
                      controller: searchController,
                      onChanged: (String value) {
                        taskModel.onSearch(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 0, vertical: 20),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) => SingleToDoView(
                task: tasks[index],
                onDelete: () {
                  taskModel.updateStatus(tasks[index].id);
                },
              ),
              separatorBuilder: (context, index) => const SizedBox(
                height: 5,
              ),
              itemCount: tasks.length,
            ),
          ),
        ],
      ),
    );
  }
}
