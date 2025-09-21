import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/constants/task_color.dart';
import 'package:taskati/core/functions/navigation.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/services/local_helper.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/core/widgets/custom_text_field.dart';
import 'package:taskati/core/widgets/main_button.dart';
import 'package:taskati/features/home/home_screen.dart';

class AddEditTaskScreen extends StatefulWidget {
  const AddEditTaskScreen({super.key, this.task});
  final TaskModel? task;

  @override
  State<AddEditTaskScreen> createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var dateController = TextEditingController();
  var startTimeController = TextEditingController();
  var endTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      titleController.text = widget.task!.title ?? '';
      descriptionController.text = widget.task!.description ?? '';
      dateController.text = widget.task!.date ?? '';
      startTimeController.text = widget.task!.startTime ?? '';
      endTimeController.text = widget.task!.endTime ?? '';
      selectedColor = widget.task!.color ?? 0;
    } else {
      dateController.text = DateFormat("yyyy-MM-dd").format(DateTime.now());
      startTimeController.text = DateFormat("hh:mm a").format(DateTime.now());
      endTimeController.text = DateFormat("hh:mm a").format(DateTime.now().add(Duration(minutes: 15)));
    }
  }


  var formKey = GlobalKey<FormState>();

  

  int selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    bool isEditing = widget.task != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Task' : 'Add Task')),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 5),
          child: MainButton(text: isEditing ? 'Update Task' : 'Create Task', onPressed: () async {
            if(formKey.currentState!.validate())
            {
              if (isEditing) {
                await LocalHelper.putTask(widget.task!.id!, TaskModel(
                  id: widget.task!.id,
                  title: titleController.text,
                  description: descriptionController.text,
                  date: dateController.text,
                  startTime: startTimeController.text,
                  endTime: endTimeController.text,
                  color: selectedColor,
                  isCompleted: widget.task!.isCompleted
                ));
              } else {
                String id = DateTime.now().millisecondsSinceEpoch.toString() + titleController.text;
                await LocalHelper.putTask(id, TaskModel(
                  id: id,
                  title: titleController.text,
                  description: descriptionController.text,
                  date: dateController.text,
                  startTime: startTimeController.text,
                  endTime: endTimeController.text,
                  color: selectedColor,
                  isCompleted: false
                ));
              }
              pushAndRemoveUntil(context, HomeScreen());
            }
          }),
        ),
      ),
      body: _addTaskBody(context),
    );
  }

  SingleChildScrollView _addTaskBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Title', style: TextStyles.titleStyle(fontSize: 16)),
              Gap(6),
              CustomTextField(
                controller: titleController,
                hint: 'Enter Task Title',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter task title';
                  }
                  return null;
                },
              ),
              Gap(10),
              Text('Description', style: TextStyles.titleStyle(fontSize: 16)),
              Gap(6),
              CustomTextField(
                controller: descriptionController,
                hint: 'Enter Task Description(optional)',
                maxLines: 3,
              ),
              Gap(10),
              Text('Date', style: TextStyles.titleStyle(fontSize: 16)),
              Gap(6),
              CustomTextField(
                controller: dateController,
                hint: 'Select Date',
                readOnly: true,
                onTap: () async {
                  var selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2030),
                  );
                  if (selectedDate != null) {
                    dateController.text = DateFormat(
                      "yyyy-MM-dd",
                    ).format(selectedDate);
                  }
                },
                suffixIcon: Icon(
                  Icons.calendar_month_outlined,
                  color: AppColors.primaryColor,
                ),
              ),
              Gap(10),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Start Time',
                          style: TextStyles.titleStyle(fontSize: 16),
                        ),
                        Gap(6),
                        CustomTextField(
                          controller: startTimeController,
                          hint: 'Select Start Time',
                          readOnly: true,
                          onTap: () async {
                            var selectedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(
                                DateTime.now(),
                              ),
                            );
                            if (selectedTime != null) {
                              var formattedTime = selectedTime.format(context);
                              startTimeController.text = formattedTime;
                            }
                          },
                          suffixIcon: Icon(
                            Icons.watch_later_outlined,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'End Time',
                          style: TextStyles.titleStyle(fontSize: 16),
                        ),
                        Gap(6),
                        CustomTextField(
                          controller: endTimeController,
                          hint: 'Select End Time',
                          readOnly: true,
                          onTap: () async {
                            var selectedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(
                                DateTime.now(),
                              ),
                            );
                            if (selectedTime != null) {
                              var formattedTime = selectedTime.format(context);
                              endTimeController.text = formattedTime;
                            }
                          },
                          suffixIcon: Icon(
                            Icons.watch_later_outlined,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Gap(20),
              Row(
                spacing: 8,
                children: [
                  ...List.generate(3, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColor = index;
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: colors[index],
                        child: selectedColor == index
                            ? Icon(Icons.check, color: Colors.white, size: 16)
                            : null,
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
