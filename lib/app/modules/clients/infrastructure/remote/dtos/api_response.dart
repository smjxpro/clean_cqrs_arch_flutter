// To parse this JSON data, do
//
//     final apiResponse = apiResponseFromMap(jsonString);

import 'dart:convert';

import 'package:clean_cqrs_arch_flutter/app/modules/clients/infrastructure/remote/dtos/client_dto.dart';

class ApiResponseSingle {
  ApiResponseSingle({
    this.data,
    this.message,
    required this.status,
  });

  ClientDto? data;
  String? message;
  bool status;

  factory ApiResponseSingle.fromJson(String str) =>
      ApiResponseSingle.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ApiResponseSingle.fromMap(Map<String, dynamic> json) =>
      ApiResponseSingle(
        data: json["data"] == null ? null : ClientDto.fromMap(json["data"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "message": message,
        "status": status,
      };
}

class ApiResponse {
  ApiResponse({
    this.data,
    this.message,
    required this.status,
  });

  List<ClientDto>? data;
  String? message;
  bool status;

  factory ApiResponse.fromJson(String str) =>
      ApiResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ApiResponse.fromMap(Map<String, dynamic> json) => ApiResponse(
        data: json["data"] == null
            ? null
            : List<ClientDto>.from(
                json["data"].map((x) => ClientDto.fromMap(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toMap())),
        "message": message,
        "status": status,
      };
}
