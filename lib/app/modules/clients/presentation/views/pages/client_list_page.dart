import 'package:clean_cqrs_arch_flutter/app/modules/clients/domain/entities/client.dart';
import 'package:clean_cqrs_arch_flutter/app/modules/clients/presentation/view_models/client_list_vm.dart';
import 'package:clean_cqrs_arch_flutter/app/modules/clients/presentation/views/widgets/client_item_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'client_add_page.dart';

class ClientPage extends StatelessWidget {
  late final ClientVM _vm;

  ClientPage({Key? key}) : super(key: key) {
    _vm = Get.put(ClientVM());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client List'),
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: _vm.clients.length,
          itemBuilder: (context, index) {
            return ClientItemTile(
              vm: _vm,
              index: index,
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          var result = await Get.to<Client>(() => ClientAddPage());

          if (result != null) {
            _vm.clients.add(result);
          }
        },
      ),
    );
  }
}
