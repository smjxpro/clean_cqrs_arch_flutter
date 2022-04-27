import 'package:clean_cqrs_arch_flutter/app/app_dic.dart';
import 'package:clean_cqrs_arch_flutter/app/modules/simple_todo/application/queries/get_all_todo_query/get_all_todo_query_handler.dart';
import 'package:clean_cqrs_arch_flutter/app/modules/simple_todo/domain/repositories/todo_repository.dart';
import 'package:clean_cqrs_arch_flutter/app/modules/simple_todo/infrastructure/remote/data_sources/todo_remote_data_source.dart';
import 'package:clean_cqrs_arch_flutter/app/modules/simple_todo/infrastructure/repositories/todo_repository.dart';
import 'package:get/get.dart';

abstract class TodoDic {
  static Future<void> setup() async {
    //Data Sources
    Get.lazyPut<TodoRemoteDataSource>(() => TodoRemoteDataSourceImpl(),
        fenix: true);

    //Repositories
    Get.lazyPut<TodoRepository>(() => TodoRepositoryImpl(AppDic.find()),
        fenix: true);

    //Handlers
    Get.lazyPut<GetAllTodoQueryHandler>(
        () => GetAllTodoQueryHandler(AppDic.find()),
        fenix: true);
  }
}
