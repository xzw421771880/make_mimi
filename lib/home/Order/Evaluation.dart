import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class Evaluation extends StatefulWidget {


  @override
  _EvaluationState createState() => _EvaluationState();
}

class _EvaluationState extends State<Evaluation> {


  List<File> images = List<File>();
  List<String> imageStrs = List<String>();

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
        title: Text('上传评价截图', style: TextStyle(fontSize: 15,
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
                  buildTitle(0),
                  buildDetail(['××旗舰店(淘宝垫付单）','任务编号：123456','本金：1254元','佣金：111元']),
                  buildTitle(1),

                  Container(
                    height: 20,
                  ),
                  buildImages(),

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
    List titleList = ['任务信息','上传评价截图'];

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

  Widget buildDetail(List list){

    List <Padding> padList = [];
    for (int i = 0;i<list.length;i++){
      padList.add(
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Container(
              alignment: Alignment.centerLeft,
              height: 40,
              color: Colors.white,
              child: Text(list[i]),
            ),
          )
      );
    }

    return Container(

      child: Column(
        children: padList,
      ),
    );


  }

  Widget buildImages(){

    return Container(
      color: Colors.white,
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length +1,
        itemBuilder: (BuildContext context, int index) {

          if(index == 0){

            return buildAdd(context, index);
          }else{
            return buildImage(context, index -1);
          }

        },
      ),
    );
  }

  Widget buildImage(BuildContext context, int index){
    return Container(
      width: 120,


//      color: Colors.red,
      child: Stack(
        children: <Widget>[
          Positioned(

            top: 5,
            left: 0,
            right: 15,
            bottom: 0,
            child: Image.file(images[index],fit: BoxFit.cover,),
          ),
          Positioned(

              top: 0,
              right: 10,
              height: 20,
              width: 20,
              child: GestureDetector(
                onTap: (){
                  images.removeAt(index);
                  setState(() {

                  });
                },
                child: Image(image: AssetImage("images/home/leave_cha4_normal.png"),),
              )

          )
        ],
      ),
    );
  }

  Widget buildAdd(BuildContext context, int index){

    return GestureDetector(
      onTap: alert,
      child: Container(
          width: 135,
          child: Stack(
              children: <Widget>[
                Positioned(

                  top: 5,
                  left: 10,
                  right: 15,
                  bottom: 0,
                  child: Image(image: AssetImage('images/home/leave_tjtp1_normal.png'),),
                ),
              ]
          )
      ),
    );


  }

  alert(){
    print("666");
    if(images.length >=5){
//      showToast("最多上传5张");
      return;
    }
    showDialog<Null>(
      context: context,
      builder: (BuildContext context) {
        return new SimpleDialog(
          title: new Text('选择图片',textAlign: TextAlign.center,style: TextStyle(

              fontSize: 19
          ),),
          children: <Widget>[
            new SimpleDialogOption(
              child: new Text('相机',textAlign: TextAlign.center,style: TextStyle(

                fontSize: 17,
              ),),
              onPressed: () {
                Navigator.of(context).pop();
                _getImageFromCamera();
              },
            ),
            new SimpleDialogOption(
              child: new Text('相册',textAlign: TextAlign.center,style: TextStyle(

                  fontSize: 17
              ),),
              onPressed: () {
                Navigator.of(context).pop();
                _getImageFromGallery();
              },
            ),
          ],
        );
      },
    ).then((val) {
      print(val);
    });
  }

  Future _getImageFromCamera() async {
    var image =
    await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 400);

    setState(() {
      images.add(image);
    });
  }

  //相册选择
  Future _getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      images.add(image);
    });
  }



}