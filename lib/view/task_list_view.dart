import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/view/task_details_view.dart';
import 'package:todo_app/viewmodel/task_controller.dart';

class TaskListView extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('To-Do List'),
        actions: [
          IconButton(
              onPressed: () {
                taskController.sortTaskByPriority();
              },
              icon: Icon(Icons.sort)),
        ],
      ),
      body: Obx(() {
        return ListView.builder(
            itemCount: taskController.tasks.length,
            itemBuilder: (context, index) {
              final task = taskController.tasks[index];
              return ListTile(
                title: Text(
                  task.title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Due: ${task.dueDate} - Priority : ${task.priority}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
                onTap: () {
                  Get.to(() => TaskDetailsView(index: index, task: task));
                },
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    taskController.deleteTask(index);
                  },
                ),
              );
            });
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => TaskDetailsView());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
