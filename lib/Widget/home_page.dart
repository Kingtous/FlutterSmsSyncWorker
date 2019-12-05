import 'package:flutter/material.dart';
import 'package:flutter_lottie/flutter_lottie.dart';
import 'package:sms_helper/Application/application.dart';
import 'package:sms_helper/Tool/routes.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("SMS助手"),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          decoration: BoxDecoration(color: Colors.white12),
          child: PageView(
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 150,
                      width: 150,
                      child: LottieView.fromFile(
                        filePath: 'animation/send.json',
                        onViewCreated: (LottieController controller) {},
                        autoPlay: true,
                        loop: true,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    FlatButton.icon(
                      color: Colors.lightBlue,
                      icon: Icon(
                        Icons.cloud_upload,
                        color: Colors.white,
                        size: 50,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.smsSend);
                      },
                      label: Text(
                        "发送者",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    FlatButton.icon(
                        color: Colors.lightBlue,
                        icon: Icon(
                          Icons.cloud_download,
                          color: Colors.white,
                          size: 50,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.smsGet);
                        },
                        label:
                            Text("监听者", style: TextStyle(color: Colors.white))),
                  ],
                ),
              ),

              //第二屏
              Center(
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          child: LottieView.fromFile(
                              onViewCreated: (controller) {
                              },
                              filePath: 'animation/loading/loading_circle.json',autoPlay: true,loop: true,),
                        width: 150,
                        height: 50,
                      ),
                      Text("手机号：" + Application.sp.getString("username")),
                      FlatButton.icon(
                          color: Colors.lightBlue,
                          onPressed: () {Navigator.popAndPushNamed(context, Routes.logout);},
                          icon: Icon(
                            Icons.exit_to_app,
                            color: Colors.white,
                          ),
                          label: Text(
                            "退出登录",
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
