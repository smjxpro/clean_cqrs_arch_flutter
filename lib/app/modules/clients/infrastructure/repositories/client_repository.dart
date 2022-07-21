import 'package:clean_cqrs_arch_flutter/app/modules/clients/domain/entities/client.dart';
import 'package:clean_cqrs_arch_flutter/app/modules/clients/domain/repositories/client_repository.dart';
import 'package:clean_cqrs_arch_flutter/app/modules/clients/infrastructure/remote/data_sources/remote_client_data_source.dart';
import 'package:clean_cqrs_arch_flutter/app/modules/clients/infrastructure/remote/dtos/client_dto.dart';
import 'package:clean_cqrs_arch_flutter/app/shared/exceptions/api_exception.dart';
import 'package:clean_cqrs_arch_flutter/app/shared/failures/api_failure.dart';
import 'package:clean_cqrs_arch_flutter/app/shared/failures/base_failure.dart';
import 'package:clean_cqrs_arch_flutter/app/shared/failures/network_failure.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';

import '../local/data_sources/local_client_data_source.dart';

class ClientRepositoryImpl implements ClientRepository {
  final RemoteClientDataSource _remoteClientDataSource;
  final LocalClientDataSource _localClientDataSource;
  final Connectivity _connectivity;

  ClientRepositoryImpl(
      {required RemoteClientDataSource remoteClientDataSource,
      required LocalClientDataSource localClientDataSource,
      required Connectivity connectivity})
      : _remoteClientDataSource = remoteClientDataSource,
        _localClientDataSource = localClientDataSource,
        _connectivity = connectivity;

  @override
  Future<Either<Failure, Client>> create(Client entity) async {
    var connectivityResult = await _connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      var dto =
          await _localClientDataSource.create(ClientDto.fromDomain(entity));

      return right(dto.toDomain());
    } else {
      try {
        var apiResponse =
            await _remoteClientDataSource.create(ClientDto.fromDomain(entity));
        return right(apiResponse.toDomain());
      } on ApiException catch (e) {
        return left(ApiFailure(code: e.code, message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> delete(Client entity) async {
    var connectivityResult = await _connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      var dto = ClientDto.fromDomain(entity);
      dto.isDeleted = true;
      await _localClientDataSource.update(dto);

      return right(unit);
    } else {
      try {
        await _remoteClientDataSource.delete(entity.id!);
        var result = await _localClientDataSource.get(entity.id!);
        if (result != null) {
          await _localClientDataSource.delete(result);
          return right(unit);
        } else {
          return left(const ApiFailure(code: 404, message: "Not found"));
        }
      } on ApiException catch (e) {
        return left(ApiFailure(code: e.code, message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, Client>> get(String id) async {
    var connectivityResult = await _connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      var result = await _localClientDataSource.get(id);
      if (result != null) {
        return right(result.toDomain());
      } else {
        return left(const ApiFailure(code: 404, message: "Not found"));
      }
    } else {
      try {
        var apiResponse = await _remoteClientDataSource.get(id);
        await _localClientDataSource.create(apiResponse);
        return right(apiResponse.toDomain());
      } on ApiException catch (e) {
        return left(ApiFailure(code: e.code, message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<Client>>> getAll() async {
    var connectivityResult = await _connectivity.checkConnectivity();

    var test = await _localClientDataSource.getAll();

    for (var item in test) {
      print("GET ALL: ${item.toJson()}");
    }

    if (connectivityResult == ConnectivityResult.none) {
      var result = await _localClientDataSource.getAll();

      var nd = result.where((element) => element.isDeleted == false).toList();

      return right(nd.map((e) => e.toDomain()).toList());
    } else {
      try {
        var apiResponse = await _remoteClientDataSource.getAll();

        for (var i in apiResponse) {
          await _localClientDataSource.create(i);
        }

        return right(apiResponse.map((e) => e.toDomain()).toList());
      } on ApiException catch (e) {
        return left(ApiFailure(code: e.code, message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> sync() async {
    // await _localClientDataSource.deleteAll();
    var connectivityResult = await _connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      return left(const NetworkFailure());
    } else {
      try {
        var localResponse = await _localClientDataSource.getAll();

        for (var l in localResponse) {
          if (l.id == null) {
            await _remoteClientDataSource.create(l);
          } else {
            if (l.isDeleted == null || l.isDeleted == false) {
              await _remoteClientDataSource.delete(l.id!);
            } else {
              await _remoteClientDataSource.update(l);
            }
          }

          await _localClientDataSource.delete(l);
        }

        return right(unit);
      } on ApiException catch (e) {
        return left(ApiFailure(code: e.code, message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, Client>> update(Client entity) async {
    var connectivityResult = await _connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      final dto =
          await _localClientDataSource.update(ClientDto.fromDomain(entity));
      return right(dto.toDomain());
    } else {
      try {
        await _remoteClientDataSource.update(ClientDto.fromDomain(entity));
        return right(entity);
      } on ApiException catch (e) {
        return left(ApiFailure(code: e.code, message: e.message));
      }
    }
  }
}