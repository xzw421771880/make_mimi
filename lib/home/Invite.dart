
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:make_mimi/config/router_utils.dart';
import 'package:make_mimi/home/InviteRecord.dart';
import 'package:make_mimi/utils/showtoast_util.dart';
import 'package:qr_flutter/qr_flutter.dart';


class Invite extends StatefulWidget {


  @override
  _InviteState createState() => _InviteState();
}

class _InviteState extends State<Invite> {


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

            buildContent(),
          ],
        )
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
                data: 'dsadadadasdsadasdad',
//                embeddedImage:  NetworkImage(
//                    'http://yunhe.zy.hzchongqv.cn/uploads/image/logo.png'),
//                embeddedImageStyle: QrEmbeddedImageStyle(
//                  size: Size(30,30)
//                ),
              ),
            ),

          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              alignment: Alignment.center,
              height: 35,
//              color: Colors.red,
              child: Text('https://hao.360.com/?src=lm&ls=n31c42a959f',style: TextStyle(color: Color(0xff333333)),),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(0),
            child: Container(
              height: 100,
//              color: Colors.red,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: (MediaQuery.of(context).size.width - 240)/2,
                    width: 90,
                    top: 20,
                    height: 40,
                    child: MaterialButton(
                      padding: EdgeInsets.all(0),
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Text('复制链接', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,),

                      ),
                      onPressed: () {

                        ClipboardData data = new ClipboardData(
                            text: 'https://hao.360.com/?src=lm&ls=n31c42a959f');
                        Clipboard.setData(data);
                        showToast('复制成功',);

//                  Route_all.push(context, Login());
                      },
                    ),

                  ),
                  Positioned(
                    right: (MediaQuery.of(context).size.width - 240)/2,
                    width: 90,
                    top: 20,
                    height: 40,
                    child: MaterialButton(
                      padding: EdgeInsets.all(0),
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Text('立即邀请', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,),

                      ),
                      onPressed: () {

//                  Route_all.push(context, Login());
                      },
                    ),

                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              alignment: Alignment.center,
              height: 35,
//              color: Colors.red,
              child: Text('邀请码：111111',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
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
//                  ClipboardData data = new ClipboardData(
//                      text: '111111');
//                  Clipboard.setData(data);
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