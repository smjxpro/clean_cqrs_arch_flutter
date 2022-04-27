import 'package:clean_cqrs_arch_flutter/app/app.dart';
import 'package:clean_cqrs_arch_flutter/app/app_dic.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppDic.setup();
  runApp(const MyApp());
}
