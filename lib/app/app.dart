import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'modules/clients/presentation/views/pages/client_list_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Clean CQRS Architecture Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ClientPage(),
    );
  }
}
