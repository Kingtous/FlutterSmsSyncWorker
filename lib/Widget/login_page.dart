import 'package:flutter/material.dart';
import 'package:flutter_lottie/flutter_lottie.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_helper/Tool/routes.dart';
import 'package:sms_helper/Tool/network.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  String _phoneNumber = "";
  String _password = "";

  TextEditingController editingController_1 =
      new TextEditingController(text: "");
  TextEditingController editingController_2 =
      new TextEditingController(text: "");

  var _isProcessing = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16.0),
                  width: 200,
                  height: 200,
                  child: LottieView.fromFile(
                    filePath: 'animation/profile.json',
                    onViewCreated: (LottieController controller) {
                      controller.setAnimationSpeed(0.4);
                    },
                    autoPlay: true,
                    loop: true,
                  )),
              TextField(
                controller: editingController_1,
                onChanged: (String s) {
                  _phoneNumber = s;
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  icon: Icon(Icons.phone_android),
                  labelText: "手机号",
                ),
              ),
              TextField(
                controller: editingController_2,
                onChanged: (String s) {
                  _password = s;
                },
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                  icon: Icon(Icons.hourglass_empty),
                  labelText: "密码",
                ),
              ),
              SizedBox(
                height: 32,
              ),
              FlatButton.icon(
                  onPressed: _isProcessing ? null : login,
                  icon: _isProcessing
                      ? Icon(Icons.rotate_right)
                      : Icon(Icons.import_export),
                  color: Colors.lightBlue,
                  textColor: Colors.white,
                  label: Text("登录"))
            ],
          ),
        ),
      ),
    );
  }

  void login() async {
    if (_password == '' || _phoneNumber == '') {
      Fluttertoast.showToast(msg: "手机号或密码不能为空");
    } else {
      setState(() {
        _isProcessing = true;
      });
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.remove("id");
      await NetworkTool.login(_phoneNumber, _password);
      String s = sp.getString("id");
      if (s != null) {
        print("ID:" + s != null ? s : "");
        // 结束页面，跳转到sms_tool
        Navigator.popAndPushNamed(context, Routes.index);
      }
      if (s == null) {
        // 未成功
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }
}
