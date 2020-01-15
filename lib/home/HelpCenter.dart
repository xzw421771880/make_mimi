import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:make_mimi/utils/com_service.dart';


class HelpCenter extends StatefulWidget {


  @override
  _HelpCenterState createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {


  Map data;
  @override
  void initState() {
    super.initState();
    getHelp();
  }

  getHelp() {
    print("getuser --------------");
    Map<String, dynamic> map = Map();
    map.putIfAbsent("id", () => '1');
    Com_Service().post(map, "/site/get-help-center-by-id", (response) {
      print("帮助详情");
      print(response);
      data = response;

      setState(() {
        print("更新");
      });
//      print(meModel.balanceUsdt);
    }, (fail) {

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
//        textTheme: TextTheme(subtitle: "充币"),
        backgroundColor: Colors.white,
        title: Text('帮助中心', style: TextStyle(fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Color(0xff333333),),),
        leading: new IconButton(icon: Icon(Icons.arrow_back_ios),
            color: Color(0xff333333),
            onPressed: () {
              Navigator.pop(context);
            }),
        elevation: 0,
      ),
      body: data == null?Container(): Html(data: data['help_content'],),
    );
  }


}