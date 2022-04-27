import 'package:clean_cqrs_arch_flutter/app/shared/enums/status.dart';
import 'package:clean_cqrs_arch_flutter/app/shared/failures/base_failure.dart';

import '../../domain/entities/todo.dart';

class TodoListResponse {
  Status status;
  final Failure? failure;
  final List<Todo>? todos;

  TodoListResponse({this.status = Status.initial, this.failure, this.todos});
}
