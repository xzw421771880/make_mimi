import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

 showToast(String message) {
  print('dddd');
//  Fluttertoast.showToast(
//      msg: message,
//      toastLength: Toast.LENGTH_SHORT,
//      gravity: ToastGravity.CENTER,
//      timeInSecForIos: 1,
//      backgroundColor: Colors.blue,
//      textColor: Colors.white,
//      fontSize: ScreenUtil.instance.setSp(28.0));

  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 18.0);
}