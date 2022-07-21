import 'package:clean_cqrs_arch_flutter/app/app_dic.dart';
import 'package:clean_cqrs_arch_flutter/app/modules/clients/domain/repositories/client_repository.dart';
import 'package:clean_cqrs_arch_flutter/app/shared/view_models/base_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../domain/entities/client.dart';

class ClientVM extends ViewModel {
  final ClientRepository _clientRepository = AppDic.find();
  var clients = <Client>[].obs;

  @override
  void listenToStreams() {
    // TODO: implement listenToStreams
  }

  onGetAll() async {
    final response = await _clientRepository.getAll();

    response.fold((l) => debugPrint, (r) => clients.assignAll(r));
  }

  onRemove(Client client) async {
    final response = await _clientRepository.delete(client);

    response.fold((l) => debugPrint, (r) => clients.remove(client));
  }

  @override
  void onInit() async {
    super.onInit();

    await onGetAll();
  }
}
