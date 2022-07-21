import 'package:clean_cqrs_arch_flutter/app/app_dic.dart';
import 'package:clean_cqrs_arch_flutter/app/modules/clients/domain/entities/client.dart';
import 'package:clean_cqrs_arch_flutter/app/shared/view_models/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/repositories/client_repository.dart';

class ClientAddVm extends ViewModel {
  final ClientRepository _clientRepository = AppDic.find();

  var nameController = TextEditingController();

  var imageUrlController = TextEditingController();

  @override
  void listenToStreams() {
    // TODO: implement listenToStreams
  }

  onAdd() async {
    var client =
        Client(name: nameController.text, imageUrl: imageUrlController.text);
    final response = await _clientRepository.create(client);

    response.fold((l) => debugPrint, (r) {
      print(r.localId);
      Get.back(result: r);
    });
  }
}
