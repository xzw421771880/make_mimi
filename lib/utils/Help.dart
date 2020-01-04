

import 'package:shared_preferences/shared_preferences.dart';

class Helps{

  bool isChinaPhoneLegal(String str) {
    return new RegExp('^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$').hasMatch(str);
  }


  saveToke(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    getToken();
  }

  getToken() async{
    SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    print(token);
    return token;
  }

  String strToDate(int dataStr){
    var date2 = DateTime.fromMillisecondsSinceEpoch(dataStr*1000);
    List<String> list  = date2.toString() .split('.');
//    print('------------------------时间戳转日期：${list[0]}');
    return list[0];
  }


}