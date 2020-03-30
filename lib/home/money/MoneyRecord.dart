import 'package:flutter/material.dart';
import 'package:make_mimi/config/router_utils.dart';
import 'package:make_mimi/home/money/CommissionRecord.dart';
import 'package:make_mimi/home/set/ChangPwd.dart';
import 'package:make_mimi/home/set/FeedBack.dart';
import 'package:make_mimi/login/login.dart';
import 'package:make_mimi/utils/Help.dart';


class MoneyRecord extends StatefulWidget {


  @override
  _MoneyRecordState createState() => _MoneyRecordState();
}

class _MoneyRecordState extends State<MoneyRecord> {


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
//        textTheme: TextTheme(subtitle: "充币"),
        backgroundColor: Colors.white,
        title: Text('资产明细', style: TextStyle(fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Color(0xff333333),),),
        leading: new IconButton(icon: Icon(Icons.arrow_back_ios),
            color: Color(0xff333333),
            onPressed: () {
              Navigator.pop(context);
            }),
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 50,
              child: ListView.builder(

                  itemCount: 7,
                  itemBuilder: (BuildContext context,int index){

                    return buildCell(index);
                  }
              )
          ),

        ],
      ),
    );
  }


  Widget buildCell(int index) {
    List titleList = ['用户返本金', '用户返佣','反佣提成','充值保证金','退出保证金','提现记录','总资金明细'];
    List typeList = ['7', '8','9','3','4','2',''];


    return GestureDetector(
      onTap: () {

          Route_all.push(context, CommissionRecord(titleList[index],typeList[index]));

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
              right: 20,
              top: 20,
              bottom: 20,
              width: 10,
              child: Image(image: AssetImage('images/home/home_right.png'),),
            ),
            Positioned(
              right: 5,
              left: 5,
              bottom: 1,
              height: .5,
              child: Container(
                color: Color(0xffcccccc),
              ),
            )
          ],
        ),
      ),
    );
  }



}