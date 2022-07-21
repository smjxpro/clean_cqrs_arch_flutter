import 'package:clean_cqrs_arch_flutter/app/modules/clients/domain/entities/client.dart';
import 'package:clean_cqrs_arch_flutter/app/shared/failures/base_failure.dart';
import 'package:dartz/dartz.dart';

abstract class GenericRepository<T> {
  Future<Either<Failure, T>> get(String id);

  Future<Either<Failure, List<T>>> getAll();

  Future<Either<Failure, T>> create(T entity);

  Future<Either<Failure, T>> update(T entity);

  Future<Either<Failure, Unit>> delete(T entity);

  Future<Either<Failure, Unit>> sync();
}
