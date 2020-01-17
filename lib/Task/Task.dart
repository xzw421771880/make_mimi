import 'package:flutter/material.dart';
import 'package:make_mimi/Task/TaskDetail.dart';
import 'package:make_mimi/config/router_utils.dart';
import 'package:make_mimi/utils/Help.dart';
import 'package:make_mimi/utils/XjSelete.dart';
import 'package:make_mimi/utils/com_service.dart';


class Task extends StatefulWidget {


  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {

  ScrollController _controller = new ScrollController();
  Map mydata = Map();
  List dataList = List();


  int totalSize = 0; //总条数
  String loadMoreText = "";
  TextStyle loadMoreTextStyle =
  new TextStyle(color: const Color(0xFF999999), fontSize: 14.0);
  int currentPage = 1;

  int currentIndex = 0;
  @override
  void initState() {
    super.initState();

    Helps().getToken().then((token) {
      print('first ====  ${token}');
      if (token == null){
        Helps().out(context, false);

      }else{

        getsquare();
      }

    });

  }

  getsquare() {
    Map<String, dynamic> map = Map();
    map.putIfAbsent("page", () => currentPage);
    map.putIfAbsent("pageSize", () => '10');
    map.putIfAbsent("task_type", () => currentIndex +1);
    Com_Service().post(map, "/task/square", (response) {
      print("任务");
      print(response);
      mydata = response;
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
    currentPage = 1;

    getsquare();
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
//        leading: new IconButton(icon: Icon(Icons.arrow_back_ios),
//            color: Color(0xff333333),
//            onPressed: () {
//              Navigator.pop(context);
//            }),
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
              left:0,
              right: 0,
              top: 0,
              height: 40,
              child: XjSelete(['垫付任务','浏览任务',], (index){

                currentIndex = index;
                print(index);
                _pullToRefresh();
                setState(() {

                });
              }, currentIndex)
          ),
          Positioned(
              left: 0,
              right: 0,
              top: 40,
              bottom: 0,
              child: RefreshIndicator(
                child: ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (BuildContext context,int index){

                    return buildCell(index);
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

  Widget buildCell(int index){
    Map item = dataList[index];
    print(index);
    print(item);
    return GestureDetector(
      onTap: (){
        Route_all.push(context, TaskDetail(item['id'], (index){

          print('1111');
          _pullToRefresh();
        }));
      },
      child: Container(
        height: 100,
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 15,
              top: 10,
              width: 80,
              height: 80,
              child: Image.network(item['goods_pic'],fit: BoxFit.cover,),
            ),
            Positioned(
              left: 105,
              top: 15,

              child: Text(item['shop_name']),
            ),
            Positioned(
              right: 15,
              top: 15,

              child: Text(item['type_name'],textAlign: TextAlign.right,),
            ),
            Positioned(
              left: 105,
              top: 40,

              child: Text('本金：${double.parse(item['goods_deal_price']) *int.parse(item['goods_count'])}元'),
            ),
            Positioned(
              left: 105,
              top: 65,

              child: Text('佣金：${item['task_commission']}元'),
            )
          ],
        ),
      ),
    );
  }


}