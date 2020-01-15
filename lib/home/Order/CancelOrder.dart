import 'package:flutter/material.dart';
import 'package:make_mimi/utils/RefundReason.dart';
import 'package:make_mimi/utils/com_service.dart';
import 'package:make_mimi/utils/showtoast_util.dart';

typedef backBlock();

class CancelOrder extends StatefulWidget {


  String orderId;
  backBlock back;
  CancelOrder(this.orderId,this.back);

  @override
  _CancelOrderState createState() => _CancelOrderState();
}

class _CancelOrderState extends State<CancelOrder> {


  String reson;
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
        title: Text('取消订单', style: TextStyle(fontSize: 15,
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
                  buildTextField(),
                  buildCell(),

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
                child: new Text('确认取消', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),

                ),
                onPressed: () {

                  print('确认取消');
                  commit();
                },
              )
          )
        ],
      ),
    );
  }




  Widget buildCell(){



    return GestureDetector(
      onTap: (){

        print('xz');
        showDialog(
            context: context,
            builder: (BuildContext context){
              return RefundReason(['快递一直未送达','商品破损/少件','商品与描述不符'],(resonBack){

                reson = resonBack;
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
                child: Text('取消原因'),
              ),
            ),
            Positioned(
              left: 100,
              right: 15,
              top: 0,
              bottom: 0,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(reson == null? '请选择':reson),
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

  Widget buildTextField(){


    return Container(
      height: 50,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 15,
            width: 80,
            top: 0,
            bottom: 0,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text('任务编号'),
            ),
          ),
          Positioned(
            left: 100,
            right: 15,
            top: 0,
            bottom: 0,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(widget.orderId),
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

  commit(){

    if(reson == null){
      showToast('请选择取消原因');
      return;
    }

    print("提交");
    Map<String, dynamic> map = Map();
    map.putIfAbsent("orderId", () => widget.orderId);
    map.putIfAbsent("content", () => reson);

    Com_Service().post(map, "/task/cancel-order", (response){

      print("取消成功");
      print(response);
      showToast("取消成功！！！");
      widget.back();
      Navigator.pop(context);
    }, (fail){

    });

  }



}