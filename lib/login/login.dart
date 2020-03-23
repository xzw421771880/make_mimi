import 'package:flutter/material.dart';
import 'package:flutter_jpush/flutter_jpush.dart';
import 'package:make_mimi/Mimi.dart';
import 'package:make_mimi/config/router_utils.dart';
import 'package:make_mimi/login/Forget.dart';
import 'package:make_mimi/login/Register.dart';
import 'package:make_mimi/utils/Help.dart';
import 'package:make_mimi/utils/com_service.dart';
import 'package:make_mimi/utils/showtoast_util.dart';


class Login extends StatefulWidget {

  bool isBack;
  Login(this.isBack);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String mobile;
  String password;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
//        textTheme: TextTheme(subtitle: "充币"),
        backgroundColor: Colors.white,
        title: Text('登录', style: TextStyle(fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Color(0xff333333),),),
        leading: widget.isBack?new IconButton(icon: Icon(Icons.arrow_back_ios),
            color: Color(0xff333333),
            onPressed: () {
              Navigator.pop(context);
            }):Container(),
        actions: <Widget>[
          MaterialButton(

            child: Text('注册', style: TextStyle(color: Color(0xff333333),),),
            onPressed: (){
              print("111");
              Route_all.push(context, Register());

            },
          )

        ],
        elevation: 0,
      ),

      body: Stack(
        children: <Widget>[
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 70,
              child:ListView(

                children: <Widget>[
                  buildTitleImage(),
                  buildCell(0),
                  buildCell(1),
                  buildForget()

                ],
              )
          ),
          Positioned(
              left: 15,
              bottom: MediaQuery.of(context).padding.bottom + 20,
              height: 50,
              right: 15,
              child: MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: new Text('登录', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),

                ),
                onPressed: () {
                  commitLogin();
                },
              )
          )
        ],
      ),
    );
  }

  Widget buildTitleImage(){

    return Container(
      color: Colors.white,
      height: 140,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: (MediaQuery.of(context).size.width - 80)/2,
            width: 80,
            top: 30,
            height: 80,
            child: Image(image: AssetImage('images/login/ic_launcher.png')),
//            Image(image: AssetImage('')),
          )
        ],
      ),
    );
  }

  Widget buildCell(int index){

    List titleList = ['手机号','密码'];
    List hintList = ['请输入手机号','请输入密码'];

    List<TextInputType> inputList = [TextInputType.phone,TextInputType.visiblePassword];

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
              obscureText: index == 1?true:false,
//              style: TextStyle(textBaseline: TextBaseline.alphabetic),
              cursorColor: Colors.grey,
              keyboardType: inputList[index],
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
                }else {
                  password = value;
                }
              },
            ),
          ),
          Positioned(
            left: 5,
            right: 5,
            bottom: 1,
            height: 1,
            child: Container(
              color: Color(0xffeeeeee),
            ),
          )
        ],
      ),
    );
  }

  Widget buildForget(){

    return GestureDetector(
      onTap: (){
        print('忘记密码');
        Route_all.push(context, Forget());
      },
      child: Container(

        color: Colors.white,
        height: 50,
        child: Stack(
          children: <Widget>[
            Positioned(
              right: 15,
              width: 150,
              top: 0,
              bottom: 0,
              child: Container(
                alignment: Alignment.centerRight,
                child: Text('忘记密码',style: TextStyle(color: Color(0xff444444),fontSize: 14),),
              ),
            )
          ],
        ),
      ),
    );
  }

  commitLogin(){

    if(mobile == null){
      showToast('请输入手机号码');
      return;
    }
    if (!Helps().isChinaPhoneLegal(mobile)){

      showToast('手机号码格式不正确');
      return;
    }

    if(password == null){
      showToast('请输入密码');
      return;
    }

    if(password.length < 6){
      showToast('密码长度不能小于6');
      return;
    }

    Map<String, dynamic> map = Map();

    print('3333');
    map.putIfAbsent("mobile", () => mobile);
    map.putIfAbsent("password", () => password);

    print(map);

    Com_Service().post(map, "/user/login", (response) {

      print("登录成功");
      print(response);
      showToast('登录成功');
      Helps().saveToke(response['token']);
      blind(response['user_id'].toString());
      Route_all.pushAndRemove(context, Mimi());
    }, (fail) {
      print("失败");

    });
  }

  blind(String userid){

    // 设置别名指定设备推送 下方填写用户id
    //setAlias 设置用户别名用于极光指定推送
    FlutterJPush.setAlias(userid).then((map){
      print("设置用户推送别名---------------");
      print(map);
    });
  }



}