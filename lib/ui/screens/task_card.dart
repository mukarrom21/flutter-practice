import 'package:flutter/material.dart';
import 'package:practice_with_ostad/data/models/task_model.dart';

import '../utils/app_colors.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, this.task});
  final TaskModel? task;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: SizedBox(
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task?.title ?? "title",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                  task?.description ?? 'Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet. '),
              Text(task?.createdDate ?? "26/10/2022"),
              Row(
                children: [
                  const Chip(
                    label: Text('New', style: TextStyle(
                      color: AppColors.themeColor,
                    ),),
                    color: WidgetStatePropertyAll(Colors.white),
                    side: BorderSide(
                      color: AppColors.themeColor,
                      width: 1,
                    ),
                    shape: StadiumBorder(
                      side: BorderSide(
                        color: AppColors.themeColor,
                        width: 1,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.edit,
                      color: AppColors.themeColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
