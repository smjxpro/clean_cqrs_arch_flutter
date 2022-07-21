import 'package:clean_cqrs_arch_flutter/app/app.dart';
import 'package:clean_cqrs_arch_flutter/app/app_dic.dart';
import 'package:clean_cqrs_arch_flutter/app/modules/clients/domain/repositories/client_repository.dart';
import 'package:cron/cron.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppDic.setup();

  final ClientRepository _clientRepository = AppDic.find();

  final cron = Cron();

  // cron.schedule(Schedule.parse('*/3 * * * *'), () async {
  //   print('every three minutes');
  // });

  await _clientRepository.sync();
  //
  // cron.schedule(Schedule.parse('1-5 * * * *'), () async {
  //   print('syncing started');
  //
  //   await _clientRepository.sync();
  //
  //   print('syncing finished');
  // });

  runApp(const MyApp());
}
