import 'package:flutter/material.dart';


class CertificationCase extends StatefulWidget {


  @override
  _CertificationCaseState createState() => _CertificationCaseState();
}

class _CertificationCaseState extends State<CertificationCase> {


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
        body: ListView(

          children: <Widget>[
            buildImage(0),
            buildImage(1),
            buildImage(2),
            Container(height: 30,)

          ],
        )
    );
  }

  Widget buildImage(int index){

    List list = ['身份证正面示例：','身份证反面示例：','手持参考照片：'];

    return Container(
      height: 300,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 15,
            right: 15,
            top: 25,

            child:Text(list[index],style: TextStyle(fontSize: 16),),
          ),
          Positioned(
            left: 20,
            right: 20,
            top: 60,
            bottom: 10,
            child: Container(
                color: Colors.white,
              ),
          )
        ],
      ),
    );
  }


}