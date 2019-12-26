
import 'package:flutter/material.dart';
import 'package:make_mimi/config/router_utils.dart';
import 'package:make_mimi/home/blind/TbCase.dart';


class BlindTb extends StatefulWidget {


  @override
  _BlindTbState createState() => _BlindTbState();
}

class _BlindTbState extends State<BlindTb> {


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
        title: Text('绑定淘宝', style: TextStyle(fontSize: 15,
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

                  buildWarn(),
                  buildText(0),
                  buildText(1),
                  buildCell(0),
                  buildText(2),
                  buildText(3),
                  buildCell(1),
                  buildText(4),
                  buildImagetitle(),
                  buildImages()
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
                },
              )
          )
        ],
      ),
    );
  }

  Widget buildWarn(){

    return Container(

      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: Text('淘宝号最少3心，会员名不是手机号，打开手机淘宝->我的淘宝->右上角设置，进入以后就能看到自己的淘宝会员名了',maxLines: 10,style: TextStyle(color: Color(0xffFD0000)),),
          ),
          Padding(
            padding: EdgeInsets.only(left: 50,right: 50,top: 5,bottom: 15),
            child: Container(
              height: 150,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  Widget buildCell(int index){

    List titleList = ['淘宝号性别','收货省市'];


    return GestureDetector(
      onTap: (){

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
              right: 45,
              top: 0,
              bottom: 0,
              width: 150,
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(titleList[index],style: TextStyle(fontWeight: FontWeight.bold),),
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
      ),
    );
  }

  Widget buildImagetitle(){


    return GestureDetector(
      onTap: (){

        print('查看示例');
        Route_all.push(context, TbCase());
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
                child: Text('上传淘宝截图'),
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
              right: 15,
              top: 0,
              bottom: 0,
              width: 150,
              child: Container(
                alignment: Alignment.centerRight,
                child: Text('查看示例',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.grey),),
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
      ),
    );
  }

  Widget buildText(int index){

    List titleList = ['淘宝会员名','淘宝号心级','收货人','收货人手机','收货详细地址'];
    List hintList = ['请输入淘宝会员名','请输入心级','收货人姓名（必须与淘宝一致）','请输入收货人手机','详细地址'];


    return Container(
      height: 50,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 15,
            width: 90,
            top: 0,
            bottom: 0,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(titleList[index]),
            ),
          ),
          Positioned(
            left: 110,
            right: 15,
            top: 0,
            bottom: 0,
            child: TextField(
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


  Widget buildImages(){

    return Container(
      height:  190,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 50,
            top: 40,
            width: 100,
            height: 100,
            child: Container(
              color: Colors.grey,
            ),
          ),
          Positioned(
            right: 50,
            top: 40,
            width: 100,
            height: 100,
            child: Container(
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }




}