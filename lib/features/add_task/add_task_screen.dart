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
  const AddEditTaskScreen({super.key, this.model});
  final TaskModel? model;

  @override
  State<AddEditTaskScreen> createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var dateController = TextEditingController(
    text: DateFormat("yyyy-MM-dd").format(DateTime.now()),
  );
  var startTimeController = TextEditingController(
    text: DateFormat("hh:mm a").format(DateTime.now()),
  );
  var endTimeController = TextEditingController(
    text: DateFormat(
      "hh:mm a",
    ).format(DateTime.now().add(Duration(minutes: 15))),
  );

  void initState() {
    titleController.text = widget.model?.title ?? '';
    descriptionController.text = widget.model?.description ?? '';
    dateController.text = widget.model?.date ?? '';
    startTimeController.text = widget.model?.startTime ?? DateFormat("hh:mm a").format(DateTime.now());
    endTimeController.text = widget.model?.endTime ?? DateFormat("hh:mm a").format(DateTime.now().add(Duration(minutes: 15)));
    selectedColor = widget.model?.color ?? 0;
    super.initState();
  }
  var formKey = GlobalKey<FormState>();

  

  int selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.model != null ? 'Edit Task' :'Add Task')),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 5),
          child: MainButton(text: widget.model != null ? 'Update Task' : 'Create Task', onPressed: () async {
            String id =  widget.model != null ? widget.model?.id ?? "" : DateTime.now().millisecondsSinceEpoch.toString() + titleController.text;
            if(formKey.currentState!.validate())
            {
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
