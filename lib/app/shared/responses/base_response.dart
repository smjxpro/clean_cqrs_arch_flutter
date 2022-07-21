import 'package:dartz/dartz.dart';

import '../enums/status.dart';
import '../failures/base_failure.dart';

class BaseResponse {
  Status status;
  final Failure? failure;

  BaseResponse({required this.status, this.failure});
}
