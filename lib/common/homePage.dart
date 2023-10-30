import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Model/TaskProvider.dart';
import '../Screen/AllToDos.dart';
import '../Screen/DoneToDos.dart';
import '../constant/constant.dart';
import 'package:intl/intl.dart';



class Todo extends StatefulWidget {
  static const IconData done = IconData(0xe1f6, fontFamily: 'MaterialIcons');

  Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo>  with TickerProviderStateMixin {

  late TabController _controller;

  TextEditingController addTaskNameController = TextEditingController();
  TextEditingController addAuthorController = TextEditingController();

  String formattedTime = DateFormat('hh:mm a').format(DateTime.now());

  clearData() {
    addTaskNameController.clear();
    addAuthorController.clear();
  }
  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);

    super.initState();
  }



  @override
  Widget build(BuildContext context) {

   return ChangeNotifierProvider<TaskModel>(
     create: (context) => TaskModel(),
     builder: (context,child){
       var taskModel = context.watch<TaskModel>();
       return Scaffold(
         appBar: AppBar(
           title: const Text("Todo App"),
           bottom: TabBar(
             controller: _controller,
             tabs: [
               Row(
                 children: const [
                   Tab(icon: Icon(Icons.assessment)),
                   SizedBox(
                     width: 3,
                   ),
                   Text("ToDo"),
                 ],
               ),
               Row(
                 children: const [
                   Tab(icon: Icon(Todo.done)),
                   SizedBox(

                     width: 3,
                   ),
                   Text("Done")
                 ],
               ),
             ],
           ),
         ),
         body: TabBarView(
           controller: _controller,
           children: const [
             AlToDos(),
             DoneToDos(),
           ],
         ),
         floatingActionButton: GestureDetector(
           onTap: () {
             showDialog(
               context: context,
               builder: (BuildContext context) {
                 return   AlertDialog(
                   title: const Text('New ToDO'),
                   content: Column(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       TextField(
                         controller: addTaskNameController,
                         decoration: const InputDecoration(labelText: 'Name '),
                       ),
                       TextField(
                         controller: addAuthorController,
                         decoration: const InputDecoration(labelText: 'Author '),
                       ),
                     ],
                   ),
                   actions: <Widget>[
                     TextButton(
                       child: const Text('Submit'),
                       onPressed: () {
                         {

                           taskModel.addUser(
                               Task(name : addTaskNameController.text.toString(),
                                   author: addAuthorController.text.toString(),
                                   time: formattedTime ,
                                    isChecked:  false ,
                                   ));

                           clearData();
                           Navigator.pop(context);
                         }
                       },
                     ),
                   ],
                 );
                 ;
               },
             );

           },
           child: const Icon(Icons.add),
         ),
       );


     }
   );

  }


}


