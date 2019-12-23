import 'package:flutter/material.dart';
import 'package:make_mimi/config/router_utils.dart';
import 'package:make_mimi/home/NoticeDetail.dart';
import 'package:make_mimi/utils/com_service.dart';


class Notices extends StatefulWidget {


  @override
  _NoticesState createState() => _NoticesState();
}

class _NoticesState extends State<Notices> {

  List notice = List();

  @override
  void initState() {
    super.initState();
//    getNotice();
  }

  getNotice() {
    print("getuser --------------");
    Com_Service().get(Map(), "/shop/notice/noticeList", (response){

      print("通知成功");
      print(response);
      notice = response['records'];

      setState(() {
        print("更新");
      });
//      print(meModel.balanceUsdt);
    }, (fail){

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeeeeee),
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
//        textTheme: TextTheme(subtitle: "充币"),
        backgroundColor: Colors.white,
        title: Text('通知消息', style: TextStyle(fontSize: 15,
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
//          itemCount: notice.length,
          itemCount: 3,
          itemBuilder: (BuildContext context,int index){

//            Map map = notice[index];


            return GestureDetector(
              onTap: (){
                Route_all.push(context, NoticeDetail());
              },
              child: Container(

                color: Colors.white,
                child: Column(

                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 15,top: 10),
                        child: Container(
                            height: 20,
                            alignment: Alignment.centerLeft,
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  left: 5,
                                  top: 7,
                                  bottom: 7,
                                  width: 6,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(3)),
                                      color: Colors.red,
                                    ),

                                  ),
                                ),
                                Positioned(
                                  left: 15,
                                  top: 0,
                                  bottom: 0,
                                  width: 200,
                                  child: Container(
                                    child: Text('佣金发放通知',maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                  ),
                                ),
                                Positioned(
                                  right: 15,
                                  top: 5,
                                  bottom: 5,
                                  width: 10,
                                  child: Image(image: AssetImage('images/home/home_right.png'),),
                                )
                              ],
                            )
                        )
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 15,bottom: 10,top: 10),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text('2019-10-10   10:10',),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30, right: 15,bottom: 15,top: 10),
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text('用户账号15555555555已订购年卡，逾期消息目前在建的目前在建的新建福厦铁路(莆田段)2022年开通运营...',maxLines: 10,style: TextStyle(color: Colors.grey),),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10,left: 10,),
                      child: Container(
                        color: Colors.grey,
                        height: 0.3,
                      ),
                    )

                  ],
                ),

              ),
            );
          }),
    );
  }


}