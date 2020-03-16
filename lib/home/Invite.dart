
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:make_mimi/config/router_utils.dart';
import 'package:make_mimi/home/InviteRecord.dart';
import 'package:make_mimi/utils/showtoast_util.dart';
import 'package:qr_flutter/qr_flutter.dart';


class Invite extends StatefulWidget {


  Map  user;

  Invite(this.user);

  @override
  _InviteState createState() => _InviteState();
}

class _InviteState extends State<Invite> {

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
//        textTheme: TextTheme(subtitle: "充币"),
          backgroundColor: Colors.white,
          title: Text('邀请好友', style: TextStyle(fontSize: 15,
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

              child: Text('邀请记录', style: TextStyle(color: Color(0xff333333),),),
              onPressed: (){
                print("111");
                Route_all.push(context, InviteRecord());

              },
            )

          ],

        ),
        body: ListView(

          children: <Widget>[
            buildBack(),

            Container(height: 20,),
            Text('推荐规则',textAlign: TextAlign.center,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
            Container(height: 20,),
            Text('一级粉丝完成任务后，可以获得好友收入的10%的分成奖励\n\n二级粉丝完成任务后，可以获得好友收入的5%的分成奖励\n\n三级粉丝完成任务后，可以获得好友收入的3%的分成奖励',textAlign: TextAlign.center,style: TextStyle(fontSize: 14)),
            Container(height: 20,),
          ],
        )
    );
  }

  Widget buildBack(){

    return Container(
      height: 600,
      child: Stack(
        children: <Widget>[
          Positioned(left: 0,top: 0,right: 0,bottom: 0, child: Image(image: AssetImage('images/home/home_invite_back.png'))),

          Positioned(

            left: 50,
            right: 50,
            top: 50,
            height: 400,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
//          border: Border.all(color: Colors.white,width: 20),
                  // 圆角度
                  borderRadius: new BorderRadius.circular(6.0),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(.5, .5), //阴影xy轴偏移量
                      blurRadius: .5, //阴影模糊程度
                      spreadRadius: 1, //阴影扩散程度
                    )
                  ]
              ),
              child: buildCodeDetail(),
            ),

          ),
