import 'package:dartz/dartz.dart';

import '../../../../shared/failures/base_failure.dart';
import '../entities/todo.dart';

abstract class TodoRepository {
  Future<Either<Failure, Todo>> getTodo(String id);

  Future<Either<Failure, List<Todo>>> getTodos();

  Future<Either<Failure, Unit>> addTodo(Todo todo);

  Future<Either<Failure, Unit>> updateTodo(Todo todo);

  Future<Either<Failure, Unit>> deleteTodo(String id);
}
