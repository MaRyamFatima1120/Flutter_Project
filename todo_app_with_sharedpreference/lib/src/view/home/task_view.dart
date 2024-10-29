import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_with_sharedpreference/common/constants/media_query_extension.dart';
import '../../../common/constants/global_variable.dart';
import '../../../common/constants/validation.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_textform.dart';
import '../../view-model/home_controller.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final HomeController controller = Get.put(HomeController());

  void _openEditDialog(BuildContext context, int index) {
    final titleController =
        TextEditingController(text: controller.addData[index]['title']);
    final descriptionController =
        TextEditingController(text: controller.addData[index]['description']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: colorScheme(context).secondary,
          title: Center(
              child: Text(
            "Edit Task",
            style: textTheme(context).titleSmall,
          )),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextFormField(
                labelText: "Title",
                keyboard: TextInputType.text,
                controller: titleController,
                validator: validateField,
              ),
              SizedBox(
                height: MediaQueryExtension(context).height() * 0.03,
              ),
              CustomTextFormField(
                labelText: "Description",
                maxLines: 4,
                keyboard: TextInputType.text,
                controller: descriptionController,
                validator: validateField,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Cancel",
                style: textTheme(context).titleSmall?.copyWith(
                    fontSize: 20, color: colorScheme(context).primary),
              ),
            ),
            CustomButton(
              pressed: () {
                controller.editTask(
                    index, titleController.text, descriptionController.text);
                Navigator.of(context).pop();
              },
              bgColor: colorScheme(context).primary,
              child: Text(
                "Save",
                style: textTheme(context).titleSmall?.copyWith(fontSize: 14),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Task List
          Expanded(
            child: Obx(() {
              // Separate tasks into completed and pending
              List<Map<String, dynamic>> completedTasks = controller.addData
                  .where((task) => task['completed'] == true)
                  .toList();
              List<Map<String, dynamic>> pendingTasks = controller.addData
                  .where((task) => task['completed'] == false)
                  .toList();

              // Sort recent tasks by timestamp in descending order
              List<Map<String, dynamic>> recentTasks =
                  List<Map<String, dynamic>>.from(controller.addData);
              recentTasks.sort((a, b) => DateTime.parse(b['timeStamp'])
                  .compareTo(DateTime.parse(a['timeStamp'])));

              return ListView(
                children: [
                  if (recentTasks.isNotEmpty)
                    _buildTaskSection(context, "Recent Tasks", recentTasks),
                  if (pendingTasks.isNotEmpty)
                    _buildTaskSection(context, "Pending Tasks", pendingTasks),
                  if (completedTasks.isNotEmpty)
                    _buildTaskSection(
                        context, "Completed Tasks", completedTasks),
                  if (completedTasks.isEmpty &&
                      pendingTasks.isEmpty &&
                      recentTasks.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              'No tasks available.',
                              style: textTheme(context).titleSmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskSection(
      BuildContext context, String title, List<Map<String, dynamic>> tasks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            title,
            style: textTheme(context).titleSmall?.copyWith(fontSize: 18),
          ),
        ),
        ListView.builder(
          itemCount: tasks.length,
          shrinkWrap: true,
          physics:const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var item = tasks[index];
            bool isCompleted = item['completed'] ?? false;
            return Card(
              color: colorScheme(context).secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: const EdgeInsets.all(10.0),
              child: ListTile(
                leading: IconButton(
                    onPressed: () {
                      controller.toggleTaskCompletion(
                          controller.addData.indexOf(item));
                    },
                    icon: Icon(
                      isCompleted ? Icons.check_circle : Icons.circle_outlined,
                      size: 20,
                      color: colorScheme(context).primary,
                    )),
                title: Text(
                  item['title'],
                  style: textTheme(context).titleSmall?.copyWith(
                      decoration: isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      decorationColor: colorScheme(context).onPrimary,
                      decorationThickness: 5),
                ),
                subtitle: Text(
                  item['description'],
                  style: textTheme(context).titleSmall?.copyWith(
                      fontSize: 12,
                      color: colorScheme(context).onSecondary.withOpacity(0.9)),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          _openEditDialog(
                              context, controller.addData.indexOf(item));
                        },
                        icon: const Icon(Icons.edit)),
                    IconButton(
                      onPressed: () {
                        controller.deleteData(controller.addData.indexOf(item));
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
