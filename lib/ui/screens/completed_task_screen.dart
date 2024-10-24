import 'package:flutter/material.dart';
import 'package:practice_with_ostad/data/models/network_response.dart';
import 'package:practice_with_ostad/data/models/task_list_model.dart';
import 'package:practice_with_ostad/data/models/task_model.dart';
import 'package:practice_with_ostad/data/services/network_caller.dart';
import 'package:practice_with_ostad/data/utils/urls.dart';
import 'package:practice_with_ostad/ui/screens/task_card.dart';
import 'package:practice_with_ostad/ui/widgets/center_circuler_progress_indicator.dart';
import 'package:practice_with_ostad/ui/widgets/snack_bar_message.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  List<TaskModel> _completedTaskList = [];
  bool _getCompletedTaskInProgress = false;

  Future<void> _getCompletedTasks() async {
    _completedTaskList.clear();
    _getCompletedTaskInProgress = true;
    setState(() {});
    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.getCompletedTasks);
    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      _completedTaskList = taskListModel.taskList ?? [];
      showSnackBarMessage(context, "Completed task retrieved successfully");
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getCompletedTaskInProgress = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    _getCompletedTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_getCompletedTaskInProgress,
      replacement: const CenterCircularProgressIndicator(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: _completedTaskList.length,
          itemBuilder: (context, index) {
            return TaskCard(task: _completedTaskList[index],);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 8,
            );
          },
        ),
      ),
    );
  }
}
