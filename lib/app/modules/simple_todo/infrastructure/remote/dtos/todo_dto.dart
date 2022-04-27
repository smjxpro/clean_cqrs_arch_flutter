// To parse this JSON data, do
//
//     final todoDto = todoDtoFromMap(jsonString);

import 'dart:convert';

import '../../../domain/entities/todo.dart';

class TodoDto {
  TodoDto({
    required this.name,
    required this.isComplete,
    this.id,
  });

  String name;
  bool isComplete;
  String? id;

  factory TodoDto.fromJson(String str) => TodoDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TodoDto.fromMap(Map<String, dynamic> json) => TodoDto(
        name: json["name"],
        isComplete: json["isComplete"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "isComplete": isComplete,
        "id": id,
      };

  Todo toDomain() {
    return Todo(
      name: name,
      isComplete: isComplete,
      id: id,
    );
  }

  factory TodoDto.fromDomain(Todo todo) {
    return TodoDto(
      name: todo.name,
      isComplete: todo.isComplete,
      id: todo.id,
    );
  }
}
