import 'package:flutter/material.dart';


class Information extends StatefulWidget {


  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {


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
          title: Text('个人信息', style: TextStyle(fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color(0xff333333),),),
          leading: new IconButton(icon: Icon(Icons.arrow_back_ios),
              color: Color(0xff333333),
              onPressed: () {
                Navigator.pop(context);
              }),
          elevation: 0,
        ),
        body: ListView(

          children: <Widget>[

            buildTitle(0),
            buildCell(0),
            buildCell(1),
            buildCell(2),
            buildCell(3),
            buildCell(4),
            buildCell(5),
            buildTitle(1),
            buildCell(6),
            buildCell(7),
            buildCell(8),
            buildCell(9),
            buildCell(10)
          ],
        )
    );
  }

  Widget buildTitle(int index){
    List titleList = ['基本信息','淘宝信息'];

    return Container(
      color: Color(0xffcccccc),
      height: 50,
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


  Widget buildCell(int index){
    List titleList = ['姓名','身份证号','手机号','QQ号码','性别','年临段','淘宝号会员名','淘宝号心级','淘宝号性别','收货人','收货地址'];
    List detailList = ['姓名','身份证号','手机号','QQ号码','性别','年临段','淘宝号会员名','淘宝号心级','淘宝号性别','收货人','收货地址'];

    return Container(
      color: Colors.white,
      height: 50,
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
          Positioned(
            right: 15,
            width: 150,
            top: 0,
            bottom: 0,
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(detailList[index],),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            height: 1,
            bottom: 0,
            child: Container(
              color: Color(0xffdddddd),
            ),
          ),
        ],
      ),
    );
  }



}