import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:make_mimi/config/router_utils.dart';
import 'package:make_mimi/home/Order/CancelOrder.dart';
import 'package:make_mimi/home/Order/Evaluation.dart';
import 'package:make_mimi/home/Order/OrderDetail.dart';
import 'package:make_mimi/utils/XjSelete.dart';


class TaskOrder extends StatefulWidget {

  int currentIndex = 0;
  TaskOrder(this.currentIndex);
  @override
  _TaskOrderState createState() => _TaskOrderState();
}

class _TaskOrderState extends State<TaskOrder> {



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


  //下拉
  Future _pullToRefresh() async {
    print("111");
//    currentPage = 1;
//    getOrderList();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
//        textTheme: TextTheme(subtitle: "充币"),
        backgroundColor: Colors.white,
        title: Text('任务订单', style: TextStyle(fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Color(0xff333333),),),
        leading: new IconButton(icon: Icon(Icons.arrow_back_ios),
            color: Color(0xff333333),
            onPressed: () {
              Navigator.pop(context);
            }),
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
              left:0,
              right: 0,
              top: 0,
              height: 40,
              child: XjSelete(['全部','待处理','进行中','审核中','已完成','已拒绝','已超时'], (index){

                widget.currentIndex = index;
                print(index);
//                _pullToRefresh();
                setState(() {

                });
              }, widget.currentIndex)
          ),
          Positioned(
              left: 0,
              right: 0,
              top: 40,
              bottom: 0,
              child: RefreshIndicator(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (BuildContext context,int index){

                    return buildCell();
//                    if (index == datalist.length){
//                      return _buildProgressMoreIndicator();
//                    }else{
//                      return buildCell(context, index);
//                    }

                  },
//                  controller: _controller,
                ),
                onRefresh: _pullToRefresh,
              )
          )
        ],
      ),
    );
  }

  Widget buildCell(){

    return GestureDetector(
      onTap: (){

        Route_all.push(context, OrderDetail());
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
                        child: Text('××旗舰店(淘宝垫付单）'),
                      ),
                    ),
                    Positioned(
                      right: 15,
                      width: 150,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text('待处理'),
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
                child: Text('任务编号：123456'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Container(
                height: 30,
                alignment: Alignment.centerLeft,
                child: Text('本金：1254元'),
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
                        child: Text('佣金：111元'),
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
              padding: EdgeInsets.all(0),
              child: Container(
                height: 50,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      right: 20,
                      top: 10,
                      width: 130,
                      bottom: 10,
                      child: MaterialButton(
                        padding: EdgeInsets.all(0),
                        color: Colors.grey,
                        child: Text('上传收货评价截图',style: TextStyle(color: Colors.white),),
                        onPressed: (){

                          Route_all.push(context, Evaluation());
                        },
                      ),
                    ),
                    Positioned(
                      right: 165,
                      top: 10,
                      width: 50,
                      bottom: 10,
                      child: MaterialButton(
                        padding: EdgeInsets.all(0),
                        color: Colors.grey,
                        child: Text('取消',style: TextStyle(color: Colors.white),),
                        onPressed: (){

                          Route_all.push(context, CancelOrder());
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),

      ),
    );
  }

}
