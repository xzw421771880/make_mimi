import 'package:flutter/material.dart';
import 'package:make_mimi/config/router_utils.dart';
import 'package:make_mimi/home/Complain/CommitComplain.dart';
import 'package:make_mimi/home/Complain/ComplainDetail.dart';
import 'package:make_mimi/utils/Help.dart';
import 'package:make_mimi/utils/XjSelete.dart';
import 'package:make_mimi/utils/com_service.dart';


class ComplainCenter extends StatefulWidget {


  @override
  _ComplainCenterState createState() => _ComplainCenterState();
}

class _ComplainCenterState extends State<ComplainCenter> {

  int currentIndex = 0;
  List dataList = List();
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    print("getuser --------------");
    Map<String, dynamic> map = Map();
    map.putIfAbsent("type", () => currentIndex == 0? 2:1);
    map.putIfAbsent("page", () => currentPage);
    map.putIfAbsent("pageSize", () => 20);
    Com_Service().get(map, "/appeal/appeal-list", (response) {
      print("商品详情");
      print(response);
      List list = response['list'];

      if (currentPage == 1){
        dataList.clear();
      }
      dataList.addAll(list);
      print(list);
      print(dataList);

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
//    currentPage = 1;
    getData();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
//        textTheme: TextTheme(subtitle: "充币"),
        backgroundColor: Colors.white,
        title: Text('申诉中心', style: TextStyle(fontSize: 15,
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
              child: XjSelete(['收到的申诉','发起的申诉'], (index){

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

    print(1111);
    print(dataList);
    Map item = dataList[index];
    print(item);
    String dataStr  = Helps(). strToDate(int.parse(item["updated_at"]));

    return GestureDetector(
      onTap: (){
        Route_all.push(context, ComplainDetail(item['id']));
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
                          child: Text('任务ID：${item['task_num']}'),
                        ),
                      ),
                      Positioned(
                        right: 15,
                        width: 150,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(item['appeal_type']),
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
                  child: Text('申述店铺：${item['appeal_type']}'),
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
                          child: Text('申述类型：${item['appeal_type']}'),
                        ),
                      ),
                      Positioned(
                        right: 15,
                        width: 150,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(dataStr),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              currentIndex == 1?
              Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width - 85,right: 20,top: 10,bottom: 10),
                child: Container(
                  height: 25,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    //设置填充颜色
                    color: Colors.white,
                    // 圆角度
                    borderRadius: new BorderRadius.circular(6),
                    border: Border.all(color: Colors.blue,width: .5),
                  ),
                  child: Text('撤销',style: TextStyle(color: Colors.blue,fontSize: 13),),
                ),
              ):Container()
            ],
          )

      ),
    );
  }


}