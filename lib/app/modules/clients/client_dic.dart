import 'dart:io';

import 'package:clean_cqrs_arch_flutter/app/modules/clients/infrastructure/local/data_sources/local_client_data_source.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import 'domain/repositories/client_repository.dart';
import 'infrastructure/remote/data_sources/remote_client_data_source.dart';
import 'infrastructure/repositories/client_repository.dart';

abstract class ClientDic {
  static final find = Get.find;

  static Future<void> setup() async {
    Get.lazyPut(() => Connectivity(), fenix: true);

    //Data Sources
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String clientDbPth = appDocDir.path + '/clients.db';
    Get.lazyPut<LocalClientDataSource>(
        () => LocalClientDataSourceImpl(clientDbPath: clientDbPth),
        fenix: true);

    Get.lazyPut<RemoteClientDataSource>(() => RemoteClientDataSourceImpl(),
        fenix: true);

    //Repositories
    Get.lazyPut<ClientRepository>(
        () => ClientRepositoryImpl(
            localClientDataSource: find(),
            connectivity: find(),
            remoteClientDataSource: find()),
        fenix: true);
  }
}
