import 'package:flutter/material.dart';


class OrderDetail extends StatefulWidget {


  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {


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
        title: Text('任务订单详情', style: TextStyle(fontSize: 15,
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
          buildDetail(['待处理（33）']),
          buildTitle(1),
          buildDetail(['××旗舰店(淘宝垫付单）','任务编号：123456','本金：1254元','佣金：111元','派单时间：2019-10-10 10:10']),
          buildTitle(2),
          buildDetail(['允许使用花呗','允许使用信用卡']),
          buildTitle(3),
          buildDetail(['1允许使用信用卡','1允许使用信用卡']),

        ],
      ),
    );
  }

  Widget buildTitle(int index){
    List titleList = ['任务状态','任务信息','任务要求','商家要求'];

    return Container(
      color: Color(0xffcccccc),
      height: 40,
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

  Widget buildDetail(List list){

    List <Padding> padList = [];
    for (int i = 0;i<list.length;i++){
      padList.add(
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Container(
              alignment: Alignment.centerLeft,
              height: 40,
              color: Colors.white,
              child: Text(list[i]),
            ),
          )
      );
    }

    return Container(

      child: Column(
        children: padList,
      ),
    );


  }


}