import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:make_mimi/config/router_utils.dart';
import 'package:make_mimi/home/Order/CancelOrder.dart';
import 'package:make_mimi/home/Order/Complete.dart';
import 'package:make_mimi/home/Order/Evaluation.dart';
import 'package:make_mimi/home/Order/OrderDetail.dart';
import 'package:make_mimi/utils/Help.dart';
import 'package:make_mimi/utils/XjSelete.dart';
import 'package:make_mimi/utils/com_service.dart';


class TaskOrder extends StatefulWidget {

  int currentIndex = 0;
  TaskOrder(this.currentIndex);
  @override
  _TaskOrderState createState() => _TaskOrderState();
}

class _TaskOrderState extends State<TaskOrder> {


  ScrollController _controller = new ScrollController();
  Map mydata = Map();
  List dataList = List();


  int totalSize = 0; //总条数
  String loadMoreText = "";
  TextStyle loadMoreTextStyle =
  new TextStyle(color: const Color(0xFF999999), fontSize: 14.0);
  int currentPage = 1;

  Map taskType = Map();
  Map orderStatus = Map();

  @override
  void initState() {
    super.initState();
    getOrderList();

    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixel = _controller.position.pixels;
//      print(maxScroll);
//      print(pixel);
      if (maxScroll == pixel) {
        if (dataList.length < int.parse(mydata["count"])) {
          print("更多");
          setState(() {
            loadMoreText = "正在加载中...";
            loadMoreTextStyle =
            new TextStyle(color: const Color(0xFF4483f6), fontSize: 14.0);
          });
          loadMoreData();
        }
      } else {
        if (dataList.length == int.parse(mydata["count"])) {
          loadMoreText = "没有更多数据";
          loadMoreTextStyle =
          new TextStyle(color: const Color(0xFF999999), fontSize: 14.0);
          setState(() {

          });
        }
      }
    });
  }


  getOrderList() {
    Map<String, dynamic> map = Map();
    map.putIfAbsent("status", () => widget.currentIndex);
    map.putIfAbsent("page", () => currentPage);
    map.putIfAbsent("pageSize", () => 20);
    Com_Service().post(map, "/task/order-list", (response) {
      print("订单");
      print(response);
      mydata = response;
      taskType = response['range']['task_type'];
      orderStatus = response['range']['order_status'];
      if (currentPage == 1){
        dataList.clear();
      }
      dataList.addAll(response['list']);
      setState(() {
        print("更新");
      });
//      print(meModel.balanceUsdt);
    }, (fail) {

    });
  }


  //下拉
  Future _pullToRefresh() async {
    print("111");
    loadMoreText = "";
    currentPage = 1;
    getOrderList();
    return null;
  }

  //加载列表数据
  loadMoreData() async {
    this.currentPage++;
    print("more");
    getOrderList();

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
              child: XjSelete(['全部','进行中','已完成','已取消'], (index){

                widget.currentIndex = index;
                print(index);
                _pullToRefresh();
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
                  itemCount: dataList.length +1,
                  itemBuilder: (BuildContext context,int index){


                    if (index == dataList.length){
                      return Helps().footView(loadMoreText,loadMoreTextStyle);
                    }else{
                      return buildCell(index);
                    }

                  },
                  controller: _controller,
                ),
                onRefresh: _pullToRefresh,
              )
          )
        ],
      ),
    );
  }

  Widget buildCell(int index){

    Map item = dataList[index];
    print(item['status']);

    return GestureDetector(
      onTap: (){

        Route_all.push(context, OrderDetail(dataList[index]['id']));
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
                      width: 250,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(item['shop_name']),
//                        child: Text('${item['shop_name']}(${taskType[item['task_id']]}）'),
                      ),
                    ),
                    Positioned(
                      right: 15,
                      width: 200,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(orderStatus[item['status']]),
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
                child: Text('任务编号：${item['id']}'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Container(
                height: 30,
                alignment: Alignment.centerLeft,
                child: Text('本金：${item['goods_deal_price']}元'),
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
                        child: Text('佣金：${item['task_commission']}元'),
                      ),
                    ),
                    Positioned(
                      right: 15,
                      width: 150,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(Helps().strToDate(int.parse(item['updated_at']))),
                      ),
                    )
                  ],
                ),
              ),
            ),
            int.parse(item['status'])  == 1?

            Padding(
              padding: EdgeInsets.all(0),
              child: Container(
                height: 50,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      right: 20,
                      top: 10,
                      width: 120,
                      bottom: 10,
                      child: MaterialButton(
                        padding: EdgeInsets.all(0),
                        color: Colors.blue,
                        child: Text('确认并完成订单',style: TextStyle(color: Colors.white),),
                        onPressed: (){

                          Route_all.push(context, Complete(dataList[index]['id'],(){
                            _pullToRefresh();
                          }),);
                        },
                      ),
                    ),
                    Positioned(
                      right: 155,
                      top: 10,
                      width: 50,
                      bottom: 10,
                      child: MaterialButton(
                        padding: EdgeInsets.all(0),
                        color: Colors.grey,
                        child: Text('取消',style: TextStyle(color: Colors.white),),
                        onPressed: (){

                          Route_all.push(context, CancelOrder(dataList[index]['id'],(){
                            _pullToRefresh();
                          }),);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ):Container(),
            (int.parse(item['status']) == 0 || int.parse(item['status']) == 2)?
            Padding(
              padding: EdgeInsets.all(0),
              child: Container(
                height: 50,
                child: Stack(
                  children: <Widget>[

                    Positioned(
                      right: 20,
                      top: 10,
                      width: 50,
                      bottom: 10,
                      child: MaterialButton(
                        padding: EdgeInsets.all(0),
                        color: Colors.grey,
                        child: Text('取消',style: TextStyle(color: Colors.white),),
                        onPressed: (){

                          Route_all.push(context, CancelOrder(dataList[index]['id'],(){
                            _pullToRefresh();
                          }),);
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
                :Container(),
            (int.parse(item['status']) == 4 || int.parse(item['status']) == 6||int.parse(item['status']) == 7)?
            Padding(
              padding: EdgeInsets.all(0),
              child: Container(
                height: 50,
                child: Stack(
                  children: <Widget>[

                    Positioned(
                      right: 20,
                      top: 10,
                      width: 60,
                      bottom: 10,
                      child: MaterialButton(
                        padding: EdgeInsets.all(0),
                        color: Colors.grey,
                        child: Text('去评价',style: TextStyle(color: Colors.white),),
                        onPressed: (){

                          Route_all.push(context, Evaluation(dataList[index]['id'],(){
                            _pullToRefresh();
                          }),);
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
                :Container()
          ],
        ),

      ),
    );
  }

}
