class Urls {
  static const String _baseUrl = "http://152.42.163.176:2006/api/v1";
  static const String register = '$_baseUrl/Registration';
  static const String login = '$_baseUrl/Login';
  static const String addNewTask = '$_baseUrl/createTask';
  static const String getNewTasks = '$_baseUrl/listTaskByStatus/New';
  static const String getCompletedTasks = '$_baseUrl/listTaskByStatus/Completed';
  static const String getInProgressTasks = '$_baseUrl/listTaskByStatus/Progress';
  static const String getCancelledTasks = '$_baseUrl/listTaskByStatus/Cancelled';
}