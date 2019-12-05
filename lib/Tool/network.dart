import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_helper/Application/application.dart';
import 'package:sms_helper/Config/network_config.dart';
import 'package:sms_helper/Tool/sms_model.dart';

class NetworkTool {
  static Future<void> login(String phoneNumber, String password) async {
    try{
      Response response = await Application.dio
          .post(Config.loginUrl, options: Options(contentType: ContentType.json),
           data:{'username' : phoneNumber,'password':password}
      );
      print(response.data);
      Fluttertoast.showToast(msg: "Login Success");
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('uid',response.data['uid']);
      sharedPreferences.setString('id',response.data['id']);
      sharedPreferences.setString('username',phoneNumber);
      sharedPreferences.setString('password',password);
    }
    on DioError catch(e){
      String message = e.response.data["message"];
      Fluttertoast.showToast(msg: message != null?message:"网络异常");
    }
  }

  static Future<bool> reLogin() async {
    try{
      Response response = await Application.dio
          .post(Config.loginUrl, options: Options(contentType: ContentType.json),
          data:{'username' : Application.sp.getString("username"),'password':Application.sp.getString("password")}
      );
      print(response.data);
      Fluttertoast.showToast(msg: "Connect Success");
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('uid',response.data['uid']);
      sharedPreferences.setString('id',response.data['id']);
      return true;
    }
    on DioError catch(e){
      Fluttertoast.showToast(msg: e.response.data["message"]);
      return false;
    }
  }

  static void register(String phoneNumber, String password) async {
    Response response = await Application.dio.get(Config.registerUrl);
    print(response.data);
  }

  static void checkIfLogin() async {
    Response response = await Application.dio.get(Config.registerUrl);
    print(response.data);
  }

  static Future<List<SmsModel>> recvMessage() async {
//    await reLogin();
    var cookie_map = {
      "Cookie" : "sid="+Application.sp.getString("id")
    };

    var username = Application.sp.getString("username");
    var paramsMap = {
      "phoneNumber":"$username"
    };

    Response response = await Application.dio.get(Config.recvSmsUrl,
        queryParameters: paramsMap,
        options: Options(
        contentType: ContentType.json,
          headers: cookie_map,
        ));
    var list = response.data;
    List<SmsModel> rList = new List<SmsModel>();
    for (var item in list){
      var model =SmsModel(item['phoneNumber'], item['sendFrom'], item['timeFrom'], item['content']);
      rList.add(model);
    }
    return rList;
  }

  static Future<bool> uploadMessage(SmsModel model) async {
//    await reLogin();
    var cookie_map = {
      "Cookie" : "sid="+Application.sp.getString("id")
    };
    var data_map = {
      "phoneNumber" : Application.sp.getString("username"),
      "sendFrom" : model.sendFrom,
      "timeFrom" : model.timeFrom,
      "content" : model.content
    };

    try{
      Response response = await Application.dio.post(Config.uploadSmsUrl,options: Options(
        contentType: ContentType.json,
        headers: cookie_map
      ),data: data_map);
      print(response.data);
      return true;
    }
    on DioError catch(e){
      String message = e.response.data["message"];
      Fluttertoast.showToast(msg: message != null?message:"上传失败");
      return false;
    }

  }
}
