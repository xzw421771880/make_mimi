import 'package:flutter/material.dart';
import 'package:make_mimi/config/router_utils.dart';
import 'package:make_mimi/home/money/TopupRecord.dart';
import 'package:make_mimi/utils/RefundReason.dart';


class Topup extends StatefulWidget {


  @override
  _TopupState createState() => _TopupState();
}

class _TopupState extends State<Topup> {

  String bank;

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
        title: Text('保证金充值', style: TextStyle(fontSize: 15,
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

              child: Text('充值记录', style: TextStyle(color: Color(0xff333333),),),
              onPressed: (){
                print("111");
                Route_all.push(context, TopupRecord());

              },
            )

          ]
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
                  buildWarn('请先手动通过 网银/手机银行 转账到平台指定收款账号,再如实按照转账金额提交充值申请.没有转账就提交充值申请，就视为恶意提交'),
                  buildTitle(0),
                  buildMessage(0),
                  buildMessage(1),
                  buildMessage(2),
                  buildMessage(3),
                  buildTitle(1),
                  buildText(0),
                  buildSel(),
                  buildText(1),
                  buildMessage(4),
                  buildWarn('每次最低转账充值1000元，充值一次提交一次，恶意提交将处罚或封号\n审核时间：早上9点到晚上8点\n大额转账：17:50分过后的请不要一笔超过50000以上的充值，银行原因可能会导致无法实时到账'),
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
                child: new Text('确认提交', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),

                ),
                onPressed: () {

                  print('确认提交');
//                  Route_all.push(context, Login());
                },
              )
          )
        ],
      ),
    );
  }

  Widget buildTitle(int index){
    List titleList = ['平台收款账号','提交转账信息'];

    return Container(
      color: Color(0xffcccccc),
      height: 40,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 15,
            width: 150,
            top: 0,
            bottom: 0,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(titleList[index],),
            ),
          ),

        ],
      ),
    );
  }

  Widget buildMessage(int index){

    List list = ['转账途径：网银、手机银行(禁止使用支付宝、微信转账）','收款户名： 张三','收款账号： 1251235123565236','收款银行： 建设银行','转账金额（元）：1000元'];

    return Container(
      height: 50,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 15,
            right: 15,
            top: 0,
            bottom: 0,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(list[index]),
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


  Widget buildText(int index){

    List titleList = ['转出银行卡姓名','转出银行卡卡号'];
    List hintList = ['请输入转出银行卡姓名','请输入银行卡卡号'];


    return Container(
      height: 50,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 15,
            width: 100,
            top: 0,
            bottom: 0,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(titleList[index]),
            ),
          ),
          Positioned(
            left: 120,
            right: 15,
            top: 0,
            bottom: 0,
            child: TextField(
//              style: TextStyle(textBaseline: TextBaseline.alphabetic),
              cursorColor: Colors.grey,
              keyboardType: TextInputType.visiblePassword,
              decoration:  new InputDecoration(
                hintText: hintList[index],
                contentPadding: EdgeInsets.only(top: 14,bottom: 0),
                border: InputBorder.none,
                hintStyle: TextStyle(
                  fontSize: 14,
                ),
              ),
              onChanged: (value){

              },
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


  Widget buildSel(){

    return GestureDetector(
      onTap: (){

        print('xz');
        showDialog(
            context: context,
            builder: (BuildContext context){
              return RefundReason(['快递一直未送达','商品破损/少件','商品与描述不符'],(resonBack){

                bank = resonBack;
                setState(() {

                });
              });
            }
        );
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
                child: Text('转出银行卡'),
              ),
            ),
            Positioned(
              left: 120,
              right: 15,
              top: 0,
              bottom: 0,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(bank == null? '请选择':bank),
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

  Widget buildWarn(String title){

    return Container(

      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
            child: Text(title,style: TextStyle(color: Color(0xffFD0000)),),
          )
        ],
      ),
    );
  }


}