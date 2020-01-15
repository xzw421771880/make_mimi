import 'package:flutter/material.dart';
import 'package:make_mimi/utils/com_service.dart';
import 'package:make_mimi/utils/showtoast_util.dart';


class ChangPwd extends StatefulWidget {


  @override
  _ChangPwdState createState() => _ChangPwdState();
}

class _ChangPwdState extends State<ChangPwd> {

  String oldPass;
  String newPass;
  String againPass;


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
        title: Text('修改登录密码', style: TextStyle(fontSize: 15,
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
                  Container(height: 5,),
                  buildCell(1),
                  Container(height: 5,),
                  buildCell(2),

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

                  commit();
                },
              )
          )
        ],
      ),
    );
  }

  Widget buildCell(int index){

    List titleList = ['输入原密码','输入新密码','确认新密码'];
    List hintList = ['请输入6-9位密码（数字、字母）','请输入6-9位验证码（数字、字母）','请输入6-9位验证码（数字、字母）'];


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
            right: 15,
            top: 0,
            bottom: 0,
            child: TextField(
              obscureText: true,
//              style: TextStyle(textBaseline: TextBaseline.alphabetic),
              cursorColor: Colors.grey,
              keyboardType: TextInputType.visiblePassword,
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
                  oldPass = value;
                }else if(index == 1){
                  newPass = value;
                }else{
                  againPass = value;
                }
              },
            ),
          )
        ],
      ),
    );
  }


  commit(){


    if(oldPass == null ||oldPass.length == 0){
      showToast('请输入原密码');
      return;
    }

    if(newPass == null||newPass.length == 0){
      showToast('请输入新密码');
      return;
    }

    if(newPass != againPass){
      showToast('两次新密码不一致');
      return;
    }

    print("提交");
    Map<String, dynamic> map = Map();
    map.putIfAbsent("oldPassword", () => oldPass);
    map.putIfAbsent("newPassword", () => newPass);

    Com_Service().post(map, "/user/change-password", (response){

      print(response);
      showToast("修改成功！");
      Navigator.pop(context);
    }, (fail){

    });

  }


}