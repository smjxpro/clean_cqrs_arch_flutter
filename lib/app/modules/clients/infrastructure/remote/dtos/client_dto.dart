import 'dart:convert';

import '../../../domain/entities/client.dart';

class ClientDto {
  ClientDto({
    this.id,
    required this.name,
    this.imageUrl,
    this.localId,
    this.isDeleted,
  });

  String? id;
  String name;
  String? imageUrl;
  String? localId;
  bool? isDeleted;

  factory ClientDto.fromJson(String str) => ClientDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ClientDto.fromMap(Map<String, dynamic> json) => ClientDto(
        id: json["id"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        localId: json["localId"],
        isDeleted: json["isDeleted"] ?? false,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
        "localId": localId,
        "isDeleted": isDeleted,
      };

  Client toDomain() {
    return Client(
      id: id,
      name: name,
      imageUrl: imageUrl,
      localId: localId,
    );
  }

  factory ClientDto.fromDomain(Client client) {
    return ClientDto(
      id: client.id,
      name: client.name,
      imageUrl: client.imageUrl,
      localId: client.localId,
    );
  }
}
