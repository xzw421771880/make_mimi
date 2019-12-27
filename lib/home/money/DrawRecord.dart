import 'package:flutter/material.dart';


class DrawRecord extends StatefulWidget {


  @override
  _DrawRecordState createState() => _DrawRecordState();
}

class _DrawRecordState extends State<DrawRecord> {


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
        title: Text('提现记录', style: TextStyle(fontSize: 15,
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
            return buildCell();
          }),
    );
  }

  Widget buildCell(){

    return GestureDetector(
      onTap: (){
//        Route_all.push(context, ComplainDetail());
      },
      child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(0),
                child: Container(
                  height: 5,
                  color: Color(0x99eeeeee),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(0),
                child: Container(
                  height: 30,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 15,
                        width: 150,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text('保障金提现'),
                        ),
                      ),
                      Positioned(
                        right: 15,
                        width: 150,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text('提现成功'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Container(
                  height: 30,
                  alignment: Alignment.centerLeft,
                  child: Text('开户人：张三'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Container(
                  height: 30,
                  alignment: Alignment.centerLeft,
                  child: Text('提现银行：工商银行'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Container(
                  height: 30,
                  alignment: Alignment.centerLeft,
                  child: Text('银行账号：123456789'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(0),
                child: Container(
                  height: 30,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 15,
                        width: 150,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text('转出金额：888'),
                        ),
                      ),
                      Positioned(
                        right: 15,
                        width: 150,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text('2019-10-10 10:10'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width - 85,right: 20,top: 10,bottom: 10),
                child: GestureDetector(
                  onTap: (){
                    print('删除');
                  },
                  child: Container(
                    height: 25,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      //设置填充颜色
                      color: Colors.grey,
                      // 圆角度
                      borderRadius: new BorderRadius.circular(6),
//                    border: Border.all(color: Colors.blue,width: .5),
                    ),
                    child: Text('删除',style: TextStyle(color: Colors.white,fontSize: 15),),
                  ),
                ),
              )
            ],
          )

      ),
    );
  }


}