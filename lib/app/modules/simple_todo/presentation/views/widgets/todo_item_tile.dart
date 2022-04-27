import 'package:clean_cqrs_arch_flutter/app/modules/simple_todo/presentation/view_models/todo_list_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../shared/enums/status.dart';

class TodoItemTile extends StatelessWidget {
  const TodoItemTile({
    Key? key,
    required TodoListVM vm,
    required this.index,
  })  : _vm = vm,
        super(key: key);

  final TodoListVM _vm;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        _vm.onDeleteTodo(index);
      },
      confirmDismiss: (v) {
        return Get.defaultDialog(
          title: 'Delete Todo',
          content: const Text('Are you sure you want to delete this todo?'),
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
      child: ListTile(
        title: Text(_vm.todoListResponse.value.todos![index].name),
        trailing: CupertinoSwitch(
          value: _vm.todoListResponse.value.todos![index].isComplete,
          onChanged: (value) {
            _vm.onChangeComplete(value, index);
          },
        ),
      ),
    );
  }
}
