import 'package:dio/dio.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:sms_helper/Application/application.dart';
import 'package:sms_helper/Widget/welcome_page.dart';

import 'Tool/routes.dart';

void main() async {
  // 初始化引擎, sharedPreference在index_page页初始化
  Application.dio = new Dio();
  Router router = new Router();
  Routes.configureRoute(router);
  Application.router = router;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SMS助手',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomePage(),
      onGenerateRoute: Application.router.generator,
    );
  }
}
