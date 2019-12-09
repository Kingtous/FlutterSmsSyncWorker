import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_lottie/flutter_lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_helper/Application/application.dart';
import 'package:sms_helper/Tool/routes.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    var timer = Timer(Duration(milliseconds: 2000), () {
      Application.router.navigateTo(context, Routes.index, replace: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                width: 200,
                height: 200,
                child: LottieView.fromFile(
                  filePath: 'animation/loading/loading_1.json',
                  onViewCreated: (LottieController controller) {},
                  autoPlay: true,
                  loop: true,
                )),
            Text(
              "SMS助手",
              style: TextStyle(color: Colors.white, fontSize: 32.0),
            )
          ],
        ),
        decoration: BoxDecoration(color: Colors.lightBlue),
      ),
    );
  }
}
