import 'package:flutter/material.dart';
import 'package:practice_with_ostad/data/models/network_response.dart';
import 'package:practice_with_ostad/data/services/network_caller.dart';
import 'package:practice_with_ostad/data/utils/urls.dart';
import 'package:practice_with_ostad/ui/widgets/app_bar_header.dart';
import 'package:practice_with_ostad/ui/widgets/snack_bar_message.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _shouldRefreshPreviousPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHeader(),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            return;
          }
          Navigator.pop(context, _shouldRefreshPreviousPage);
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "Add New Task",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 12,
                ),

                /// title form field
                TextFormField(
                  controller: _titleTEController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Please add title";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Title',
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),

                /// description form field
                TextFormField(
                  controller: _descriptionTEController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Please add Description";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Visibility(
                  visible: !_isLoading,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(
                    onPressed: _onPressedSubmitButton,
                    child: const Icon(Icons.arrow_circle_right_outlined),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onPressedSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _addNewTask();
    }
  }

  Future<void> _addNewTask() async {
    _isLoading = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "title": _titleTEController.text.trim(),
      "description": _descriptionTEController.text,
      "status": "New"
    };
    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.addNewTask,
      data: requestBody,
    );
    _isLoading = false;
    setState(() {});
    if (response.isSuccess) {
      _shouldRefreshPreviousPage = true;
      showSnackBarMessage(context, "New task added successfully");
      _clearTextField();
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  void _clearTextField() {
    _titleTEController.clear();
    _descriptionTEController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    _titleTEController.dispose();
    _descriptionTEController.dispose();
  }
}
