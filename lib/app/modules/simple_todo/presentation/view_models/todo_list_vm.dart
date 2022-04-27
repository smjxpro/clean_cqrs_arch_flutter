import 'package:clean_cqrs_arch_flutter/app/app_dic.dart';
import 'package:clean_cqrs_arch_flutter/app/modules/simple_todo/application/queries/get_all_todo_query/get_all_todo_query.dart';
import 'package:clean_cqrs_arch_flutter/app/modules/simple_todo/application/queries/get_all_todo_query/get_all_todo_query_handler.dart';
import 'package:clean_cqrs_arch_flutter/app/modules/simple_todo/application/responses/todo_list_response.dart';
import 'package:get/get.dart';

import '../../../../shared/enums/status.dart';
import '../../../../shared/view_models/base_view_model.dart';

class TodoListVM extends ViewModel {
  final GetAllTodoQueryHandler _getAllTodoQueryHandler = AppDic.find();
  final todoListResponse = TodoListResponse().obs;

  @override
  void listenToStreams() {
    onGetAllTodo();
  }

  onGetAllTodo() {
    todoListResponse.value.status = Status.loading;
    todoListResponse.refresh();
    _getAllTodoQueryHandler.handle(GetAllTodoQuery()).then((todos) {
      todoListResponse.value = todos;
    });
  }

  onChangeComplete(bool value, int index) {
    if (value) {
      todoListResponse.value.todos![index].markComplete();
    } else {
      todoListResponse.value.todos![index].markIncomplete();
    }
    todoListResponse.refresh();
  }

  void onDeleteTodo(int index) {
    todoListResponse.value.todos!.removeAt(index);
    todoListResponse.refresh();
  }
}
