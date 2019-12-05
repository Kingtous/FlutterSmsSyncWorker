import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_lottie/flutter_lottie.dart';
import 'package:sms_helper/Application/application.dart';

class LogoutPage extends StatefulWidget {
  @override
  _LogoutPageState createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white
      ),
      child: Center(
        child: Container(
          width: 250,
          height: 250,
          child: LottieView.fromFile(onViewCreated: (controller){
            controller.onPlayFinished.listen((onData){
              Application.sp.clear().then((onValue){
                print("退出");
                exit(0);
              });
            });
          }, filePath: 'animation/fullscreen-rocket.json',autoPlay: true),
        ),
      ),
    );
  }
}
