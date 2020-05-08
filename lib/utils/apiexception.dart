
import 'package:flutter/foundation.dart';

class ApiException implements Exception {

  final String errorMsg;

  ApiException(this.errorMsg);

  @override
  String toString() {
    return this.errorMsg;
  }
}