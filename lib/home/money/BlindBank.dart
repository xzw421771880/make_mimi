import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:make_mimi/config/router_utils.dart';
import 'package:make_mimi/home/money/DrawRecord.dart';
import 'package:make_mimi/home/money/TopupRecord.dart';
import 'package:make_mimi/utils/RefundReason.dart';
import 'package:make_mimi/utils/com_service.dart';
import 'package:make_mimi/utils/showtoast_util.dart';


typedef Back();

class BlindBank extends StatefulWidget {

  Back back;
  BlindBank(this.back);

  @override
  _BlindBankState createState() => _BlindBankState();
}

class _BlindBankState extends State<BlindBank> {

  String bank;
  String bankNum;
  String rebankNum;
  List banklist = List();

  @override
  void initState() {

    Future<String> loadString = DefaultAssetBundle.of(context).loadString("images/bank.json");

    loadString.then((String value) {
      // 通知框架此对象的内部状态已更改
      setState(() {
        // 将参数赋予存储点击数的变量
        print('json------');
        print(json.decode(value));
        Map data = json.decode(value);
        List list = data['bank'];
        print(list);
        for (int i = 0;i<list.length;i++){
          banklist.add(list[i]['text']);
        }
        print(banklist);
      });
    });


    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
//        textTheme: TextTheme(subtitle: "充币"),
          backgroundColor: Colors.white,
          title: Text('银行卡绑定', style: TextStyle(fontSize: 15,
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
              child: ListView(

                children: <Widget>[
                  buildWarn(
                      '请注意：为保证资金安全，提现信息必须实名认证一样，绑定后提现开户人将永久无法修改'),
                  buildTitle(0),
                  buildSel(),
                  buildText(1),
                  buildText(2),

//                  buildTitle(1),
//                  buildMessage(),
//                  buildText(3),
//                  buildWarn('审核时间：24小时内处理，请耐心等待'),
                ],
              )
          ),
          Positioned(
              left: 15,
              bottom: MediaQuery
                  .of(context)
                  .padding
                  .bottom,
              height: 50,
              right: 15,
              child: MaterialButton(
                color:  Colors.blue,
                textColor: Colors.white,
                child: new Text('确认绑定', style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold,),

                ),
                onPressed: () {
                  print('确认提交');
                  commit();

                },
              )
          )
        ],
      ),
    );
  }

  Widget buildTitle(int index) {
    List titleList = ['账户信息', '提现信息'];

    return Container(
      color: Color(0xffcccccc),
      height: 40,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 15,
            width: 150,
            top: 0,
            bottom: 0,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(titleList[index],),
            ),
          ),

        ],
      ),
    );
  }

    Widget buildSel(){

    return GestureDetector(
      onTap: (){

        print('xz');
        showDialog(
            context: context,
            builder: (BuildContext context){
              return RefundReason(banklist,(resonBack){

                bank = resonBack;
                setState(() {

                });
              });
            }
        );
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
                child: Text('提现银行'),
              ),
            ),
            Positioned(
              left: 120,
              right: 15,
              top: 0,
              bottom: 0,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(bank == null? '请选择':bank),
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

  Widget buildText(int index) {
    List titleList = ['银行名称', '银行账户', '确认银行账号'];
    List hintList = ['请输入银行名称', '请输入银行账号', '确认银行账号'];
    List<TextInputType> input = [
      TextInputType.text,
      TextInputType.phone,
      TextInputType.phone,
      TextInputType.number
    ];


    return Container(
      height: 50,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 15,
            width: 100,
            top: 0,
            bottom: 0,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(titleList[index]),
            ),
          ),
          Positioned(
            left: 120,
            right: 15,
            top: 0,
            bottom: 0,
            child: TextField(
//              style: TextStyle(textBaseline: TextBaseline.alphabetic),
              cursorColor: Colors.grey,
              keyboardType: input[index],
              decoration: new InputDecoration(
                hintText: hintList[index],
                contentPadding: EdgeInsets.only(top: 14, bottom: 0),
                border: InputBorder.none,
                hintStyle: TextStyle(
                  fontSize: 14,
                ),
              ),
              onChanged: (value) {
                if (index == 0) {
//                  realName = value;
                } else if (index == 1) {
                  bankNum = value;
                } else {
                  rebankNum = value;
                }
              },
            ),
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
    );
  }

  Widget buildWarn(String title) {
    return Container(

      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(title, style: TextStyle(color: Color(0xffFD0000)),),
            ),
          )
        ],
      ),
    );
  }

  commit() {

    if (bank == null) {
      showToast('请输入银行名称');
      return;
    }

    if (bankNum == null) {
      showToast('请输入银行账号');
      return;
    }

    if (rebankNum == null) {
      showToast('请确认银行账号');
      return;
    }

    if (bankNum != rebankNum) {
      showToast('两次银行账号输入不一致');
      return;
    }



    Map<String, dynamic> map = Map();

    print('3333');
    map.putIfAbsent("bank_name", () => bank);
    map.putIfAbsent("bank_num", () => bankNum);


    print(map);

    Com_Service().post(map, "/user/bind-bank", (response) {
      print("提现成功");
      print(response);
      showToast('绑定成功');
      widget.back();
      Navigator.pop(context);
    }, (fail) {
      print("失败");
    });
  }


}