import 'package:clean_cqrs_arch_flutter/app/app_dic.dart';
import 'package:clean_cqrs_arch_flutter/app/shared/view_models/base_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/client.dart';
import '../../domain/repositories/client_repository.dart';

class ClientUpdateVM extends ViewModel {
  final ClientRepository _clientRepository = AppDic.find();
  final client = Rxn<Client>();

  var nameController = TextEditingController();

  var imageUrlController = TextEditingController();

  ClientUpdateVM({required Client client}) {
    this.client.value = client;
    nameController.text = client.name;
    imageUrlController.text = client.imageUrl ?? '';
  }

  @override
  void listenToStreams() {
    // TODO: implement listenToStreams
  }

  onUpdate() async {
    final response = await _clientRepository.update(Client(
        name: nameController.text,
        imageUrl: imageUrlController.text,
        localId: client.value!.localId,
        id: client.value!.id));

    response.fold((l) => debugPrint, (r) {
      print(r.localId);
      Get.back(result: r);
    });
  }
}
