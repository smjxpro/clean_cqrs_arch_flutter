import 'package:clean_cqrs_arch_flutter/app/modules/simple_todo/presentation/view_models/todo_list_vm.dart';
import 'package:clean_cqrs_arch_flutter/app/shared/widgets/centered_circular_progress_indicator.dart';
import 'package:clean_cqrs_arch_flutter/app/modules/simple_todo/presentation/views/widgets/todo_item_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../shared/enums/status.dart';

class TodoListPage extends StatelessWidget {
  late final TodoListVM _vm;

  TodoListPage({Key? key}) : super(key: key) {
    _vm = Get.put(TodoListVM());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: Obx(() {
        switch (_vm.todoListResponse.value.status) {
          case Status.loading:
            return const CenteredCircularProgressIndicator();
          case Status.error:
            return Center(
                child: Text(_vm.todoListResponse.value.failure!.message));
          case Status.loaded:
            return ListView.builder(
              itemCount: _vm.todoListResponse.value.todos!.length,
              itemBuilder: (context, index) {
                return TodoItemTile(
                  vm: _vm,
                  index: index,
                );
              },
            );
          case Status.initial:
            return Container();
            break;
        }
      }),
    );
  }
}
