
import 'package:flutter/material.dart';
import 'package:make_mimi/utils/Help.dart';
import 'package:make_mimi/utils/com_service.dart';


class ComplainDetail extends StatefulWidget {

  String id;

  ComplainDetail(this.id);

  @override
  _ComplainDetailState createState() => _ComplainDetailState();
}

class _ComplainDetailState extends State<ComplainDetail> {

  Map data;


  @override
  void initState() {
    super.initState();
    getDetail();
  }

  getDetail() {
    print("getuser --------------");
    Map<String, dynamic> map = Map();
    map.putIfAbsent("id", () => widget.id);
    Com_Service().post(map, "/appeal/appeal-details", (response) {
      print("商品详情");
      print(response);
      data = response;

      setState(() {
        print("更新");
      });
//      print(meModel.balanceUsdt);
    }, (fail) {

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
//        textTheme: TextTheme(subtitle: "充币"),
        backgroundColor: Colors.white,
        title: Text('申诉详情', style: TextStyle(fontSize: 15,
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
          itemCount: 8,
          itemBuilder: (BuildContext context,int index){

            if (index == 7){
              return buildImage();
            }else {
              return buildCell(index);
            }
          }
      ),
    );
  }

  Widget buildCell(int index){

    List list = ['任务ID： ${data == null?'**': data['task_num']}','申述店铺：${data == null?'**': data['task_num']}','申述类型：${data == null?'**': data['appeal_type']}','申述状态：客服通过申述','申述时间：${data == null?'**':Helps().strToDate(data['created_at'])  }','申述内容：${data == null?'**': data['appeal_state']}','申述图片：'];

    return Container(

      color: Colors.white,
      height: 40,
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
          )
        ],
      ),
    );
  }

  Widget buildImage(){

    List images = data['appeal_img'].toString().split(',');

    List<Padding> pads = List();
    for (int i = 0;i<images.length;i++){

      pads.add(Padding(padding: EdgeInsets.only(left: 50,right: 50,top: 10,bottom: 10),
        child: Container(
          height: 150,
          child: Image.network(images[i]),
        ),
      ));
    }

    return Container(
      color: Colors.white,
      child:Column(
        children: pads,
      )
    );
  }


}