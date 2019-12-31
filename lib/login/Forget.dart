import 'dart:async';

import 'package:flutter/material.dart';
import 'package:make_mimi/config/router_utils.dart';
import 'package:make_mimi/login/Certification.dart';
import 'package:make_mimi/utils/Help.dart';
import 'package:make_mimi/utils/com_service.dart';
import 'package:make_mimi/utils/showtoast_util.dart';


class Forget extends StatefulWidget {


  @override
  _ForgetState createState() => _ForgetState();
}

class _ForgetState extends State<Forget> {


  String buttonText = '发送验证码'; //初始文本
  bool isButtonEnable = true; //按钮状态  是否可点击
  int count = 60; //初始倒计时时间
  Timer timer;

  String mobile;
  String password;
  String comfirmPassword;
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
        title: Text('忘记登录密码', style: TextStyle(fontSize: 15,
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
                child: new Text('提交', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),

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

    List titleList = ['手机号','验证码','密码','确认密码'];
    List hintList = ['请输入手机号','请输入验证码','请输入6-9位密码（数字字母）','请再次输入6-9位密码（数字字母）'];


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

                if(index == 0){
                  mobile = value;
                }else if(index == 1){
                  msgCode = value;
                }else if(index == 2){
                  password = value;
                }else if(index == 3){
                  comfirmPassword = value;
                }
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
                  print('获取验证码');
                  getCode();
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

  getCode(){

    if(mobile == null){
      showToast('请输入手机号码');
      return;
    }
    if (!Helps().isChinaPhoneLegal(mobile)){

      showToast('手机号码格式不正确');
      return;
    }


    isButtonEnable = false;
    print('ok');

    Map<String, dynamic> map = Map();

    map.putIfAbsent("mobile", () => mobile);

    print(map);

    Com_Service().post(map, "/site/send-msg-code", (response) {
      print("发送成功");

      showToast('发送成功');
      _initTimer();
      print(response);
    }, (fail) {
      print("失败");
    });
  }


  nextCommit(){

//    if(msgCode == null){
//      showToast('请输入验证码');
//      return;
//    }
//
//    if(msgCode.length < 6){
//      showToast('请输入验证码');
//      return;
//    }

    if(password == null){
      showToast('请输入密码');
      return;
    }

    if(password.length < 6){
      showToast('密码长度不能小于6');
      return;
    }

    if(comfirmPassword == null){
      showToast('请再次输入密码');
      return;
    }

    if(password != comfirmPassword){
      showToast('两次密码输入不一致');
      return;
    }





    Map<String, dynamic> map = Map();

    print('3333');
    map.putIfAbsent("mobile", () => mobile);
    map.putIfAbsent("newPassword", () => password);
    map.putIfAbsent("msgCode", () => '888888');



    print(map);


    Com_Service().post(map, "/user/forgot-password", (response) {

      print("找回成功");
      print(response);
      showToast('找回成功');
      Navigator.pop(context);
    }, (fail) {
      print("失败");

    });
  }

}