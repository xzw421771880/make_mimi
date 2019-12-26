
import 'package:flutter/material.dart';


class ComplainDetail extends StatefulWidget {


  @override
  _ComplainDetailState createState() => _ComplainDetailState();
}

class _ComplainDetailState extends State<ComplainDetail> {


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
        title: Text('申诉详情', style: TextStyle(fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Color(0xff333333),),),
        leading: new IconButton(icon: Icon(Icons.arrow_back_ios),
            color: Color(0xff333333),
            onPressed: () {
              Navigator.pop(context);
            }),
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: 8,
          itemBuilder: (BuildContext context,int index){

            if (index == 7){
              return buildImage();
            }else {
              return buildCell(index);
            }
          }
      ),
    );
  }

  Widget buildCell(int index){

    List list = ['任务ID：123456','申述店铺：××旗舰店','申述类型：违规操作','申述状态：客服通过申述','申述时间：2019-10-10 10:10','申述内容：买手违规使用花呗','申述图片：'];

    return Container(

      color: Colors.white,
      height: 40,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 15,
            right: 15,
            top: 0,
            bottom: 0,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(list[index]),
            ),
          )
        ],
      ),
    );
  }

  Widget buildImage(){

    return Container(
      color: Colors.white,
      height: 220,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 30,
            right: 30,
            top: 10,
            bottom: 10,
            child: Container(
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }


}