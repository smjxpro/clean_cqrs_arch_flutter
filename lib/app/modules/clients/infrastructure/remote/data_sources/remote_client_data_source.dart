import 'package:clean_cqrs_arch_flutter/app/modules/clients/infrastructure/remote/dtos/api_response.dart';
import 'package:clean_cqrs_arch_flutter/app/modules/clients/infrastructure/remote/dtos/client_dto.dart';
import 'package:clean_cqrs_arch_flutter/app/shared/exceptions/api_exception.dart';
import 'package:clean_cqrs_arch_flutter/app/shared/exceptions/network_exception.dart';
import 'package:clean_cqrs_arch_flutter/app/shared/values/strings.dart';
import 'package:http/http.dart' as http;

abstract class GenericDataSource<T> {
  Future<T> get(String id);

  Future<List<T>> getAll();

  Future<T> create(T entity);

  Future<void> update(T entity);

  Future<void> delete(String id);
}

abstract class RemoteClientDataSource extends GenericDataSource<ClientDto> {}

class RemoteClientDataSourceImpl implements RemoteClientDataSource {
  @override
  Future<ClientDto> create(ClientDto entity) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('POST', Uri.parse(ApiStrings.clientApiUrl));
      request.body = entity.toJson();

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 201) {
        var apiResponse =
            ApiResponseSingle.fromJson(await response.stream.bytesToString());

        return apiResponse.data!;
      } else {
        throw ApiException(
            code: response.statusCode, message: response.reasonPhrase!);
      }
    } catch (e) {
      throw NetworkException(e.toString());
    }
  }

  @override
  Future<ClientDto> get(String id) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request =
          http.Request('GET', Uri.parse(ApiStrings.clientApiUrl + id));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var apiResponse =
            ApiResponseSingle.fromJson(await response.stream.bytesToString());

        if (apiResponse.status) {
          return apiResponse.data!;
        } else {
          throw ApiException(
              code: response.statusCode, message: apiResponse.message!);
        }
      } else {
        throw ApiException(
            code: response.statusCode, message: response.reasonPhrase!);
      }
    } catch (e) {
      throw NetworkException(e.toString());
    }
  }

  @override
  Future<List<ClientDto>> getAll() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('GET', Uri.parse(ApiStrings.clientApiUrl));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var apiResponse =
            ApiResponse.fromJson(await response.stream.bytesToString());

        if (apiResponse.status) {
          return apiResponse.data!;
        } else {
          throw ApiException(
              code: response.statusCode, message: apiResponse.message!);
        }
      } else {
        throw ApiException(
            code: response.statusCode, message: response.reasonPhrase!);
      }
    } catch (e) {
      throw NetworkException(e.toString());
    }
  }

  @override
  Future<void> delete(String id) async {
    print(id);
    try {
      var headers = {'Content-Type': 'application/json'};
      var request =
          http.Request('DELETE', Uri.parse(ApiStrings.clientApiUrl + id));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 204) {
        return;
      } else {
        throw ApiException(
            code: response.statusCode, message: response.reasonPhrase!);
      }
    } catch (e) {
      throw NetworkException(e.toString());
    }
  }

  @override
  Future<void> update(ClientDto entity) async {
    print("UPDATE: ${entity.toJson()}");
    try {
      var headers = {'Content-Type': 'application/json'};
      var request =
          http.Request('PUT', Uri.parse(ApiStrings.clientApiUrl + entity.id!));
      request.body = entity.toJson();
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 204) {
        return;
      } else {
        throw ApiException(
            code: response.statusCode, message: response.reasonPhrase!);
      }
    } catch (e) {
      throw NetworkException(e.toString());
    }
  }
}
