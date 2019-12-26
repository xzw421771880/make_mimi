import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:make_mimi/utils/RefundReason.dart';


class CommitComplain extends StatefulWidget {


  @override
  _CommitComplainState createState() => _CommitComplainState();
}

class _CommitComplainState extends State<CommitComplain> {


  String reson;
  String word;
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
        title: Text('提交申诉', style: TextStyle(fontSize: 15,
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
                  buildTitle(0),
                  buildExplain(),
                  buildTitle(1),
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
              return RefundReason((resonBack){

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
                child: Text('申诉类型',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
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
              child: Text('任务编号',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
            ),
          ),
          Positioned(
            left: 100,
            right: 15,
            top: 0,
            bottom: 0,
            child: TextField(
//              style: TextStyle(textBaseline: TextBaseline.alphabetic),
              cursorColor: Colors.grey,
              keyboardType: TextInputType.visiblePassword,
              decoration:  new InputDecoration(
                hintText: '请输入要取消的编号',
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

  Widget buildExplain(){
    return Container(

      height: 150,
      color: Colors.white,
      child: TextField(
        maxLines: 13,
        maxLength: 300,
//        style: TextStyle(
//            color: Colors.black54,
//            fontSize: 15),
        decoration: InputDecoration(
          hintText: "请输入申述说明",
          hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 13),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color:  Color(0xffffff),
//                        width: ScreenUtil.instance.setWidth(1.0)
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffffff),
//                        width: ScreenUtil.instance.setWidth(1.0)
            ),
          ),
        ),
        onChanged: (value){
          print(value);
          word = value;
        },
      ),
    );
  }

  Widget buildTitle(int index){

    List titleList = ['申诉说明','添加图片证据（最多可上传2张）'];
    return Container(

        height: 50,
        color: Colors.white,
        child: Stack(
        children: <Widget>[
        Positioned(
        left: 15,
        top: 0,
        bottom: 0,
        right: 15,
        child: Container(
        alignment: Alignment.centerLeft,
        child: Text(titleList[index],style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
    ),
    ),]));
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