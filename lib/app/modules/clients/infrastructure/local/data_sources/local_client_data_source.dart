import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../remote/dtos/client_dto.dart';
import 'generic_local_source.dart';

abstract class LocalClientDataSource extends GenericLocalSource<ClientDto> {}

class LocalClientDataSourceImpl implements LocalClientDataSource {
  final boxKey = 'clients_box';

  @override
  Future<ClientDto> create(ClientDto entity) async {
    await Hive.openBox(boxKey);
    final box = Hive.box(boxKey);
    const uuid = Uuid();
    entity.localId = uuid.v4();

    box.put(entity.localId, entity.toJson());

    return entity;
  }

  @override
  Future<void> delete(ClientDto entity) async {
    await Hive.openBox(boxKey);
    final box = Hive.box(boxKey);
    box.delete(entity.localId);
  }

  @override
  Future<ClientDto?> get(String id) async {
    final clients = await getAll();
    var client = clients.firstWhereOrNull((client) => client.id == id);
    return client;
  }

  @override
  Future<List<ClientDto>> getAll() async {
    await Hive.openBox(boxKey);
    final box = Hive.box(boxKey);
    return box.values.map((e) => ClientDto.fromJson(e)).toList();
  }

  @override
  Future<ClientDto> update(ClientDto entity) async {
    await Hive.openBox(boxKey);
    final box = Hive.box(boxKey);
    box.put(entity.localId, entity.toJson());
    return entity;
  }

  @override
  Future<void> deleteAll() async {
    await Hive.openBox(boxKey);
    final box = Hive.box(boxKey);
    box.clear();
  }
}
