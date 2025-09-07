import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/core/widgets/custom_text_field.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
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
  List<Color> colors = [AppColors.primaryColor, Colors.orange, Colors.red];

  int selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title', style: TextStyles.titleStyle(fontSize: 16)),
            Gap(6),
            CustomTextField(
              controller: titleController,
              hint: 'Enter Task Title',
            ),
            Gap(10),
            Text('Description', style: TextStyles.titleStyle(fontSize: 16)),
            Gap(6),
            CustomTextField(
              controller: descriptionController,
              hint: 'Enter Task Description',
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
                  dateController.text =
                      DateFormat("yyyy-MM-dd").format(selectedDate);
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
                            initialTime: TimeOfDay.fromDateTime(DateTime.now()),
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
                            initialTime:
                                TimeOfDay.fromDateTime(DateTime.now()),
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
    );
  }
}
