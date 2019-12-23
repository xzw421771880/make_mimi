import 'package:flutter/material.dart';

class Route_all {
//  static void toMainPage(BuildContext context) {
//    pushReplacementNamed(context, Routers.all);
//  }
//
//  static void pushReplacementNamed(BuildContext context, String pageName) {
//    Navigator.of(context).pushReplacementNamed(pageName);
//  }

  static Future<dynamic> push(BuildContext context, Widget page) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => page));
  }

  static Future<dynamic> pushAndRemove(BuildContext context, Widget page) {
    return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => page), (Route router) => false);
  }
}
