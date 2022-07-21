import 'package:clean_cqrs_arch_flutter/app/modules/clients/presentation/view_models/client_list_vm.dart';
import 'package:clean_cqrs_arch_flutter/app/modules/clients/presentation/views/pages/client_update_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/entities/client.dart';

class ClientItemTile extends StatelessWidget {
  const ClientItemTile({
    Key? key,
    required ClientVM vm,
    required this.index,
  })  : _vm = vm,
        super(key: key);

  final ClientVM _vm;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        _vm.onRemove(_vm.clients[index]);
      },
      confirmDismiss: (v) {
        return Get.defaultDialog(
          title: 'Delete',
          content: const Text('Are you sure you want to delete this item?'),
          actions: [
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () => Get.back(result: false),
            ),
            ElevatedButton(
              child: const Text('Delete'),
              onPressed: () => Get.back(result: true),
            ),
          ],
        );
      },
      child: InkWell(
        onTap: () async {
          var result = await Get.to<Client>(
              () => ClientUpdatePage(client: _vm.clients[index]));
          if (result != null) {
            _vm.clients.removeAt(index);
            _vm.clients.insert(index, result);
          }
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _vm.clients[index].name,
                style: const TextStyle(fontSize: 20),
              ),
              _vm.clients[index].imageUrl == null
                  ? const Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.grey,
                    )
                  : Image.network(
                      _vm.clients[index].imageUrl!,
                      height: 50,
                      width: 50,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
