import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/data/task.dart';
import 'package:todo_app/viewmodel/task_controller.dart';

class TaskDetailsView extends StatelessWidget {
  final TaskController taskController = Get.find();
  final int? index;
  final Task? task;

  TaskDetailsView({this.index, this.task});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final priority = 0.obs;
  final dueDate = DateTime.now().obs;

  @override
  Widget build(BuildContext context) {
    if (task != null) {
      titleController.text = task!.title;
      descriptionController.text = task!.description;
      priority.value = task!.priority;
      dueDate.value = task!.dueDate;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(task != null ? 'Edit Task' : 'Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            Obx(() => DropdownButton<int>(
              value: priority.value,
                  items: [
                    DropdownMenuItem(
                      child: Text('Low'),
                      value: 0,
                    ),
                    DropdownMenuItem(
                      child: Text('Medium'),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text('High'),
                      value: 2,
                    ),
                  ],
                  onChanged: (value) {
                    priority.value = value!;
                  },
                )),
            Obx(() => Text('Due Date: ${dueDate.value}')),
            ElevatedButton(
              onPressed: () async {
                final selectDate = await showDatePicker(
                  context: context,
                  initialDate: dueDate.value,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (selectDate != null) {
                  dueDate.value = selectDate;
                }
              },
              child: Text('Pick Due Date'),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                final newTask = Task(
                    title: titleController.text,
                    description: descriptionController.text,
                    priority: priority.value,
                    dueDate: dueDate.value);
                if (task != null) {
                  taskController.editTask(index!, newTask);
                } else {
                  taskController.addTask(newTask);
                }
                Get.back();
              },
              child: Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }
}
