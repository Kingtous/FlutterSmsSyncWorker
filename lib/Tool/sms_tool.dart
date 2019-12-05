import 'package:sms_helper/Application/application.dart';

class SmsTool{

  static Future<bool> checkIfLogin() async{
    var sp = Application.sp;
    if(sp.getString("id") != null){
      return true;
    }
    return false;
  }

}