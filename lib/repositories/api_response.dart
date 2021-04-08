import 'package:xlo/repositories/api_error.dart';

class ApiResponse {
  bool success;
  dynamic result;
  ApiError error;

  ApiResponse.success({this.result}) {
    success = true;
  }

  ApiResponse.error({this.error}) {
    success = false;
  }
}