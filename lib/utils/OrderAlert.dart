
import 'package:flutter/material.dart';

typedef backSelete(String reason);

class OrderAlert extends StatefulWidget {

  backSelete back;
  OrderAlert(this.back);
  @override
  _OrderAlertState createState() => _OrderAlertState();
}

class _OrderAlertState extends State<OrderAlert> {

  List data = ['快递一直未送达','商品破损/少件','商品与描述不符'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }



//class Specifial extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0x00000000),
        body: Stack(
            children: <Widget>[
              Positioned(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
              Positioned(
                  left: 30,
                  right: 30,
                  top: 100,
                  bottom: MediaQuery
                      .of(context)
                      .padding
                      .bottom + 200,
                  child: Container(
                    color: Colors.white,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 0,
                          bottom: 0,
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
                  )
              )
            ]
        )
    );
  }

  Widget buildCell(BuildContext context,int index){

//    String title = data[index];

    List titleList = ['店铺名称','任务类型','垫付金额','任务佣金','允许使用花呗'];
    List detailList = ['哈哈旗舰店','手机淘宝普通任务','￥8**.00','￥8**.00','允许使用信用卡'];



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
              width: 150,
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
            left: 15,
            width: 55,
            top: 10,
            bottom: 10,
            child: MaterialButton(
              padding: EdgeInsets.all(0),
              child: Text('拒绝',style: TextStyle(color: Colors.white),),
              color: Colors.grey,
              onPressed: (){

              },
            ),
          ),
          Positioned(
            left: 80,
            right: 80,
            top: 10,
            bottom: 10,
            child: MaterialButton(
              padding: EdgeInsets.all(0),
              child: Text('今日不在接受此店铺单',style: TextStyle(color: Colors.white),),
              color: Colors.grey,
              onPressed: (){

              },
            ),
          ),
          Positioned(
            right: 15,
            width: 55,
            top: 10,
            bottom: 10,
            child: MaterialButton(
              padding: EdgeInsets.all(0),
              child: Text('接受',style: TextStyle(color: Colors.white),),
              color: Colors.blue,
              onPressed: (){

              },
            ),
          )
        ],
      ),
    );
  }



}