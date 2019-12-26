import 'package:flutter/material.dart';
import 'package:make_mimi/config/router_utils.dart';
import 'package:make_mimi/home/Complain/CommitComplain.dart';
import 'package:make_mimi/home/Complain/ComplainDetail.dart';
import 'package:make_mimi/utils/XjSelete.dart';


class ComplainCenter extends StatefulWidget {


  @override
  _ComplainCenterState createState() => _ComplainCenterState();
}

class _ComplainCenterState extends State<ComplainCenter> {

  int currentIndex = 0;

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
        title: Text('申诉中心', style: TextStyle(fontSize: 15,
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
              Route_all.push(context, CommitComplain());

            },
          )

        ],
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
//                _pullToRefresh();
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
        Route_all.push(context, ComplainDetail());
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
                          child: Text('任务ID：123456'),
                        ),
                      ),
                      Positioned(
                        right: 15,
                        width: 150,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text('客服通过申述'),
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
                  child: Text('申述店铺：××旗舰店'),
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
                          child: Text('申述类型：违规操作'),
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