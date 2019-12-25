
import 'package:flutter/material.dart';


class CommissionRecord extends StatefulWidget {


  @override
  _CommissionRecordState createState() => _CommissionRecordState();
}

class _CommissionRecordState extends State<CommissionRecord> {


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
          title: Text('佣金记录', style: TextStyle(fontSize: 15,
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
            itemCount: 3,
            itemBuilder: (BuildContext context,int index){

              return buildCells(index);
            }
        ),
    );
  }


  Widget buildCells(int index){

    List<String> listStr =[];
    if (index == 0){
      listStr = ['来源账号','类别','金额','日期'];
    }else{
      listStr = ['18888888','一级分佣','8.88','2019-10-10 10:10'];
    }

    List<Positioned>  list = getDataList(listStr);
    return Container(
      height: 40,
      color: Colors.white,
      child: Stack(
        children: list,
      ),
    );
  }

  List<Positioned> getDataList(List listStr){

//    String dataStr  = strToDate(int.parse(record["created_at"]));

//    List<String> listStr = [dataStr,record["currency_name"],record["amount"],record["fee"] ,statusList[int.parse(record["status"])]];

    List<Positioned>  list = new List<Positioned>();
    for(int i = 0;i< listStr.length;i++){
      list.add(buildPosition(i,listStr[i]));
    }
    return list;
  }

  String strToDate(int dataStr){
    var date2 = DateTime.fromMillisecondsSinceEpoch(dataStr*1000);
    List<String> list  = date2.toString() .split('.');
    print('------------------------时间戳转日期：${list[0]}');
    return list[0];
  }


  Positioned buildPosition(int index,String title){
    return Positioned(
      left:  5 +index *(MediaQuery.of(context).size.width - 10)/4,
      top: 0,
      bottom: 0,
      width: (MediaQuery.of(context).size.width - 10)/4,
      child:
      Container(

//        color: Colors.grey,
        alignment: Alignment.center,
        child: Text(title,maxLines: 1,style: TextStyle(
          fontSize: 13,
          color: Color(0xff555555),
        ),),
      ),
    );
  }

}