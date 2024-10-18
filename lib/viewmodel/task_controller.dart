

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/data/task.dart';

class TaskController extends GetxController {

  var tasks = <Task>[].obs;
  late Box<Task> taskBox;

  @override
  void onInit() {
    super.onInit();
    taskBox = Hive.box<Task>('tasks');
    tasks.value = taskBox.values.toList();
  }

  void addTask(Task task){
    taskBox.add(task);
    tasks.add(task);
  }

  void editTask(int index,Task task){
    taskBox.putAt(index, task);
    tasks[index] = task;
  }

  void deleteTask(int index){
    taskBox.deleteAt(index);
    tasks.removeAt(index);
  }

  void sortTaskByPriority(){
    tasks.sort((a,b) => a.priority.compareTo(b.priority));
  }

  void sortTaskByDueDate(){
    tasks.sort((a,b) => a.dueDate.compareTo(b.dueDate));
  }

}