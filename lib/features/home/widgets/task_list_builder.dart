import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/services/local_helper.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/features/home/widgets/task_item.dart';

class TaskListBuilder extends StatefulWidget {
  const TaskListBuilder({super.key});

  @override
  State<TaskListBuilder> createState() => _TaskListBuilderState();
}

class _TaskListBuilderState extends State<TaskListBuilder> {
  String selectedDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          DatePicker(
            DateTime.now().subtract(Duration(days: 1)),
            height: 100,
            width: 70,
            initialSelectedDate: DateTime.now(),
            selectionColor: AppColors.primaryColor,
            selectedTextColor: Colors.white,
            monthTextStyle: TextStyles.smallStyle(),
            dayTextStyle: TextStyles.smallStyle(),
            dateTextStyle: TextStyles.bodyStyle(fontWeight: FontWeight.w600),
            onDateChange: (date) {
              setState(() {
                selectedDate = DateFormat("yyyy-MM-dd").format(date);
              });
            },
          ),
          Gap(15),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: LocalHelper.taskbox.listenable(),
              builder: (context, box, child) {
                List<TaskModel> filteredTasks = [];
                for (var task in box.values) {
                  if (task.date == selectedDate) {
                    filteredTasks.add(task);
                  }
                }

                if (filteredTasks.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(AppImages.empty),
                            Text(
                              'No tasks for this date',
                              style: TextStyles.bodyStyle(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }

                return ListView.separated(
                  itemBuilder: (context, index) {
                    return TaskItem(
                      model: filteredTasks[index],
                      onComplete: () {
                        box.put(filteredTasks[index].id , filteredTasks[index].copyWith(isCompleted: true , color: 3)
                        // TaskModel(
                        //   id: filteredTasks[index].id,
                        //   title: filteredTasks[index].title,
                        //   description: filteredTasks[index].description,
                        //   date: filteredTasks[index].date,
                        //   startTime: filteredTasks[index].startTime,
                        //   endTime: filteredTasks[index].endTime,
                        //   color: filteredTasks[index].color,
                        //   isCompleted: true, 
                        // )
                        );
                      },
                      onDelete: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog.adaptive(
                              title: Text('Delete Task', style: TextStyles.titleStyle()),
                              content: Text('Are you sure you want to delete this task?', style: TextStyles.bodyStyle()),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    box.delete(filteredTasks[index].id);
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Delete',
                                    style: TextStyles.bodyStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancel'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                  itemCount: filteredTasks.length,
                  separatorBuilder: (context, index) => const Gap(10),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
