import 'package:flutter/material.dart';
import 'package:practice_with_ostad/data/models/network_response.dart';
import 'package:practice_with_ostad/data/models/task_list_model.dart';
import 'package:practice_with_ostad/data/models/task_model.dart';
import 'package:practice_with_ostad/data/models/task_status_count.dart';
import 'package:practice_with_ostad/data/models/task_status_count_list.dart';
import 'package:practice_with_ostad/data/services/network_caller.dart';
import 'package:practice_with_ostad/data/utils/urls.dart';
import 'package:practice_with_ostad/ui/screens/add_new_task.dart';
import 'package:practice_with_ostad/ui/screens/task_card.dart';
import 'package:practice_with_ostad/ui/screens/task_summary_card.dart';
import 'package:practice_with_ostad/ui/widgets/center_circuler_progress_indicator.dart';
import 'package:practice_with_ostad/ui/widgets/snack_bar_message.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  List<TaskModel> _newTaskList = [];
  List<TaskStatusCount> _taskStatusCountList = [];
  bool _getNewTaskInProgress = false;

  Future<void> _getNewTasksList() async {
    _newTaskList.clear();
    _getNewTaskInProgress = true;
    setState(() {});
    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.getNewTasks);
    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      _newTaskList = taskListModel.taskList ?? [];
      // showSnackBarMessage(context, "New task retrieved successfully");
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getNewTaskInProgress = false;
    setState(() {});
  }

  Future<void> _getTaskSummary() async {
    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.taskStatusCount);
    if (response.isSuccess) {
      final TaskStatusCountList taskStatusCountList =
          TaskStatusCountList.fromJson(response.responseData);
      _taskStatusCountList = taskStatusCountList.taskStatusCountList ?? [];
      // showSnackBarMessage(context, "New task retrieved successfully");
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getNewTaskInProgress = false;
    setState(() {});
  }

  @override
  void initState() {
    _getTaskSummary();
    _getNewTasksList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onPressedFAB(),
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _getNewTasksList();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Visibility(
            visible: !_getNewTaskInProgress,
            replacement: const CenterCircularProgressIndicator(),
            child: Column(
              children: [
                _taskSummary(),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: _newTaskList.length,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        task: _newTaskList[index],
                        getTaskList: _getNewTasksList,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 8,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _taskSummary() {
    return Visibility(
      visible: _getNewTaskInProgress == false,
      replacement: const CenterCircularProgressIndicator(),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _taskStatusCountList
              .map(
                (e) => TaskSummaryCard(
                  title: e.sId ?? "",
                  count: e.sum ?? 0,
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  /// On Pressed FAB
  _onPressedFAB() async {
    final bool? shouldRefresh = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddNewTask()),
    );
    if (shouldRefresh == true) {
      _getNewTasksList();
    }
  }
}
