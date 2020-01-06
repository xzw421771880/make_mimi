import 'dart:math';

import 'package:flutter/material.dart';
import 'package:make_mimi/config/router_utils.dart';
import 'package:make_mimi/home/money/DrawRecord.dart';
import 'package:make_mimi/home/money/TopupRecord.dart';
import 'package:make_mimi/utils/RefundReason.dart';
import 'package:make_mimi/utils/com_service.dart';
import 'package:make_mimi/utils/showtoast_util.dart';


class Draw extends StatefulWidget {


  @override
  _DrawState createState() => _DrawState();
}

class _DrawState extends State<Draw> {

  String bank;
  String realName;
  String bankNum;
  String rebankNum;
  String amount;

  @override
  void initState() {
    super.initState();
    getDetail();
  }

  getDetail() {
//    print("getuser --------------");
//    Map<String, dynamic> map = Map();
//    map.putIfAbsent("prodId", () => widget.productId);
//    Com_Service().get(map, "/prod/prodInfo", (response) {
//      print("商品详情");
//      print(response);
//
//      detailData = response;
//      Map model = detailData['skuList'][0];
//      sku = model['skuName'].toString().replaceAll(" ", ',');
//      price = model['price'].toString();
//      imageStr = model['pic'];
//      setState(() {
//        print("更新");
//      });
////      print(meModel.balanceUsdt);
//    }, (fail) {
//
//    });
  }


  @override
  Widget build(BuildContext context) {



    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
//        textTheme: TextTheme(subtitle: "充币"),
          backgroundColor: Colors.white,
          title: Text('银行提现', style: TextStyle(fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color(0xff333333),),),
          leading: new IconButton(icon: Icon(Icons.arrow_back_ios),
              color: Color(0xff333333),
              onPressed: () {
                Navigator.pop(context);
              }),
          elevation: 0,
          actions: <Widget>[
            MaterialButton(

              child: Text('提现记录', style: TextStyle(color: Color(0xff333333),),),
              onPressed: (){
                print("111");
                Route_all.push(context, DrawRecord());

              },
            )

          ]
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 50,
              child:ListView(

                children: <Widget>[
                  buildWarn('请先手动通过 网银/手机银行 转账到平台指定收款账号,再如实按照转账金额提交充值申请.没有转账就提交充值申请，就视为恶意提交'),
                  buildTitle(0),
                  buildSel(),
                  buildText(0),
                  buildText(1),
                  buildText(2),

                  buildTitle(1),
                  buildMessage(),
                  buildText(3),
                  buildWarn('审核时间：24小时内处理，请耐心等待'),
                ],
              )
          ),
          Positioned(
              left: 15,
              bottom: MediaQuery.of(context).padding.bottom,
              height: 50,
              right: 15,
              child: MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: new Text('确认提交', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),

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

  Widget buildTitle(int index){
    List titleList = ['每个账户绑定','提现信息'];

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

  Widget buildMessage(){

    return Container(
      height: 50,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 15,
            right: 15,
            top: 0,
            bottom: 0,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text('可提现金额（元）：888.88元'),
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


  Widget buildText(int index){

    List titleList = ['开户人姓名','银行账户','确认银行账号','提款金额（元）'];
    List hintList = ['请输入开户人姓名','请输入银行账号','确认银行账号','请输入提现金额'];
    List<TextInputType> input = [TextInputType.text,TextInputType.phone,TextInputType.phone,TextInputType.number];


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
              decoration:  new InputDecoration(
                hintText: hintList[index],
                contentPadding: EdgeInsets.only(top: 14,bottom: 0),
                border: InputBorder.none,
                hintStyle: TextStyle(
                  fontSize: 14,
                ),
              ),
              onChanged: (value){

                if (index == 0) {

                  realName = value;
                }else if(index == 1){
                  bankNum = value;
                }else if(index == 2){
                  rebankNum = value;
                }else{
                  amount = value;
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


  Widget buildSel(){

    return GestureDetector(
      onTap: (){

        print('xz');
        showDialog(
            context: context,
            builder: (BuildContext context){
              return RefundReason(['工商银行','建设银行','中国银行','农业银行'],(resonBack){

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

  Widget buildWarn(String title){

    return Container(

      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(title,style: TextStyle(color: Color(0xffFD0000)),),
            ),
          )
        ],
      ),
    );
  }

  commit(){



    if (bank == null){
      showToast('请选择银行');
      return;
    }

    if (realName == null){
      showToast('请输入真实姓名');
      return;
    }

    if (bankNum == null){

      showToast('请输入银行账号');
      return;
    }

    if (rebankNum == null){

      showToast('请确认银行账号');
      return;
    }

    if (bankNum != rebankNum){

      showToast('两次银行账号输入不一致');
      return;
    }

    if (amount == null){

      showToast('请输入提现金额');
      return;
    }



    Map<String, dynamic> map = Map();

    print('3333');
    map.putIfAbsent("bank", () => bank);
    map.putIfAbsent("realName", () => realName);
    map.putIfAbsent("bankNum", () => bankNum);
    map.putIfAbsent("amount", () => amount);

    print(map);

    Com_Service().post(map, "/user/withdraw", (response) {

      print("提现成功");
      print(response);
      showToast('提交成功');
      Navigator.pop(context);
    }, (fail) {
      print("失败");

    });
  }


}