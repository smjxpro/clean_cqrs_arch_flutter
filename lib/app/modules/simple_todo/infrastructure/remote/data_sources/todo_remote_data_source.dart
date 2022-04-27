import 'dart:convert';

import 'package:clean_cqrs_arch_flutter/app/shared/exceptions/api_exception.dart';
import 'package:clean_cqrs_arch_flutter/app/shared/exceptions/network_exception.dart';
import 'package:http/http.dart' as http;
import 'package:clean_cqrs_arch_flutter/app/modules/simple_todo/infrastructure/remote/dtos/todo_dto.dart';

import '../../../../../shared/values/strings.dart';

abstract class TodoRemoteDataSource {
  Future<TodoDto> getTodo(String id);

  Future<List<TodoDto>> getTodos();

  Future<TodoDto> createTodo(TodoDto todo);

  Future<TodoDto> updateTodo(TodoDto todo);

  Future<void> deleteTodo(String id);
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  @override
  Future<TodoDto> createTodo(TodoDto todo) {
    // TODO: implement createTodo
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTodo(String id) {
    // TODO: implement deleteTodo
    throw UnimplementedError();
  }

  @override
  Future<TodoDto> getTodo(String id) {
    // TODO: implement getTodo
    throw UnimplementedError();
  }

  @override
  Future<List<TodoDto>> getTodos() async {
    try {
      var request = http.Request('GET', Uri.parse(ApiStrings.todoApiUrl));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        return (jsonDecode(await response.stream.bytesToString()) as List)
            .map((e) => TodoDto.fromMap(e))
            .toList();
      } else {
        throw ApiException(
            code: response.statusCode, message: response.reasonPhrase!);
      }
    } catch (e) {
      throw NetworkException(e.toString());
    }
  }

  @override
  Future<TodoDto> updateTodo(TodoDto todo) {
    // TODO: implement updateTodo
    throw UnimplementedError();
  }
}
