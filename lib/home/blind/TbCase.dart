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

          buildTitle(0),
          Container(height: 30,),
          buildTitle(1),
          Container(height: 30,),
          buildTitle(2),
          Container(height: 30,),
        ],
      ),
    );
  }

  Widget buildTitle(int index){
    List titleList = ['1.淘宝会员名截图','2.支付宝实名认证截图','3.淘宝心级截图'];
    List operateList = ['打开手机淘宝','打开支付宝','打开手机淘宝我的评价'];
    List imageList = ['home_blindtb_case1','home_blindtb_case2','home_blindtb_case3'];

    return Container(

      child: Column(
        children: <Widget>[
//          Padding(
//            padding: EdgeInsets.all(0),
//
//            child: Container(
//              height: 50,
//              alignment: Alignment.center,
//              child: Text('绑定淘宝买号示例',style: TextStyle(color: Color(0xffFF0000),fontSize: 19 ),),
//            ),
//          ),
          Padding(
            padding: EdgeInsets.only(left: 15),

            child: Container(
              height: 30,
              alignment: Alignment.centerLeft,
              child: Text(titleList[index],style: TextStyle(fontSize: 15 ),),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15),

            child: Container(
              height: 30,
              alignment: Alignment.centerLeft,
              child: Text(operateList[index],style: TextStyle(fontSize: 14 ),),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15,right: 200,top: 10),

            child: Container(
              height: 300,
              child: Image(image: AssetImage('images/home/${imageList[index]}.png')),

            ),
          )
        ],
      ),
    );
  }


}