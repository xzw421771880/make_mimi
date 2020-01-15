import 'package:flutter/material.dart';
import 'package:make_mimi/config/router_utils.dart';
import 'package:make_mimi/home/blind/BlindTb.dart';
import 'package:make_mimi/utils/com_service.dart';


class Blind extends StatefulWidget {


  @override
  _BlindState createState() => _BlindState();
}

class _BlindState extends State<Blind> {

  Map data;
  List statusList;

  @override
  void initState() {
    super.initState();

    getStatus();
  }

  getStatus(){

    Com_Service().post(Map(), "/user/get-binding-taobao", (response) {

      print("绑定状态");
      print(response);
      data = response;
      statusList = data['range']['status'];
      setState(() {

      });

    }, (fail) {
      print("失败");

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
//        textTheme: TextTheme(subtitle: "充币"),
        backgroundColor: Colors.white,
        title: Text('绑定账号', style: TextStyle(fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Color(0xff333333),),),
        leading: new IconButton(icon: Icon(Icons.arrow_back_ios),
            color: Color(0xff333333),
            onPressed: () {
              Navigator.pop(context);
            }),
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[

          Container(height: 10,),
          buildCell(0),
        ],
      ),
    );
  }

  Widget buildCell(int index){

    List titleList = ['淘宝'];
    String status;
    if(data != null){
      if(data['status'] != null){
        status = statusList[int.parse(data['status'])];
      }else{
        status = '未绑定';
      }
    }else{
      status = '未绑定';
    }


    return GestureDetector(
      onTap: (){

        Route_all.push(context, BlindTb(data == null?Map():data));
      },
      child: Container(

        height: 50,
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 15,
              top: 0,
              bottom: 0,
              width: 150,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(titleList[index]),
              ),
            ),
            Positioned(
              right: 50,
              top: 0,
              bottom: 0,
              width: 700,
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(status),
              ),
            ),
            Positioned(
              right: 20,
              top: 20,
              bottom: 20,
              width: 10,
              child: Image(image: AssetImage('images/home/home_right.png'),),
            )
          ],
        ),
      ),
    );
  }




}