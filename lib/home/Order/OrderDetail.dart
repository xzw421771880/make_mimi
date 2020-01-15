import 'package:flutter/material.dart';
import 'package:make_mimi/config/router_utils.dart';
import 'package:make_mimi/home/Complain/CommitComplain.dart';
import 'package:make_mimi/home/Order/Complete.dart';
import 'package:make_mimi/utils/Help.dart';
import 'package:make_mimi/utils/com_service.dart';


class OrderDetail extends StatefulWidget {

  String orderId;
  OrderDetail(this.orderId);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {



  Map orderInfo;
  Map orderMold = Map();
  List requires = List();
  Map orderStatus = Map();

  @override
  void initState() {
    super.initState();
    getOrderInfo();
  }

  getOrderInfo() {
    Map<String, dynamic> map = Map();
    map.putIfAbsent("orderId", () => widget.orderId);
    Com_Service().post(map, "/task/order-info", (response) {
      print("订单详情");
      print(response);
      orderInfo = response;
      orderMold = response['range']['order_mold'];
      requires = response['requires'];
      orderStatus = response['range']['orderStatus'];
      setState(() {
        print("更新");
      });
//      print(meModel.balanceUsdt);
    }, (fail) {

    });
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
        actions: <Widget>[
          MaterialButton(

            child: Text('发起申诉', style: TextStyle(color: Color(0xff333333),),),
            onPressed: (){
              print("111");
              Route_all.push(context, CommitComplain(widget.orderId));

            },
          )

        ],
      ),
      body: ListView(

        children: <Widget>[

          buildTitle(0),
          buildDetail([orderInfo == null?'**': orderStatus[orderInfo['status'].toString()]]),
          buildTitle(1),
          orderInfo == null?Container():
          buildItem(),
          buildTitle(2),
          orderInfo == null?Container():
          buildDetail(['${orderInfo['shop_name']}(${orderMold[orderInfo['task_mold']]})','任务编号：${orderInfo['id']}','本金：${orderInfo['goods_deal_price']}元','佣金：${orderInfo['task_commission']}元','派单时间：${Helps().strToDate(int.parse(orderInfo['updated_at']))}']),

          buildTitle(3),
          buildRequire(),

        ],
      ),
    );
  }

  Widget buildItem(){
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(0),
            child: Container(
              height: 120,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 15,
                    top: 10,
                    bottom: 10,
                    width: 100,
                    child: Image.network(orderInfo['goods_pic']),
                  ),
                  Positioned(
                      left: 120,
                      top: 10,
                      child: Text('搜索展示价格：${orderInfo['goods_show_price']}元')
                  ),
                  Positioned(
                      left: 120,
                      top: 40,
                      child: Text('商品成交价格：${orderInfo['goods_deal_price']}元')
                  ),
                  Positioned(
                      left: 120,
                      top: 70,
                      child: Text('店铺销量：${orderInfo['task_order_count']}件')
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildTitle(int index){
    List titleList = ['任务状态','商品信息','任务信息','任务要求'];

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

  Widget buildRequire(){

    List <Padding> padList = [];
    for (int i = 0;i<requires.length;i++){
      padList.add(
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Container(
              alignment: Alignment.centerLeft,
              height: 40,
              color: Colors.white,
              child: Text('${requires[i]['task_require_name']}${requires[i]['item_order_require'] == 'null'?'':'（${requires[i]['item_order_require']}）'}'),
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