import 'package:flutter/material.dart';
import 'package:practice_with_ostad/ui/screens/task_card.dart';

class CancelledTaskScreen extends StatelessWidget {
  const CancelledTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
    );
  }
}
