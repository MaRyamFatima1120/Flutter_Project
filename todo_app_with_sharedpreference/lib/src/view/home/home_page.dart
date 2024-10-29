import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_with_sharedpreference/common/constants/global_variable.dart';
import 'package:todo_app_with_sharedpreference/common/constants/media_query_extension.dart';
import 'package:todo_app_with_sharedpreference/common/widgets/custom_button.dart';
import 'package:todo_app_with_sharedpreference/src/view-model/home_controller.dart';

import '../../../common/constants/validation.dart';
import '../../../common/widgets/custom_filter_chip.dart';
import '../../../common/widgets/custom_textform.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final HomeController controller = Get.put(HomeController());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

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
                  labelText: "title",
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
                  // Save the edited task details
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
          leading: IconButton(
        onPressed: () {
          scaffoldKey.currentState!.openDrawer();
        },
        icon: const Icon(Icons.short_text),
      )),
      drawer: const Drawer(),
      body: SingleChildScrollView(
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(

                children: [
                  Expanded(
                    flex: 4,
                    child: SearchBar(
                      padding: WidgetStateProperty.all(const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 16.0)),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        // Border color
                      )),
                      hintText: "Search...",
                      hintStyle:
                          WidgetStateProperty.all(textTheme(context).bodySmall),
                      backgroundColor:
                          WidgetStateProperty.all(colorScheme(context).secondary),
                      leading: const Icon(Icons.search),
                      onChanged: controller.onChangedFunction,
                      textStyle:
                          WidgetStateProperty.all(textTheme(context).bodySmall),
                    ),
                  ),
                  SizedBox(
                    width: MediaQueryExtension(context).width() * 0.01,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: MediaQueryExtension(context).height() * 0.085,
                      child: Card(
                          elevation: 5.0,
                          color: colorScheme(context).primary,
                          child: IconButton(
                              onPressed: controller.showFilterFunction,
                              icon: const Icon(
                                Icons.tune,
                                color: Colors.white,
                                size: 30,
                              ))),
                    ),
                  )
                ],
              ),
            ),
            Obx(
              () => controller.showFilter.value
                  ? Padding(
                      padding: EdgeInsets.all(
                          MediaQueryExtension(context).height() * 0.02),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Wrap(
                              spacing: 10.0,
                              runSpacing: 10.0,
                              children: [
                                FilterChipWidget(
                                  chipName: 'Recently Add',
                                  onSelectedFilter: (String? type) {
                                    controller.applyFilterType('recent');
                                  },
                                ),
                                FilterChipWidget(
                                  chipName: 'Pending',
                                  onSelectedFilter: (String? type) {
                                    controller.applyFilterType('pending');
                                  },
                                ),
                                FilterChipWidget(
                                  chipName: 'Completed',
                                  onSelectedFilter: (String? type) {
                                    controller.applyFilterType('completed');
                                  },
                                ),
                                FilterChipWidget(
                                  chipName: 'All',
                                  onSelectedFilter: (String? type) {
                                    controller.applyFilterType(null);
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 15.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: colorScheme(context).secondary,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomTextFormField(
                                labelText: "title",
                                keyboard: TextInputType.text,
                                controller: titleController,
                                validator: validateField,
                              ),
                              SizedBox(
                                height:
                                    MediaQueryExtension(context).height() * 0.03,
                              ),
                              CustomTextFormField(
                                labelText: "Description",
                                maxLines: 4,
                                keyboard: TextInputType.text,
                                controller: descriptionController,
                                validator: validateField,
                              ),
                            ])),
                  ),
                  CustomButton(
                    pressed: () {
                      if (_formKey.currentState!.validate()) {
                        //Update the controller's observable values with text from controllers
                        controller.title.value = titleController.text;
                        controller.description.value = descriptionController.text;
                        //saveData
                        controller.saveData().then((_) {
                          titleController.clear();
                          descriptionController.clear();
                        });
                      }
                    },
                    bgColor: colorScheme(context).primary,
                    child: Text(
                      "Save",
                      style: textTheme(context).bodySmall,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(

              height: MediaQueryExtension(context).height() * 0.04,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Obx(() {
                if (controller.searchData.isEmpty) {
                  return Text(
                                      "No Task is Available",
                                      style: textTheme(context).titleSmall,
                                    );
                } else {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(10.0),
                      itemCount: controller.searchData.length,
                      itemBuilder: (context, index) {
                        var item = controller.searchData[index];
                        bool isCompleted = item['completed'] ?? false;
                        return Card(
                          color: colorScheme(context).secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Set the border radius
                          ),
                          margin: const EdgeInsets.all(10.0),
                          child: ListTile(
                            leading: IconButton(
                                onPressed: () {
                                  controller.toggleTaskCompletion(index);
                                },
                                icon: Icon(
                                  isCompleted
                                      ? Icons.check_circle
                                      : Icons.circle_outlined,
                                  size: 20,
                                  color: colorScheme(context).primary,
                                )),
                            //tileColor: colorScheme(context).secondary,
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
                                  color: colorScheme(context)
                                      .onSecondary
                                      .withOpacity(0.9)),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      _openEditDialog(context, index);
                                    },
                                    icon: const Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () {
                                      controller.deleteData(index);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                    )),
                              ],
                            ),
                          ),
                        );
                      });
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
