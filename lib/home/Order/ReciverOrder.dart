import 'package:flutter/material.dart';
import 'package:make_mimi/utils/OrderAlert.dart';


class ReciverOrder extends StatefulWidget {


  @override
  _ReciverOrderState createState() => _ReciverOrderState();
}

class _ReciverOrderState extends State<ReciverOrder> {


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
        title: Text('接单', style: TextStyle(fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Color(0xff333333),),),
        leading: new IconButton(icon: Icon(Icons.arrow_back_ios),
            color: Color(0xff333333),
            onPressed: () {
              Navigator.pop(context);
            }),
        elevation: 0,
          actions: <Widget>[
            MaterialButton(

              child: Text('绑定账号', style: TextStyle(color: Color(0xff333333),),),
              onPressed: (){
                print("111");
//                Route_all.push(context, DrawRecord());

              },
            )

          ]
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 400,
              child:ListView(

                children: <Widget>[

                  buildThird(0),
                  buildThird(1),
                  buildThird(2),
                ],
              )
          ),
          Positioned(
              left: 0,
              bottom: MediaQuery.of(context).padding.bottom,
              height: 400,
              right: 0,
              child:buildFoot(),
          )
        ],
      ),
    );
  }

  Widget buildFoot(){
    return Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 20,
              left: (MediaQuery.of(context).size.width - 80)/2,
              width: 80,
              height: 80,
              child: FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: (){

                  showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return OrderAlert((resonBack){

//                          reson = resonBack;
                          setState(() {

                          });
                        });
                      }
                  );
//                  Route_all.push(context, ReciverOrder());
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                color: Color(0xFF42A5F5),
                child:  Text('停止',style: TextStyle(color: Colors.white,fontSize: 16),),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 125,
              child: Text('00:08',textAlign: TextAlign.center,style: TextStyle(
                color: Color(0xff333333)
              ),),

            ),
            Positioned(
              left: 70,
              right: 70,
              bottom: 160,
              child: Text('每日接单量上限由系统风控自动判断无需咨询客服原因，回复结果一样',maxLines: 10,textAlign: TextAlign.center,style: TextStyle(
                  color: Color(0xff333333)
              ),),

            )
          ],
        )

    );
  }

  Widget buildThird(int index){

    List imageList = ['order_reciver_tb','order_reciver_jd','order_reciver_pdd'];

    return Container(
      height: 80,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 15,
            top: 15,
            bottom: 15,
            width: 50,
            child: Image(image: AssetImage('images/order/${imageList[index]}.png')),
          ),
          Positioned(
            left: 100,
            top: 15,
            width: 150,
            child: Text('账户名称（审核通过）',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
          ),
          Positioned(
            left: 100,
            bottom: 15,
            width: 150,
            child: Text('今日已结任务0/1单',style: TextStyle(color: Colors.grey,fontSize: 14),),
          ),
          Positioned(
            right: 5,
            left: 5,
            bottom: 1,
            height: .5,
            child: Container(
              color: Color(0xffcccccc),
            ),
          ),
          Positioned(
            right: 10,
            top: 0,
            bottom: 0,
            width: 60,
            child: Switch(
                value: true,
                activeColor: Colors.green,
                onChanged: (bool value){

                }
            ),
          ),
        ],
      ),
      
      
    );

  }


}