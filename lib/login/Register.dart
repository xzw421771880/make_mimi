import 'dart:async';

import 'package:flutter/material.dart';
import 'package:make_mimi/config/router_utils.dart';
import 'package:make_mimi/login/Certification.dart';
import 'package:make_mimi/utils/com_service.dart';


class Register extends StatefulWidget {


  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  int sex = 0;

  String buttonText = '发送验证码'; //初始文本
  bool isButtonEnable = true; //按钮状态  是否可点击
  int count = 60; //初始倒计时时间
  Timer timer;

  String mobile;
  String password;
  String inviteCode;
  String msgCode;


  void _initTimer() {
    timer = new Timer.periodic(Duration(seconds: 1), (Timer timer) {
      count--;
      setState(() {
        if (count == 0) {
          timer.cancel(); //倒计时结束取消定时器
          isButtonEnable = true; //按钮可点击
          count = 60; //重置时间
          buttonText = '发送验证码'; //重置按钮文本
        } else {
          buttonText =  '重新发送'+'($count)'; //更新文本内容
        }
      });
    });
  }

  ///销毁计时器
  @override
  void dispose() {
    timer?.cancel(); //销毁计时器
    timer = null;
    super.dispose();
  }

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
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
//        textTheme: TextTheme(subtitle: "充币"),
        backgroundColor: Colors.white,
        title: Text('注册', style: TextStyle(fontSize: 15,
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
              child:ListView(

                children: <Widget>[
                  buildCell(0),
                  buildCell(1),
                  buildCell(2),
                  buildCell(3),
                  buildCell(4),
                  buildSex(),
                  buildAge(),
                  buildCell(5),

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
                child: new Text('下一步', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),

                ),
                onPressed: () {

                  nextCommit();
                },
              )
          )
        ],
      ),
    );
  }



  Widget buildCell(int index){

    List titleList = ['手机号','验证码','密码','确认密码','QQ号码','邀请码'];
    List hintList = ['你的已实名手机号','请输入验证码','请输入6-9位密码（数字字母）','请再次输入6-9位密码（数字字母）','请输入你的QQ用于联系','请输入邀请码'];


    return Container(
      height: 50,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 15,
            width: 80,
            top: 0,
            bottom: 0,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(titleList[index]),
            ),
          ),

          Positioned(
            left: 100,
            right: index == 1 ?115:15,
            top: 0,
            bottom: 0,
            child: TextField(
//              style: TextStyle(textBaseline: TextBaseline.alphabetic),
              cursorColor: Colors.grey,
              decoration:  new InputDecoration(
                hintText: hintList[index],
                contentPadding: EdgeInsets.only(top: 14,bottom: 0),
                border: InputBorder.none,
                hintStyle: TextStyle(
                  fontSize: 14,
                ),
              ),
              onChanged: (value){

              },
            ),
          ),
          index != 1?Container():Positioned(
            right: 15,
            width: 100,
            top: 5,
            bottom: 5,
            child: MaterialButton(
              padding: EdgeInsets.all(0),
              color: isButtonEnable? Colors.blue:Colors.grey,
              textColor: Colors.white,
              child: Text(buttonText, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,),

              ),
              onPressed: () {

                if(isButtonEnable){
                  isButtonEnable = false;
                  print('获取验证码');
                  _initTimer();
                }

//                  Route_all.push(context, Login());
              },
            ),
          ),
          Positioned(
            left: 5,
            right: 5,
            bottom: 0,
            height: 1,
            child: Container(
              color: Color(0xffeeeeee),
            ),
          )
        ],
      ),
    );
  }

  Widget buildSex() {
    return Container(
        height: 50,
        color: Colors.white,
        child: Stack(
            children: <Widget>[
              Positioned(
                left: 15,
                width: 80,
                top: 0,
                bottom: 0,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text('性别'),
                ),
              ),

              Positioned(
                left: 100,
                width: 80,
                bottom: 0,
                top: 0,
                child: buildSexSel(0),
              ),
              Positioned(
                left: 180,
                width: 80,
                bottom: 0,
                top: 0,
                child: buildSexSel(1),
              ),
              Positioned(
                left: 5,
                right: 5,
                bottom: 0,
                height: 1,
                child: Container(
                  color: Color(0xffeeeeee),
                ),
              ),
            ]
        )
    );
  }

  Widget buildSexSel(int index){

    return GestureDetector(
      onTap: (){
        sex = index;
        setState(() {

        });
      },
      child: Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 10,
              top: 17.5,
              width: 15,
              height: 15,
              child: Image(image: AssetImage(sex == index?'images/login/register_sex_yes.png':'images/login/register_sex_no.png'),),
            ),
            Positioned(
              left: 35,
              top: 0,
              right: 0,
              bottom: 0,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(index == 0?'男':'女'),
              ),
            )
          ],
        ),

      ),
    );
  }

  Widget buildAge(){

    return GestureDetector(
      onTap: (){
        print('选择年龄');
      },
      child: Container(

        height: 50,
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 15,
              width: 80,
              top: 0,
              bottom: 0,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text('18-26'),
              ),
            ),
            Positioned(
              right: 20,
              top: 17.5,
              width: 15,
              height: 15,
              child: Image(image: AssetImage('images/home/home_right.png'),),
            ),
            Positioned(
              left: 5,
              right: 5,
              bottom: 0,
              height: 1,
              child: Container(
                color: Color(0xffeeeeee),
              ),
            )
          ],
        ),

      ),
    );
  }

  nextCommit(){

    Route_all.push(context, Certification());
  }

//    Map<String, dynamic> map = Map();
//    map.putIfAbsent("mobile", () => mobile);
//    map.putIfAbsent("password", () => password);
//    map.putIfAbsent("inviteCode", () => inviteCode);
//    map.putIfAbsent("msgCode", () => msgCode);

//    map.putIfAbsent("mobile", () => '15669966761');
//    map.putIfAbsent("password", () => '123456');
//    map.putIfAbsent("inviteCode", () => '');
//    map.putIfAbsent("msgCode", () => msgCode);
//
//    print(map);
//
//    Com_Service().post(map, "/user/reg", (response) {
//
//      print("注册成功");
//      print(response);
//    }, (fail) {
//      print("失败");
//      Navigator.pop(context);
//    });
//  }

}