//          Positioned(
//            bottom: 60,
//            left: 0,
//            right: 0,
//            child: Text('分享专属链接，邀请好友注册',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
//          )
        ],
      ),

    );
  }

  Widget buildCodeDetail(){
    return Container(
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 15),

            child: Text('您的邀请码为',style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          Padding(padding: EdgeInsets.all(0),

            child: Container(
              height: 40,
              child: Stack(
                children: <Widget>[
                  Positioned(left: 0,right: 0,top: 0,bottom: 0,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(widget.user['invite_code'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width/414 *23,color: Colors.orange),),
                    ),)
                ,
                  Positioned(
                    right: 30 * MediaQuery.of(context).size.width/414,
                    width: 60 * MediaQuery.of(context).size.width/414,
                    top: 7,
                    bottom: 7,
                      child: MaterialButton(
                        padding: EdgeInsets.all(0),
                        color: Colors.orange,
                        textColor: Colors.white,
                        child: Text('复制', style: TextStyle(fontSize: MediaQuery.of(context).size.width/414 *15, fontWeight: FontWeight.bold,),

                        ),
                        onPressed: () {

                          print('复制');
                          ClipboardData data = new ClipboardData(
                              text: widget.user['invite_code']);
                          Clipboard.setData(data);
//                  print('复制');
                          showToast('复制成功');
                          print('复制');
//                  Route_all.push(context, Login());
                        },
                      )
                  )
                ],
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(10),

            child: Text('好友也可在注册时直接填写邀请码',style: TextStyle(color: Colors.grey),),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: (MediaQuery.of(context).size.width - 260)/2,
                right: (MediaQuery.of(context).size.width - 260)/2,
                top: 15,
                bottom: 10
            ),
            child: Container(
              height: 160,
//              color: Colors.red,
              child: QrImage(
                data: 'http://sd.zy.hzchongqv.cn/app-release.apk',
//                embeddedImage:  NetworkImage(
//                    'http://yunhe.zy.hzchongqv.cn/uploads/image/logo.png'),
//                embeddedImageStyle: QrEmbeddedImageStyle(
//                  size: Size(30,30)
//                ),
              ),
            ),

          ),

          Padding(padding: EdgeInsets.all(10),

            child: Text('http://sd.zy.hzchongqv.cn/app-release.apk',style: TextStyle(fontSize: MediaQuery.of(context).size.width/414 *15),),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              height: 35,
//              color: Colors.red,
              child: MaterialButton(
                padding: EdgeInsets.all(0),
                color: Colors.orange,
                textColor: Colors.white,
                child: Text('复制链接', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,),

                ),
                onPressed: () {

                  print('复制');
                  ClipboardData data = new ClipboardData(
                      text: 'http://sd.zy.hzchongqv.cn/app-release.apk');
                  Clipboard.setData(data);
//                  print('复制');
                  showToast('复制成功');
                  print('复制');
//                  Route_all.push(context, Login());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContent(){

    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: (MediaQuery.of(context).size.width - 160)/2,
              right: (MediaQuery.of(context).size.width - 160)/2,
              top: 25,
              bottom: 10
            ),
            child: Container(
              height: 160,
//              color: Colors.red,
              child: QrImage(
                data: 'https://hao.360.com/?src=lm&ls=n31c42a959f',
//                embeddedImage:  NetworkImage(
//                    'http://yunhe.zy.hzchongqv.cn/uploads/image/logo.png'),
//                embeddedImageStyle: QrEmbeddedImageStyle(
//                  size: Size(30,30)
//                ),
              ),
            ),

          ),
//          Padding(
//            padding: EdgeInsets.all(10),
//            child: Container(
//              alignment: Alignment.center,
//              height: 35,
////              color: Colors.red,
//              child: Text('https://hao.360.com/?src=lm&ls=n31c42a959f',style: TextStyle(color: Color(0xff333333)),),
//            ),
//          ),
//          Padding(
//            padding: EdgeInsets.all(0),
//            child: Container(
//              height: 100,
////              color: Colors.red,
//              child: Stack(
//                children: <Widget>[
//                  Positioned(
//                    left: (MediaQuery.of(context).size.width - 240)/2,
//                    width: 90,
//                    top: 20,
//                    height: 40,
//                    child: MaterialButton(
//                      padding: EdgeInsets.all(0),
//                      color: Colors.blue,
//                      textColor: Colors.white,
//                      child: Text('复制链接', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,),
//
//                      ),
//                      onPressed: () {
//
//                        ClipboardData data = new ClipboardData(
//                            text: 'https://hao.360.com/?src=lm&ls=n31c42a959f');
//                        Clipboard.setData(data);
//                        showToast('复制成功',);
//
////                  Route_all.push(context, Login());
//                      },
//                    ),
//
//                  ),
//                  Positioned(
//                    right: (MediaQuery.of(context).size.width - 240)/2,
//                    width: 90,
//                    top: 20,
//                    height: 40,
//                    child: MaterialButton(
//                      padding: EdgeInsets.all(0),
//                      color: Colors.blue,
//                      textColor: Colors.white,
//                      child: Text('立即邀请', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,),
//
//                      ),
//                      onPressed: () {
//
////                  Route_all.push(context, Login());
//                      },
//                    ),
//
//                  )
//                ],
//              ),
//            ),
//          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              alignment: Alignment.center,
              height: 35,
//              color: Colors.red,
              child: Text('邀请码：${widget.user['invite_code']}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              height: 35,
//              color: Colors.red,
              child: MaterialButton(
                padding: EdgeInsets.all(0),
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('复制邀请码', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,),

                ),
                onPressed: () {

                  print('复制');
                  ClipboardData data = new ClipboardData(
                      text: widget.user['invite_code']);
                  Clipboard.setData(data);
//                  print('复制');
                  showToast('复制成功');
                  print('复制');
//                  Route_all.push(context, Login());
                },
              ),
            ),
          ),

        ],
      ),
    );
  }



}