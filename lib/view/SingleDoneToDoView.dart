import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/TaskProvider.dart';

class DoneToDoView extends StatefulWidget {
  final Task task;
  final Function onDelete;

  const DoneToDoView({Key? key, required this.task, required this.onDelete})
      : super(key: key);

  @override
  State<DoneToDoView> createState() => _DoneToDoView();
}

class _DoneToDoView extends State<DoneToDoView> {
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
                unselectedWidgetColor: Colors.blue,
                // Border color when unchecked
                checkboxTheme: CheckboxThemeData(
                  fillColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return Colors.blue; // Fill color when checked
                    }
                    return Colors.blue[10000]; // Fill color when unchecked
                  }),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    // Adjust the radius as needed
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
          ],
        ),
      ),
    );
  }
}
