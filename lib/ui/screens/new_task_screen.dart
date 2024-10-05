import 'package:flutter/material.dart';
import 'package:practice_with_ostad/ui/screens/task_card.dart';
import 'package:practice_with_ostad/ui/screens/task_summary_card.dart';

import '../utils/app_colors.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _taskSummary(),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: ListView.separated(
                itemCount: 50,
                itemBuilder: (context, index) {
                  return const TaskCard();
                }, separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 8,
                );
              },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _taskSummary() {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          TaskSummaryCard(
            title: 'New',
            count: 10,
          ),
          TaskSummaryCard(
            title: 'Completed',
            count: 10,
          ),
          TaskSummaryCard(
            title: 'Cancelled',
            count: 10,
          ),
          TaskSummaryCard(
            title: 'Progress',
            count: 10,
          ),
        ],
      ),
    );
  }
}

