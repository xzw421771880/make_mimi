import 'package:flutter/material.dart';
import 'package:make_mimi/config/router_utils.dart';
import 'package:make_mimi/login/CertificationCase.dart';


class Certification extends StatefulWidget {


  @override
  _CertificationState createState() => _CertificationState();
}

class _CertificationState extends State<Certification> {


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
        title: Text('实名认证', style: TextStyle(fontSize: 15,
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
                  buildWarn(),
                  buildImage(0),
                  buildImage(1),
                  buildImage(2),
                  Container(height: 30,)

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
                child: new Text('注册', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),

                ),
                onPressed: () {

                },
              )
          )
        ],
      ),
    );
  }


  Widget buildCell(int index){

    List titleList = ['姓名','身份证号码'];
    List hintList = ['请输入姓名','请输入身份证号码'];


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

  Widget buildWarn(){

    return Container(
      child: Column(

        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(0),
            child: Container(
              height: 35,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 20,
                    top: 15,
                    right: 120,
                    child: Text('可在不遮挡身份证的前提下盖上纸条'),
                  ),
                  Positioned(
                    width: 100,
                    top: 0,
                    right: 20,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: (){
                        print('查看示例');
                        Route_all.push(context, CertificationCase());
                      },
                      child: Container(
                        color: Color(0xffffff),
                        alignment: Alignment.bottomRight,
                        child: Text('查看实例',style: TextStyle(color: Color(0xff555555)),),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20,right: 15,top: 10,bottom: 5),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text('署名加备注：“仅用户实名认证，不可用于其他任何ddd用途'),
            ),

          )
        ],
      ),
    );
  }

  Widget buildImage(int index){

    return Container(
      height: 250,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 20,
            right: 20,
            top: 10,
            bottom: 10,
            child: GestureDetector(
              onTap: (){
                print(index);
              },
              child: Container(
                color: Colors.white,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: (MediaQuery.of(context).size.width - 120)/2,
                      top: 50,
                      width: 80,
                      height: 80,
                      child: Image(image: AssetImage('images/login/register_certi_add.png')),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 30,
                      right: 0,
                      child: Text('上传手持手写照（要求文字）',textAlign: TextAlign.center,style: TextStyle(fontSize: 17,color:Colors.grey),),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }


}