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
        title: Text('手持照片参考', style: TextStyle(fontSize: 15,
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
            Container(height: 30,)

          ],
        )
    );
  }

  Widget buildImage(int index){

    List list = ['脸部、身份证和纸条要清晰，纸条内容如下：本人某某没有帮他人注册平台，没有卖账号给他人，出现诈骗退款本人承担全部责任，立此为据！'];

    return Container(
//      height: 300,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child:Text(list[index],style: TextStyle(fontSize: 16),),
          ),
          Padding(padding: EdgeInsets.only(left: 20,top: 10,bottom: 20,right: 100),
            child: Image(image: AssetImage('images/login/login_register_idcardsc.png')),
          )
        ],
      ),
    );
  }


}