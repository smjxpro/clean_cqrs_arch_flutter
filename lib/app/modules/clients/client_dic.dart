import 'package:clean_cqrs_arch_flutter/app/app_dic.dart';
import 'package:clean_cqrs_arch_flutter/app/modules/clients/infrastructure/local/data_sources/local_client_data_source.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'domain/repositories/client_repository.dart';
import 'infrastructure/remote/data_sources/remote_client_data_source.dart';
import 'infrastructure/repositories/client_repository.dart';

abstract class ClientDic {
  static final find = Get.find;

  static Future<void> setup() async {
    await Hive.initFlutter();

    Get.lazyPut(() => Connectivity(), fenix: true);

    //Data Sources
    Get.lazyPut<LocalClientDataSource>(() => LocalClientDataSourceImpl(),
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
