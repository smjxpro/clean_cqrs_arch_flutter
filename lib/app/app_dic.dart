import 'package:clean_cqrs_arch_flutter/app/modules/simple_todo/todo_dic.dart';
import 'package:get/get.dart';

abstract class AppDic {
  static final find = Get.find;

  static Future<void> setup() async {
    await TodoDic.setup();
  }
}
