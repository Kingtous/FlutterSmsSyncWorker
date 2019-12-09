import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:sms_helper/Widget/home_page.dart';
import 'package:sms_helper/Widget/index_page.dart';
import 'package:sms_helper/Widget/login_page.dart';
import 'package:sms_helper/Widget/logout_page.dart';
import 'package:sms_helper/Widget/sms_get_page.dart';
import 'package:sms_helper/Widget/sms_send_page.dart';
import 'package:sms_helper/Widget/welcome_page.dart';

class Routes {
  static String index = "/index";
  static String welcome = "/welcome";
  static String login = "/login";
  static String main = "/main";
  static String smsSend = "/sms/send";
  static String smsGet = "/sms/get";
  static String logout = "/index/logout";

  static void configureRoute(Router router) {
    router.define(index,
        handler: Handler(handlerFunc: (BuildContext context,Map<String,List<String>> params) {
          return IndexPage();
        }), transitionType: TransitionType.fadeIn);
    router.define(login,
        handler: Handler(handlerFunc: (BuildContext context,Map<String,List<String>> params) {
          return LoginPage();
        }), transitionType: TransitionType.fadeIn);
    router.define(welcome,
        handler: Handler(handlerFunc: (BuildContext context,Map<String,List<String>> params) {
          return WelcomePage();
        }), transitionType: TransitionType.fadeIn);
    router.define(main,
        handler: Handler(handlerFunc: (BuildContext context,Map<String,List<String>> params) {
          return MyHomePage(title: "SMS助手",);
        }), transitionType: TransitionType.fadeIn);

    router.define(smsSend,
        handler: Handler(handlerFunc: (BuildContext context,Map<String,List<String>> params) {
          return SmsSendPage();
        }), transitionType: TransitionType.cupertino);
    router.define(smsGet,
        handler: Handler(handlerFunc: (BuildContext context,Map<String,List<String>> params) {
          return SmsGetPage();
        }), transitionType: TransitionType.cupertino);

    router.define(logout,
        handler: Handler(handlerFunc: (BuildContext context,Map<String,List<String>> params) {
          return LogoutPage();
        }), transitionType: TransitionType.fadeIn);

  }
}
