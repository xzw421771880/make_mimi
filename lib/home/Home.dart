

import 'package:flutter/material.dart';
import 'package:make_mimi/config/router_utils.dart';
import 'package:make_mimi/home/Complain/ComplainCenter.dart';
import 'package:make_mimi/home/Information.dart';
import 'package:make_mimi/home/Invite.dart';
import 'package:make_mimi/home/Notice.dart';
import 'package:make_mimi/home/Order/TaskOrder.dart';
import 'package:make_mimi/home/blind/Blind.dart';
import 'package:make_mimi/home/set/Setup.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body:  MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child:  ListView(
          children: <Widget>[
            buildInfo(),
            buildTitle(),
            Container(height: 5,),
            buildNumber(),
            buildTask(),
            buildTaskStatus(),
            buildCommit()
          ],
        ),
      )
    );
  }

  Widget buildInfo(){

    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[

          Padding(
            padding: EdgeInsets.all(0),
            child: Container(
              height: MediaQuery.of(context).padding.top,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(0),
            child: Container(
              height: 40,
              child: Stack(
                children: <Widget>[
                  Positioned(

                    left: 15,
                    top: 10,
                    height: 25,
                    width: 25,
                    child: GestureDetector(
                      onTap: (){
                        print('通知');
                        Route_all.push(context, Notices());
                      },
                      child: Image(image: AssetImage('images/home/home_notice.png'),),
                    ),
                  ),
                  Positioned(

                    right: 15,
                    top: 10,
                    height: 25,
                    width: 25,
                    child: GestureDetector(
                      onTap: (){
                        print('设置');
                        Route_all.push(context, Setup());

                      },
                      child: Image(image: AssetImage('images/home/home_shezhi.png'),),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(0),
            child: GestureDetector(
              onTap: (){
                print('个人信息');
                Route_all.push(context, Information());
              },
              child: Container(
                color: Colors.white,
                height: 110,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 15,
                      top: 15,
                      width: 70,
                      height: 70,
                      child: Image(image: AssetImage('images/home/home_icon.png'),),
                    ),
                    Positioned(
                      left: 110,
                      top: 20,
                      child: Text('张**',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    ),
                    Positioned(
                      left: 110,
                      top: 55,
                      child: Text('135****2514',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    ),
                    Positioned(
                      right: 20,
                      top: 35,
                      width: 15,
                      height: 17,
                      child: Image(image: AssetImage('images/home/home_right.png'),),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  //首页分类
  Widget buildTitle(){

    List<String> titleList  = ['邀请好友','帮助中心','申诉中心','账号绑定'];
    List<String> imageList = ['home_share','home_help','home_complain','home_blind'];
    List<Positioned> pList = new List();

    for (int i = 0; i< titleList.length;i++){

      pList.add(Positioned(
        left: i * MediaQuery.of(context).size.width/titleList.length,
        width: MediaQuery.of(context).size.width/titleList.length,
        top: 0,
        bottom: 0,
        child: GestureDetector(
          onTap: (){
            print('------${i}');
            if(i == 0){//邀请好友
              Route_all.push(context, Invite());
            }else if(i == 1){//限时特惠
//              Route_all.push(context, LimitTime());
            }else if(i == 2){//申诉中心
              Route_all.push(context, ComplainCenter());
            }else if(i == 3){//账号绑定
              Route_all.push(context, Blind());
            }
          },
          child: Container(
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: (MediaQuery.of(context).size.width/titleList.length -35)/2,
                  width: 35,
                  top: 15,
                  height: 35,
                  child: Image(image:  AssetImage('images/home/${imageList[i]}.png')),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  height: 20,
                  bottom: 15,
                  child: Text(titleList[i],textAlign: TextAlign.center,),
                )
              ],
            ),
          ),
        ),
      ));
    }

    return Container(
      height: 90,
//      color: Colors.red,
      child: Stack(
        children:pList,
      ),
    );
  }

  //账户
  Widget buildNumber(){

    List<String> titleList  = ['佣金（元）','本金（元）','保证金（元）'];
    List<String> numberList  = ['888.88','888.88','888.88'];
    List<Positioned> pList = new List();

    for (int i = 0; i< titleList.length;i++){

      pList.add(Positioned(
        left: i * MediaQuery.of(context).size.width/titleList.length+1,
        width: MediaQuery.of(context).size.width/titleList.length -5,
        top: 0,
        bottom: 0,
        child: GestureDetector(
          onTap: (){
            print('------${i}');
//            if(i == 0){//新品推荐
//              Route_all.push(context, NewProduct());
//            }else if(i == 1){//限时特惠
//              Route_all.push(context, LimitTime());
//            }else if(i == 2){//秒杀专场
//              Route_all.push(context, SecondsKill());
//            }else if(i == 3){//领优惠券
//              Route_all.push(context, GetCoupon());
//            }
          },
          child: Container(
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 0,
                  right: 0,
                  height: 20,
                  top: 15,
                  child: Text(titleList[i],textAlign: TextAlign.center,),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 55,
                  child: Text(numberList[i],textAlign: TextAlign.center,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                ),
                Positioned(
                  left: 0,
                  right: 15,
                  height: 20,
                  top: 95,
                  child: GestureDetector(
                    onTap: (){
                      print('提现');
                    },
                    child: Container(
                      child: Text('提现',textAlign: TextAlign.right,),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ));
    }

    return Container(
      height: 130,
//      color: Colors.red,
      child: Stack(
        children:pList,
      ),
    );
  }

  Widget buildTask(){
    return GestureDetector(
      onTap: (){
        print('我的任务');
        Route_all.push(context, TaskOrder());
      },
      child: Container(
        color: Colors.white,
        height: 50,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 15,
              top: 0,
              bottom: 0,
              width: 150,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text('我的任务',style: TextStyle(fontSize: 16),),
              ),
            ),
            Positioned(
              right: 50,
              top: 0,
              bottom: 0,
              width: 150,
              child: Container(
                alignment: Alignment.centerRight,
                child: Text('查看全部任务',style: TextStyle(fontSize: 14,color: Color(0xff444444)),),
              ),
            ),
            Positioned(
              right: 20,
              top: 17.5,
              width: 15,
              height: 15,
              child: Image(image: AssetImage('images/home/home_right.png'),),
            )
          ],
        ),
      ),
    );
  }

  //首页分类
  Widget buildTaskStatus(){

    List<String> titleList  = ['待接受','进行中','审核中','已超时'];
    List<String> imageList = ['home_task_wait','home_task_doing','home_task_review','home_task_over'];
    List<Positioned> pList = new List();

    for (int i = 0; i< titleList.length;i++){

      pList.add(Positioned(
        left: 20 + i * (MediaQuery.of(context).size.width -40)/titleList.length,
        width: (MediaQuery.of(context).size.width - 40)/titleList.length,
        top: 0,
        bottom: 0,
        child: GestureDetector(
          onTap: (){
            print('------${i}');
//            if(i == 0){//新品推荐
//              Route_all.push(context, NewProduct());
//            }else if(i == 1){//限时特惠
//              Route_all.push(context, LimitTime());
//            }else if(i == 2){//秒杀专场
//              Route_all.push(context, SecondsKill());
//            }else if(i == 3){//领优惠券
//              Route_all.push(context, GetCoupon());
//            }
          },
          child: Container(
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: ((MediaQuery.of(context).size.width - 40)/titleList.length - 25)/2,
                  width: 25,
                  top: 15,
                  height: 25,
                  child: Image(image:  AssetImage('images/home/${imageList[i]}.png')),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  height: 20,
                  bottom: 15,
                  child: Text(titleList[i],textAlign: TextAlign.center,),
                )
              ],
            ),
          ),
        ),
      ));
    }

    return Container(
      height: 80,
//      color: Colors.red,
      child: Stack(
        children:pList,
      ),
    );
  }

  Widget buildCommit(){

    return Container(
      color: Colors.white,
      height: 120,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 20,
            left: (MediaQuery.of(context).size.width - 80)/2,
            width: 80,
            height: 80,
            child: FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: (){

              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              color: Color(0xFF42A5F5),
              child:  Text('领取任务',style: TextStyle(color: Colors.white,fontSize: 16),),
            ),
          )
        ],
      )

    );
  }


}