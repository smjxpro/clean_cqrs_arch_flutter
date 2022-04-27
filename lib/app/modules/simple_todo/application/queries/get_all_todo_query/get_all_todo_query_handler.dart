import 'package:clean_cqrs_arch_flutter/app/modules/simple_todo/application/responses/todo_list_response.dart';
import 'package:clean_cqrs_arch_flutter/app/shared/enums/status.dart';

import '../../../../../shared/handlers/base_handler.dart';
import '../../../domain/repositories/todo_repository.dart';
import 'get_all_todo_query.dart';

class GetAllTodoQueryHandler
    implements Handler<GetAllTodoQuery, TodoListResponse> {
  GetAllTodoQueryHandler(this.repository);

  final TodoRepository repository;

  @override
  Future<TodoListResponse> handle(GetAllTodoQuery query) async {
    final response = await repository.getTodos();

    return response.fold(
        (l) => TodoListResponse(status: Status.error, failure: l),
        (r) => TodoListResponse(status: Status.loaded, todos: r));
  }
}
