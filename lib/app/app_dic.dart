import 'package:get/get.dart';

import 'modules/clients/client_dic.dart';

abstract class AppDic {
  static final find = Get.find;

  static Future<void> setup() async {
    await ClientDic.setup();
  }
}
