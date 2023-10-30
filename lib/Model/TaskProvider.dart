import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../constant/constant.dart';

final String columnId = 'id';
final String columnName = 'name';
final String columnTime = 'time';
final String columnAuthor = 'author';
final String columnisChecked = 'isChecked';

class TaskModel extends ChangeNotifier {
  TaskModel() {
    print("fetching data");
    getData();
  }

  List<Task> tasks = [];

  CollectionReference tasksCollection = firestore.collection("Task");

  List<Task> filteredData = [];

  List<Task> get todos => searchText?.isNotEmpty == true ? filteredData : tasks;

  bool? isFilteredListFlag = false;
  String? searchText;

  void onSearch(String newValue) {
    searchText = newValue;
    filteredData = filterData(searchText!, tasks);
    notifyListeners();
  }

  Future<void> addUser(Task task) async {
    tasksCollection.add(task.toMap());
    tasks.add(task);
    if (searchText?.isNotEmpty == true)
      filteredData = filterData(searchText!, tasks);

    notifyListeners();
  }

  List<Task> filterData(String searchText, List<Task> tasks) {
    return tasks
        .where((element) =>
            element.isChecked == false &&
            element.name?.toLowerCase().toString().trim() ==
                searchText.toLowerCase().trim())
        .toList();
  }

  Future getData() async {
    QuerySnapshot taskdoc = await tasksCollection.get();
    tasks.clear();
    taskdoc.docs.forEach((userDoc) {
      final taskData = userDoc.data() as Map<String, dynamic>;
      final task = Task.fromMap(taskData, userDoc.id);
      tasks.add(task);
    });
    notifyListeners();
  }

  Task getTask(int index) {
    return tasks.elementAt(index);
  }

  Future<void> updateStatus(String? docId) async {
    bool? flag = tasks[getIndexByDocId(docId)].isChecked;
    tasksCollection.doc(docId).update({'isChecked': !flag!});

    tasks[getIndexByDocId(docId)].isChecked = !flag!;

    if (searchText?.isNotEmpty == true)
      filteredData = filterData(searchText!, tasks);

    notifyListeners();
  }

  Future<void> updateTodo(Task task) async {
    tasksCollection.doc(task.id).update(task.toMap());

    if (searchText?.isNotEmpty == true)
      filteredData = filterData(searchText!, tasks);

    notifyListeners();
  }

  getIndexByDocId(String? docId) {
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].id == docId) {
        return i;
      }
    }
  }
}

class Task {
  final String? id;

  String? name;

  final String? author;

  final String? time;

  bool? isChecked;

  Task({this.id, this.name, this.author, this.time, this.isChecked});

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnName: name,
      columnAuthor: author,
      columnTime: time,
      columnisChecked: isChecked,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  factory Task.fromMap(Map<String, dynamic> map, String id) {
    return Task(
        id: id,
        name: map[columnName] as String?,
        author: map[columnAuthor] as String?,
        time: map[columnTime] as String?,
        isChecked: map[columnisChecked]);
  }
}
