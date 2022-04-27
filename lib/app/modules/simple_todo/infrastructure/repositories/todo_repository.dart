import 'package:clean_cqrs_arch_flutter/app/modules/simple_todo/domain/entities/todo.dart';
import 'package:clean_cqrs_arch_flutter/app/modules/simple_todo/domain/repositories/todo_repository.dart';
import 'package:clean_cqrs_arch_flutter/app/modules/simple_todo/infrastructure/remote/data_sources/todo_remote_data_source.dart';
import 'package:clean_cqrs_arch_flutter/app/shared/exceptions/api_exception.dart';
import 'package:clean_cqrs_arch_flutter/app/shared/exceptions/network_exception.dart';
import 'package:clean_cqrs_arch_flutter/app/shared/failures/base_failure.dart';
import 'package:clean_cqrs_arch_flutter/app/shared/failures/network_failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../shared/failures/api_failure.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource _remoteDataSource;

  TodoRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, Unit>> addTodo(Todo todo) {
    // TODO: implement addTodo
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> deleteTodo(String id) {
    // TODO: implement deleteTodo
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Todo>> getTodo(String id) {
    // TODO: implement getTodo
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Todo>>> getTodos() async {
    try {
      final todos = await _remoteDataSource.getTodos();
      return Right(todos.map((e) => e.toDomain()).toList());
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on ApiException catch (e) {
      return Left(ApiFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateTodo(Todo todo) {
    // TODO: implement updateTodo
    throw UnimplementedError();
  }
}
