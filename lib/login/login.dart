import 'package:flutter/material.dart';
import 'package:make_mimi/config/router_utils.dart';
import 'package:make_mimi/login/Forget.dart';
import 'package:make_mimi/login/Register.dart';


class Login extends StatefulWidget {


  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {


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
        title: Text('登录', style: TextStyle(fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Color(0xff333333),),),
        leading: new IconButton(icon: Icon(Icons.arrow_back_ios),
            color: Color(0xff333333),
            onPressed: () {
              Navigator.pop(context);
            }),
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
              bottom: 50,
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
              bottom: MediaQuery.of(context).padding.bottom,
              height: 50,
              right: 15,
              child: MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: new Text('登录', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),

                ),
                onPressed: () {

                  print('退出');
//                  Route_all.push(context, Login());
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
            child: Container(
              color: Colors.red,
            )
//            Image(image: AssetImage('')),
          )
        ],
      ),
    );
  }

  Widget buildCell(int index){

    List titleList = ['手机号','密码'];
    List hintList = ['请输入手机号','请输入密码'];


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

}