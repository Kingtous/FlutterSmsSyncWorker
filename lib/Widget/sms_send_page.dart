import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sms_helper/Tool/network.dart';
import 'package:sms_helper/Tool/sms_model.dart';
import 'package:sms/sms.dart';

class SmsSendPage extends StatefulWidget {
  @override
  _SmsSendPageState createState() => _SmsSendPageState();
}

class _SmsSendPageState extends State<SmsSendPage> {
  bool _isListening = false;
  SmsReceiver receiver;

  bool loop = true;

  void startListen() async {

      setState(() {
        _isListening = true;
      });

      PermissionStatus permissionStatus = await PermissionHandler().checkPermissionStatus(PermissionGroup.sms);

      receiver.onSmsReceived.listen((SmsMessage msg){
        var model = SmsModel(msg.address, msg.address, msg.dateSent.toString(), msg.body);
        NetworkTool.uploadMessage(model).then((value){
          if (value){
            Fluttertoast.showToast(msg: "发送成功");
          }
          else{
            Fluttertoast.showToast(msg: "发送失败");
          }
        });
      });
      Fluttertoast.showToast(msg: "开始监听");

//    Fluttertoast.showToast(msg: "停止监听");
//    setState(() {
//      _isListening = false;
//    });
  }

  void stopListen() async {
    Navigator.pop(context);
  }

  Future<void> getSignature() async {
    receiver = new SmsReceiver();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("监测本机短信状态"),
          centerTitle: true,
        ),
        body: Platform.isIOS
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.error,
                      size: 150,
                    ),
                    Text(
                      "目前暂不支持IOS设备使用此功能",
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    )
                  ],
                ),
              )
            : Container(
                decoration: BoxDecoration(color: Colors.white),
                child: FutureBuilder(
                    future: getSignature(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Center(
                            child: Text("正在初始化"),
                          );
                          break;
                        case ConnectionState.waiting:
                          return Center(
                            child: Text("正在等待"),
                          );
                          break;
                        case ConnectionState.active:
                          return Center(
                            child: Text("正在加载中"),
                          );
                          break;
                        case ConnectionState.done:
                          return Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  _isListening
                                      ? Icons.sync_problem
                                      : Icons.stop_screen_share,
                                  size: 150,
                                  color: Colors.blue,
                                ),
                                Text(_isListening ? "正在监听" : "未监听"),
                                Text("(若仅无法通知信息则请检查是否打开读取通知的权限)"),
                                SizedBox(
                                  height: 32,
                                ),
                                Container(
                                  padding: EdgeInsets.all(32.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      FlatButton.icon(
                                          color: Colors.lightBlue,
                                          onPressed: startListen,
                                          icon: Icon(
                                            Icons.cloud_upload,
                                            color: Colors.white,
                                          ),
                                          label: Text(
                                            "开始监听",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                      FlatButton.icon(
                                          color: Colors.lightBlue,
                                          onPressed: stopListen,
                                          icon: Icon(Icons.stop,
                                              color: Colors.white),
                                          label: Text("停止监听",
                                              style: TextStyle(
                                                  color: Colors.white))),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                      }
                      return null;
                    })));
  }
}

//Center(
//// 不支持 IOS
//child: Column(
//mainAxisAlignment: MainAxisAlignment.center,
//children: <Widget>[
//Icon(Icons.error,size: 150,),
//Text("目前暂不支持IOS设备使用此功能",style: TextStyle(fontSize: 16.0,color: Colors.black),)
//],
//),
//)
