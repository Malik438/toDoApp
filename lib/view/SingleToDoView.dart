import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/TaskProvider.dart';

class SingleToDoView extends StatefulWidget {
  final Task task;
  final Function onDelete;

  const SingleToDoView({Key? key, required this.task, required this.onDelete})
      : super(key: key);

  @override
  State<SingleToDoView> createState() => _SingleToDoViewState();
}

class _SingleToDoViewState extends State<SingleToDoView> {
  TextEditingController nameUpdateController = TextEditingController();

  TextEditingController authorUpdateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    nameUpdateController.text = widget.task.name!;
    authorUpdateController.text = widget.task.author!;
  }

  @override
  Widget build(BuildContext context) {
    var taskModel = context.watch<TaskModel>();

    print("i am here single");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Theme(
              data: ThemeData(
                unselectedWidgetColor:
                    Colors.blue, // Border color when unchecked
                checkboxTheme: CheckboxThemeData(
                  fillColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return Colors.blue; // Fill color when checked
                    }
                    return Colors.blue[10000]; // Fill color when unchecked
                  }),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        4.0), // Adjust the radius as needed
                    side: const BorderSide(
                      color: Colors.blue, // Border color when checked
                    ),
                  ),
                ),
              ),
              child: Checkbox(
                checkColor: Colors.black,
                value: widget.task.isChecked,
                onChanged: (bool? val) {
                  widget.onDelete.call();
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Name: ${widget.task.name}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Author: ${widget.task.author}',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Time: ${widget.task.time}',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue[200]),
              onPressed: () async {
                var flag = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('New ToDO'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: nameUpdateController,
                            decoration:
                                const InputDecoration(labelText: 'Name '),
                          ),
                          TextField(
                            controller: authorUpdateController,
                            decoration:
                                const InputDecoration(labelText: 'Author '),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Update'),
                          onPressed: () {
                            {
                              taskModel.updateTodo(
                                Task(
                                  time: widget.task.time,
                                  isChecked: widget.task.isChecked,
                                  id: widget.task.id,
                                  name: nameUpdateController.text,
                                  author: authorUpdateController.text,
                                ),
                              );
                              Navigator.pop(context, true);
                            }
                          },
                        ),
                      ],
                    );
                    ;
                  },
                );
                if (flag != null && flag) {
                  taskModel.getData();
                }
              },
            ),
          ],
        ),
      ),
    );

    // return ListTile(
    //   leading:   Checkbox(
    //     checkColor: Colors.black,
    //     fillColor: MaterialStateProperty.resolveWith(getColor),
    //     value: widget.task.isChecked,
    //     onChanged: (bool? val) {
    //       widget.onDelete.call();
    //     },
    //   ),
    //   title: Column(
    //     children: [
    //       SizedBox(
    //         width: 400 ,
    //         child: SingleChildScrollView(
    //           scrollDirection: Axis.horizontal,
    //           child: Row(
    //             children: [
    //
    //               Text( "[name :${widget.task.name},",
    //                 overflow: TextOverflow.ellipsis,
    //                 maxLines: 2,
    //               ),
    //               const SizedBox(
    //                 width: 5,
    //               ),
    //
    //               Text(
    //                 "Author :${widget.task.author},",
    //                 overflow: TextOverflow.ellipsis,
    //                 maxLines: 2,
    //               ),
    //               const SizedBox(
    //                 width: 5,
    //               ),
    //               Text( "Time : ${widget.task.time} ]",
    //                 overflow: TextOverflow.ellipsis,
    //                 maxLines: 2,
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    //   trailing: IconButton(
    //     icon: const Icon(Icons.edit),
    //     onPressed: (){
    //
    //     },
    //   ),
    // );
  }
}
