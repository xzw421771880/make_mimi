import 'package:flutter/material.dart';
import 'package:make_mimi/utils/com_service.dart';

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
      print(response);

      taskInfo = response;

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
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            bottom: MediaQuery.of(context).padding.bottom,
            right:  0,
            height: 50,
            child: buildFoot(),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 50,
            child: ListView.builder(
                itemCount: 6,
                itemBuilder:(BuildContext context,int index){
                  if (index == 5){
                    return buildRequird();
                  }else{
                    return buildCell(context,index);
                  }

                }
            ),
          )
        ],
      ),
    );
  }


  Widget buildCell(BuildContext context,int index){

//    String title = data[index];

    List titleList = ['店铺名称','任务类型','垫付金额','任务佣金','允许使用花呗'];
    List detailList = [taskInfo == null?'***':taskInfo['shop_name'],taskInfo == null?'***':taskInfo['type_name'],taskInfo == null?'***':'￥${taskInfo['find_pay_conut']}',taskInfo == null?'***':'￥${taskInfo['goods_show_price']}','允许使用信用卡'];



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

    return Container(

      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 15,top: 15,bottom: 5),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text('商家要求'),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 15,top: 15,bottom: 5),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text('1.必须按照关键词搜索'),
              )
          ),
          Padding(
              padding: EdgeInsets.only(left: 15,top: 5,bottom: 5),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text('1.必须按照关键词搜索'),
              )
          )
        ],
      ),
    );
  }

  Widget buildFoot(){

    return Container(

      child: Stack(
        children: <Widget>[

          Positioned(
            right: 15,
            left: 15,
            top: 10,
            bottom: 0,
            child: MaterialButton(
              padding: EdgeInsets.all(0),
              child: Text('接受',style: TextStyle(color: Colors.white,fontSize: 16),),
              color: Colors.blue,
              onPressed: (){

                print('jj');
                Navigator.pop(context);
                widget.back(2);
              },
            ),
          )
        ],
      ),
    );
  }



}