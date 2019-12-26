import 'package:flutter/material.dart';


class TbCase extends StatefulWidget {


  @override
  _TbCaseState createState() => _TbCaseState();
}

class _TbCaseState extends State<TbCase> {


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
        title: Text('示例', style: TextStyle(fontSize: 15,
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

          buildTitle(),
        ],
      ),
    );
  }

  Widget buildTitle(){

    return Container(

      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(0),

            child: Container(
              height: 50,
              alignment: Alignment.center,
              child: Text('绑定淘宝买号示例',style: TextStyle(color: Color(0xffFF0000),fontSize: 19 ),),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15),

            child: Container(
              height: 30,
              alignment: Alignment.centerLeft,
              child: Text('1.淘宝会员名截图',style: TextStyle(fontSize: 15 ),),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15),

            child: Container(
              height: 30,
              alignment: Alignment.centerLeft,
              child: Text('打开手机淘宝APP',style: TextStyle(fontSize: 14 ),),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15,right: 200,top: 10),

            child: Container(
              height: 300,
              color: Colors.grey,

            ),
          )
        ],
      ),
    );
  }


}