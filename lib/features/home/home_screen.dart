import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati/features/home/widgets/home_headear.dart';
import 'package:taskati/features/home/widgets/task_list_builder.dart';
import 'package:taskati/features/home/widgets/today_headear.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              HomeHeadear(),
              Gap(20),
              TodayHeader(),
              Gap(20),
             
              TaskListBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}
