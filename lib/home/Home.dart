

import 'package:flutter/material.dart';
import 'package:flutter_jpush/flutter_jpush.dart';
import 'package:make_mimi/Task/TaskDetail.dart';
import 'package:make_mimi/config/router_utils.dart';
import 'package:make_mimi/home/money/CommissionRecord.dart';
import 'package:make_mimi/home/Complain/ComplainCenter.dart';
import 'package:make_mimi/home/HelpCenter.dart';
import 'package:make_mimi/home/Information.dart';
import 'package:make_mimi/home/Invite.dart';
import 'package:make_mimi/home/Notice.dart';
import 'package:make_mimi/home/Order/OrderDetail.dart';
import 'package:make_mimi/home/Order/ReciverOrder.dart';
import 'package:make_mimi/home/Order/TaskOrder.dart';
import 'package:make_mimi/home/blind/Blind.dart';
import 'package:make_mimi/home/money/BlindBank.dart';
import 'package:make_mimi/home/money/Draw.dart';
import 'package:make_mimi/home/money/MoneyRecord.dart';
import 'package:make_mimi/home/money/Topup.dart';
import 'package:make_mimi/home/set/Setup.dart';
import 'package:make_mimi/login/Certification.dart';
import 'package:make_mimi/utils/AlertGo.dart';
import 'package:make_mimi/utils/Help.dart';
import 'package:make_mimi/utils/OutEvent.dart';
import 'package:make_mimi/utils/com_service.dart';
import 'package:make_mimi/utils/showtoast_util.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map  user;
  @override
  void initState() {
    super.initState();
    _initJPush();

    Helps().getToken().then((token) {
      print('first ====  ${token}');
      if (token == null){
        Helps().out(context, false);

      }else{

        getInfo();
      }

    });


    outEvent.on().listen((value){
      Helps().out(context, false);
    });




  }

  isFirst(){
    Helps().getFirst().then((first) {
      print('first ====  ${first}');
      if (first == null){
        alertFirst();
        Helps().saveFirst('111');
      }else{

      }

    });
  }

  alertFirst(){

    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertGo();
        }
    );
  }


  void _initJPush() async {
    await FlutterJPush.startup();
    print("初始化jpush成功");

    // 获取 registrationID
    var registrationID =await FlutterJPush.getRegistrationID();
    print('registrationID-----${registrationID}');

    // 注册接收和打开 Notification()
    _initNotification();
  }

  void _initNotification() async {
    FlutterJPush.addReceiveNotificationListener(
            (JPushNotification notification) {

          print("收到推送提醒: ${notification.id}");
          print("收到推送提醒: ${notification.extras}");
          if(notification.extras['target'] == 'task'){
            Route_all.push(context, TaskDetail(notification.extras['targetId'].toString(), (index){

              print('1111');
            }));
          }

          if(notification.extras['target'] == 'order'){
            Route_all.push(context, OrderDetail(notification.extras['targetId'].toString()));
          }

          print(notification);
        }
    );

    FlutterJPush.addReceiveOpenNotificationListener(
            (JPushNotification notification) {
          print("打开了推送提醒: $notification");
        }
    );
  }


  getInfo() {
    print("getuser --------------");
    Com_Service().post(Map(), "/user/info", (response) {
      print("个人信息详情");
      print(response);

      user = response;
      isFirst();


      setState(() {
        print("更新");
      });
//      print(meModel.balanceUsdt);
    }, (fail) {

    });
  }




  //下拉
  Future _pullToRefresh() async {
    getInfo();
    return null;
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body:  MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child:  RefreshIndicator(child: ListView(
          children: <Widget>[
            buildInfo(),
            buildTitle(),
            Container(height: 5,),
            buildMoney(),
            Container(height: 5,),
            buildNumber(),
            Container(height: 5,),
            buildTask(),
            buildTaskStatus(),
//            buildCommit()
          ],
        ), onRefresh:_pullToRefresh),
      )
    );
  }



  Widget buildInfo(){
    String name = '游客';
    String  phone = '暂无';

    if (user !=null){
      if(user['realName'] != null){
        name = user['realName'];
      }else{
        name = '未认证';
      }
      phone = user['mobile'].toString().substring(0,3)+"****"+user['mobile'].toString().substring(7,11);
    }

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
                if(user == null){
                  print('请登录');
                }else{
                  if(user['realName'] != null){
//                    name = user['realName'];
                    Route_all.push(context, Information(user));
                  }else{
                    Route_all.push(context, Certification((){
                      _pullToRefresh();
                    }));
                  }

                }

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
                      child: Text(name,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    ),
                    Positioned(
                      left: 110,
                      top: 55,
                      child: Text(phone,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
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
              if(user == null){
                print('请登录');
              }else{
                Route_all.push(context, Invite(user));
              }
            }else if(i == 1){//帮助中心
              Route_all.push(context, HelpCenter());
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

  Widget buildMoney(){
    return GestureDetector(
      onTap: (){
        print('我的资产');
        Route_all.push(context, MoneyRecord());
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
                child: Text('我的资产',style: TextStyle(fontSize: 16),),
              ),
            ),
            Positioned(
              right: 50,
              top: 0,
              bottom: 0,
              width: 150,
              child: Container(
                alignment: Alignment.centerRight,
                child: Text('资产明细',style: TextStyle(fontSize: 14,color: Color(0xff444444)),),
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

  //账户
  Widget buildNumber(){

    List<String> titleList  = ['总资产（元）','保证金（元）'];
    List<String> numberList  = [user == null?'0.00':user['total_balance'].toString(),user == null?'0.00':user['deposit']];
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
                  width: 100,
                  right: 15,
                  height: 20,
                  top: 95,
                  child: GestureDetector(
                    onTap: (){
                      print('提现');
                      if(user['bank_name'] == null){
                        Route_all.push(context, BlindBank((){
                          _pullToRefresh();
                        }));
                      }else{
                        if (i == 0){
                          Route_all.push(context, Draw('2', user['total_balance'].toString(), user['bank_name'],user['bank_num'], (){
                            _pullToRefresh();
                          }));
                        }else{
                          showDialog<Null>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return  AlertDialog(
                                title:  Text('提示'),
                                content:  SingleChildScrollView(
                                  child:  ListBody(
                                    children: <Widget>[
                                      Text('提现保证金后不能接收任务，是否提现', style: TextStyle(
                                        ///字体颜色
                                        color: Colors.red,
                                        ///字体的大小
                                        fontSize: 16,
                                      )),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    child:  Text('确定'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      backMoney();
                                    },
                                  ),
                                  FlatButton(
                                    child:  Text('取消'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }

                      }


                    },
                    child: Container(
                      color: Colors.white,
                      child: Text(['提现','退保证金'][i],textAlign: TextAlign.right,),
                    ),
                  ),
                ),
                i == 1?
                Positioned(
                  width: 50,
                  left: 15,
                  height: 20,
                  top: 95,
                  child: GestureDetector(
                    onTap: (){
                      print('充值');
                      Route_all.push(context, Topup());
                    },
                    child: Container(
                      color: Colors.white,
                      child: Text('充值',textAlign: TextAlign.left,),
                    ),
                  ),
                ):Container()
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

  backMoney(){
    Map<String, dynamic> map = Map();

    map.putIfAbsent("amount", () => user['deposit']);
    map.putIfAbsent("type", () => '4');

    print(map);

    Com_Service().post(map, "/user/withdraw", (response) {

      print("提现成功");
      print(response);
      showToast('提交成功');
    }, (fail) {
      print("失败");

    });
  }

  Widget buildTask(){
    return GestureDetector(
      onTap: (){
        print('我的任务');
//        Route_all.push(context, TaskOrder(0));
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
//            Positioned(
//              right: 50,
//              top: 0,
//              bottom: 0,
//              width: 150,
//              child: Container(
//                alignment: Alignment.centerRight,
//                child: Text('查看全部任务',style: TextStyle(fontSize: 14,color: Color(0xff444444)),),
//              ),
//            ),
//            Positioned(
//              right: 20,
//              top: 17.5,
//              width: 15,
//              height: 15,
//              child: Image(image: AssetImage('images/home/home_right.png'),),
//            )
          ],
        ),
      ),
    );
  }

  //首页分类
  Widget buildTaskStatus(){

    List<String> titleList  = ['全部','进行中','已完成','已取消'];
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
            Route_all.push(context, TaskOrder(i));

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
      color: Colors.white,
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

//                getsquare();
                Route_all.push(context, ReciverOrder());
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