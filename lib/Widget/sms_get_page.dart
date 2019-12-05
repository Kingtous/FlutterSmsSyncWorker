import 'package:flutter/material.dart';
import 'package:sms_helper/Application/application.dart';
import 'package:sms_helper/Tool/network.dart';
import 'package:sms_helper/Tool/sms_model.dart';

class SmsGetPage extends StatefulWidget {
  @override
  _SmsGetPageState createState() => _SmsGetPageState();
}

class _SmsGetPageState extends State<SmsGetPage> {
  List<SmsModel> smsList;

  Future<void> getSms() async {
    smsList = await NetworkTool.recvMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            children: <Widget>[
              Text(
                "设备短信(云端)",
              ),
              Text(
                Application.sp.getString("username"),
                style: TextStyle(fontSize: 12.0),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: getSms(),
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
                  if (smsList != null)
                    return Container(
                      padding: EdgeInsets.all(16.0),
                      child: ListView.builder(
                          itemCount: smsList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Icon(Icons.sms),
                              title: Text(smsList[smsList.length - index - 1].sendFrom),
                              subtitle: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(child: Text("内容："+smsList[smsList.length - index - 1].content,overflow: TextOverflow.clip,)),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(child: Text("时间："+smsList[smsList.length - index - 1].timeFrom)),
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            );
                          }),
                    );
                  return Center(
                    child: Text("加载失败"),
                  );
                  break;
              }
              return null;
            }));
  }
}
