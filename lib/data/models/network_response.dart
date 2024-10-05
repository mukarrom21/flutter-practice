class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  dynamic response;
  String errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.response,
    this.errorMessage = "Something went wrong.",
  });
}
