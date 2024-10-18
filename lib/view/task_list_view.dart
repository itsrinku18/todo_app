
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/view/task_details_view.dart';
import 'package:todo_app/viewmodel/task_controller.dart';

class TaskListView extends StatelessWidget {

  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        actions: [
          IconButton(
              onPressed: (){
                taskController.sortTaskByPriority();
              },
              icon: Icon(Icons.sort)),
        ],
      ),
      body: Obx((){
        return ListView.builder(
          itemCount: taskController.tasks.length,
            itemBuilder: (context,index){
          final task = taskController.tasks[index];
          return ListTile(
            title: Text(task.title),
            subtitle: Text('Due: ${task.dueDate} - Priority : ${task.priority}'),
            onTap: (){
              Get.to(() => TaskDetailsView(index: index,task: task));
            },
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: (){
                taskController.deleteTask(index);
              },
            ),

          );
        });
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(()=> TaskDetailsView());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
