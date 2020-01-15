import 'package:flutter/material.dart';


class Information extends StatefulWidget {

  Map  user;

  Information(this.user);

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
    String name;
    String idCard;
    if(widget. user['realName'] != null){
      name = widget.user['realName'];
    }else{
      name = '未认证';
    }

    if(widget.user['idCardNum'] == null){

      idCard = '';
    }else{
      String str = widget.user['idCardNum'].toString();
      idCard = str.substring(str.length - 1,str.length) +'******' + str.substring(str.length - 1,str.length);
    }

    String phone = widget. user['mobile'].toString().substring(0,3)+"****"+widget. user['mobile'].toString().substring(7,11);

    Map tb =  widget.user['taobao'];

    List titleList = ['姓名','身份证号','手机号','QQ号码','性别','年龄段','淘宝号会员名','淘宝号心级','淘宝号性别','收货人','收货地址'];
    List detailList = [name,idCard,phone,widget.user['qq'],tb == null?'': tb['taobao_sex'],widget.user['ageBracket'],tb == null?'': tb['taobao_name'],tb == null?'': tb['taobao_level'],tb == null?'': tb['taobao_sex'],tb == null?'': tb['taobao_name'],tb == null?'': tb['province']+tb['city']+tb['district']+tb['detailed_address']];
//    List detailList = [name,idCard,phone,widget.user['qq'],tb['taobao_sex'],phone,widget.user['ageBracket'],'d','d','打撒','订单','多订单','dddsss'];

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