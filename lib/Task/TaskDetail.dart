import 'package:flutter/material.dart';
import 'package:make_mimi/config/router_utils.dart';
import 'package:make_mimi/home/Order/OperationOrder.dart';
import 'package:make_mimi/home/Order/OrderDetail.dart';
import 'package:make_mimi/utils/Help.dart';
import 'package:make_mimi/utils/MeColor.dart';
import 'package:make_mimi/utils/com_service.dart';
import 'package:make_mimi/utils/showtoast_util.dart';

typedef backSelete(int index);

class TaskDetail extends StatefulWidget {

  backSelete back;
  String id;
  TaskDetail(this.id,this.back);
  @override
  _TaskDetailState createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {

  List data = ['快递一直未送达','商品破损/少件','商品与描述不符'];
  Map taskInfo;
  Map orderMold = Map();
  List orderList = List();
  Map orderStatus = Map();
  List requires = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    getTaskInfo();

  }


  getTaskInfo() {
    print("getuser --------------");
    Map<String, dynamic> map = Map();
    map.putIfAbsent("id", () => widget.id);
    Com_Service().get(map, "/task/task-info", (response) {
      print("商品详情");
//      print(response);

      taskInfo = response;
      orderList = response['itemOrder'];
      orderMold = response['range']['order_mold'];
      orderStatus = response['range']['task_order_status'];
      print(response['range']);
      requires = response['requires'];

      setState(() {
        print("更新");
      });
//      print(meModel.balanceUsdt);
    }, (fail) {

    });
  }


//class Specifial extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
//        textTheme: TextTheme(subtitle: "充币"),
        backgroundColor: Colors.white,
        title: Text('任务详情', style: TextStyle(fontSize: 15,
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
          itemCount: orderList.length +4+1,
          itemBuilder:(BuildContext context,int index){
            if (index == 4){
              return buildRequird();
            }else if(index >4){
              return buildOrder(index - 5);
            } else{
              return buildCell(context,index);
            }

          }
      ),
    );
  }


  Widget buildCell(BuildContext context,int index){

//    String title = data[index];

    List titleList = ['店铺名称','任务类型','垫付金额','任务佣金'];
    List detailList = [taskInfo == null?'***':taskInfo['shop_name'],taskInfo == null?'***':taskInfo['type_name'],taskInfo == null?'***':'￥${taskInfo['find_pay_conut']}',taskInfo == null?'***':'￥${taskInfo['goods_show_price']}'];



    return  Container(
      height: 50,
      alignment: Alignment.center,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 15,
            top: 0,
            bottom: 0,
            width: 150,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(titleList[index]),
            ),
          ),
          Positioned(
            right: 20,
            top: 0,
            bottom: 0,
            width: 180,
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(detailList[index]),
            ),
          ),
          Positioned(
            right: 5,
            left: 5,
            bottom: 1,
            height: .5,
            child: Container(
              color: Color(0xffcccccc),
            ),
          )
        ],
      ),
    );
  }

  Widget buildRequird(){




    List <Padding> padList = [];
    padList.add(Padding(
      padding: EdgeInsets.only(left: 15,top: 15,bottom: 5),
      child: Container(
        alignment: Alignment.centerLeft,
        child: Text('商家要求'),
      ),
    ));
    for (int i = 0;i<requires.length;i++){
      padList.add(
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Container(
              alignment: Alignment.centerLeft,
              height: 40,
              color: Colors.white,
              child: Text('${requires[i]['task_require_name']}${requires[i]['item_order_require'] == null?'':'（${requires[i]['item_order_require']}）'}'),
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

  Widget buildOrder(int index){

    Map order = orderList[index];
    print(Helps().currentTimeMillis());

    bool isReciver = false;
    String butStr = '';
    bool isSelete = false;
    if(taskInfo['order_id'] != null){
      if(order['order_id'] != null){

        isReciver = true;
        butStr = '已接单';
        isSelete = false;
      }else{

        isReciver = false;

      }

    }else{

      isSelete = true;
      butStr = '接单';
      isReciver  = order['status'] == '1'&& Helps().currentTimeMillis() > int.parse(order['start_time']) && Helps().currentTimeMillis() < int.parse(order['over_time']) && int.parse( order['jd_count']) < int.parse( order['order_count']);
    }





    print('order');
    print(order);
    return Container(
      color: Colors.white,
      height: 120,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            top: 0,
            height: 10,
            right: 0,
            child: Container(
              color: Color(0x88eeeeee),
            ),
          ),
          Positioned(
            left: 15,
            top: 10,
            height: 40,
            width: 200,
            child: Container(
              alignment: Alignment.centerLeft,
//              child: Text('2222'),
              child: Text(orderMold[order['order_mold']],style: TextStyle(fontWeight: FontWeight.bold),),

            ),
          ),
          Positioned(
            right: 15,
            top: 10,
            height: 40,
            width: 200,
            child: Container(
              alignment: Alignment.centerRight,
//              child: Text('2222'),
              child: Text(orderStatus[order['status']],style: TextStyle(fontWeight: FontWeight.bold),),

            ),
          ),
          Positioned(
            left: 15,
            top: 50,
            height: 30,
            width: 300,
            child: Container(
              alignment: Alignment.centerLeft,
//              child: Text('2222'),
              child: Text('开始时间：'+Helps().strToDate(int.parse(order['start_time']))),

            ),
          ),
          Positioned(
            left: 15,
            top: 80,
            height: 30,
            width: 300,
            child: Container(
              alignment: Alignment.centerLeft,
//              child: Text('2222'),
              child: Text('结束时间：'+Helps().strToDate(int.parse(order['over_time']))),

            ),
          ),
          isReciver?
          Positioned(
            right: 15,
            top: 20 + 60.0,
            bottom: 10,
            width: 60,
            child: MaterialButton(
              color: MEColor.home,
              padding: EdgeInsets.all(0),
              child: Text(butStr,style: TextStyle(color: Colors.white),),
              onPressed: (){

                if(isSelete){
                  receiptOrder(order['id']);
                }
              },
            ),
          ):Container()
        ],
      ),
    );
  }

  receiptOrder(String taskOrderId) {
    print("getuser --------------");
    Map<String, dynamic> map = Map();
    map.putIfAbsent("taskOrderId", () => taskOrderId);
    Com_Service().get(map, "/task/receipt-order", (response) {
      print("接单结果");
      print(response);


      showToast('已提交接单');
      Route_all.push(context, OrderDetail(response['id'].toString()));
      setState(() {
        print("更新");
    });
  }, (fail) {

    });
  }


}