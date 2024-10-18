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
      backgroundColor: Colors.white,
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
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Obx(() => DropdownButton<int>(
                  dropdownColor: Colors.white,
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
            SizedBox(
              height: 20,
            ),
            Obx(
              () => Text(
                'Due Date: ${dueDate.value}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
              ),
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
            SizedBox(
              height: 50.0,
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                ),
                onPressed: () async {
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
                child: Text(
                  'Save Task',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
