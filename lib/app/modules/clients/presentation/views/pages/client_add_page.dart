import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view_models/client_add_vm.dart';

class ClientAddPage extends StatelessWidget {
  ClientAddPage({Key? key}) : super(key: key) {
    _vm = Get.put(ClientAddVm());
  }

  late final ClientAddVm _vm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Client'),
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
              child: const Text('Add'),
              onPressed: _vm.onAdd,
            ),
          ],
        ),
      ),
    );
  }
}
