import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lottie/flutter_lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_helper/Application/application.dart';
import 'package:sms_helper/Tool/routes.dart';
import 'package:sms_helper/Tool/sms_tool.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  bool isLogin;

  Future<void> _init() async {
    Application.sp = await SharedPreferences.getInstance();
    isLogin = await SmsTool.checkIfLogin();
    Future.delayed(Duration.zero, () {
      if (isLogin) {
        Navigator.pushReplacementNamed(context, Routes.main);
      } else {
        Navigator.pushReplacementNamed(context, Routes.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _init(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            // TODO: Handle this case.
            break;
          case ConnectionState.waiting:
            // TODO: Handle this case.
            break;
          case ConnectionState.active:
            // TODO: Handle this case.
            break;
          case ConnectionState.done:
            // TODO: Handle this case.
            break;
        }
        return Center(
          child: Container(
            width: 200,
            height: 200,
            child: LottieView.fromFile(
              filePath: 'animation/loading/loading_1.json',
              autoPlay: true,
              loop: true,
              onViewCreated: (LottieController controller) {},
            ),
          ),
        );
      },
    );
  }
}
