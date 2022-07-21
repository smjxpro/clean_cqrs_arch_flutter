import 'package:clean_cqrs_arch_flutter/app/modules/clients/domain/entities/client.dart';
import 'package:clean_cqrs_arch_flutter/app/modules/clients/presentation/view_models/client_update_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientUpdatePage extends StatelessWidget {
  ClientUpdatePage({Key? key, required Client client}) : super(key: key) {
    _vm = Get.put(ClientUpdateVM(client: client));
  }

  late final ClientUpdateVM _vm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Client'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _vm.nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: _vm.imageUrlController,
              decoration: const InputDecoration(
                labelText: 'Image URL',
              ),
            ),
            ElevatedButton(
              child: const Text('Update'),
              onPressed: _vm.onUpdate,
            ),
          ],
        ),
      ),
    );
  }
}
