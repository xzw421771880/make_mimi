import 'package:flutter/material.dart';
import 'package:make_mimi/config/router_utils.dart';
import 'package:make_mimi/home/set/ChangPwd.dart';
import 'package:make_mimi/home/set/FeedBack.dart';
import 'package:make_mimi/login/login.dart';
import 'package:make_mimi/utils/Help.dart';


class Setup extends StatefulWidget {


  @override
  _SetupState createState() => _SetupState();
}

class _SetupState extends State<Setup> {


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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
//        textTheme: TextTheme(subtitle: "充币"),
        backgroundColor: Colors.white,
        title: Text('设置', style: TextStyle(fontSize: 15,
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
              right: 0,
              top: 0,
              bottom: 50,
              child:ListView(

                children: <Widget>[
                  buildCell(0),
                  buildCell(1),
                  buildWx(),
//                  buildWarn()
                ],
              )
          ),
          Positioned(
              left: 15,
              bottom: MediaQuery.of(context).padding.bottom,
              height: 50,
              right: 15,
              child: MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: new Text('退出', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),

                ),
                onPressed: () {

                  showDialog<Null>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return  AlertDialog(
                        title:  Text('警告'),
                        content:  SingleChildScrollView(
                          child:  ListBody(
                            children: <Widget>[
                              Text('是否确认退出', style: TextStyle(
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
                              Helps().out(context,false);
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


                },
              )
          )
        ],
      ),
    );
  }




  Widget buildCell(int index){

    List titleList = ['修改密码','留言反馈'];


    return GestureDetector(
      onTap: (){

        if(index == 0){
          print('修改登录密码');
          Route_all.push(context, ChangPwd());
        }else{

          print('留言反馈');
          Route_all.push(context, FeedBackVc());
        }
      },
      child: Container(

        height: 50,
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
              top: 20,
              bottom: 20,
              width: 10,
              child: Image(image: AssetImage('images/home/home_right.png'),),
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
      ),
    );
  }

  Widget buildWx(){


    return Container(

      height: 50,
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
              child: Text('客服微信'),
            ),
          ),
          Positioned(
            right: 20,
            top: 0,
            bottom: 0,
            width: 150,
            child: Container(
              alignment: Alignment.centerRight,
              child: Text('1242332'),
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

  Widget buildWarn(){


    return Container(

      height: 50,
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
              child: Text('任务提示音'),
            ),
          ),
          Positioned(
            right: 10,
            top: 0,
            bottom: 0,
            width: 60,
            child: Switch(
                value: true,
                activeColor: Colors.green,
                onChanged: (bool value){

                }
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


}