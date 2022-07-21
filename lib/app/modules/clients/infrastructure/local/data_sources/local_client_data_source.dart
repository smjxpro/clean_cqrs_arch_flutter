import 'package:get/get.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import '../../remote/dtos/client_dto.dart';
import 'generic_local_source.dart';

abstract class LocalClientDataSource extends GenericLocalSource<ClientDto> {}

class LocalClientDataSourceImpl implements LocalClientDataSource {
// File path to a file in the current directory
  final String clientDbPath;
  DatabaseFactory dbFactory = databaseFactoryIo;

  LocalClientDataSourceImpl({required this.clientDbPath});

  @override
  Future<ClientDto> create(ClientDto entity) async {
    Database db = await dbFactory.openDatabase(clientDbPath);
    var store = StoreRef<int, String>.main();

    var localId = await store.add(db, entity.toJson());
    entity.localId = localId;
    return entity;
  }

  @override
  Future<void> delete(ClientDto entity) async {
    Database db = await dbFactory.openDatabase(clientDbPath);
    var store = StoreRef<int, String>.main();

    var finder = Finder(filter: Filter.byKey(entity.localId));
    await store.delete(db, finder: finder);
  }

  @override
  Future<void> deleteAll() async {
    Database db = await dbFactory.openDatabase(clientDbPath);
    var store = StoreRef<int, String>.main();

    await store.delete(db);
  }

  @override
  Future<ClientDto?> get(String id) async {
    var clients = await getAll();

    var result = clients.firstWhereOrNull((element) => element.id == id);
    if (result != null) {
      return result;
    } else {
      return null;
    }
  }

  @override
  Future<List<ClientDto>> getAll() async {
    Database db = await dbFactory.openDatabase(clientDbPath);
    var store = StoreRef<int, String>.main();

    var result = await store.find(db);
    return result.map((e) {
      var client = ClientDto.fromJson(e.value);
      client.localId = e.key;
      return client;
    }).toList();
  }

  @override
  Future<ClientDto> update(ClientDto entity) async {
    Database db = await dbFactory.openDatabase(clientDbPath);
    var store = StoreRef<int, String>.main();

    print("UPDATE: ${entity.toJson()}");

    var finder = Finder(filter: Filter.byKey(entity.localId));
    await store.update(db, entity.toJson(), finder: finder);
    return entity;
  }

  @override
  Future<bool> exists(ClientDto entity) async {
    var result = await get(entity.id!);
    return result != null;
  }
}
