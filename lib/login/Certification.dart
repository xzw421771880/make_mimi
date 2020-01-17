import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:make_mimi/config/router_utils.dart';
import 'package:make_mimi/login/CertificationCase.dart';
import 'package:make_mimi/utils/com_service.dart';
import 'package:make_mimi/utils/showtoast_util.dart';

typedef blockBack();

class Certification extends StatefulWidget {

  blockBack back;

  Certification(this.back);

  @override
  _CertificationState createState() => _CertificationState();
}

class _CertificationState extends State<Certification> {

  String name;
  String idCard;

  String zmStr;
  String fmStr;
  String scStr;


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
        title: Text('实名认证', style: TextStyle(fontSize: 15,
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
                  buildWarn(),
                  buildImage(0),
                  buildImage(1),
                  buildImage(2),
                  Container(height: 30,)

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
                child: new Text('提交认证', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),

                ),
                onPressed: () {

                  commit();
                },
              )
          )
        ],
      ),
    );
  }


  Widget buildCell(int index){

    List titleList = ['姓名','身份证号码'];
    List hintList = ['请输入姓名','请输入身份证号码'];


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
              child: Text(titleList[index]),
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
              decoration:  new InputDecoration(
                hintText: hintList[index],
                contentPadding: EdgeInsets.only(top: 14,bottom: 0),
                border: InputBorder.none,
                hintStyle: TextStyle(
                  fontSize: 14,
                ),
              ),
              onChanged: (value){
                if (index == 0){
                  name = value;
                }else{
                  idCard = value;
                }

              },
            ),
          ),
          Positioned(
            left: 5,
            right: 5,
            bottom: 0,
            height: 1,
            child: Container(
              color: Color(0xffeeeeee),
            ),
          )
        ],
      ),
    );
  }

  Widget buildWarn(){

    return Container(
      child: Column(

        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(0),
            child: Container(
              height: 35,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 20,
                    top: 15,
                    right: 120,
                    child: Text('可在不遮挡身份证的前提下盖上纸条'),
                  ),
                  Positioned(
                    width: 100,
                    top: 0,
                    right: 20,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: (){
                        print('查看示例');
                        Route_all.push(context, CertificationCase());
                      },
                      child: Container(
                        color: Color(0xffffff),
                        alignment: Alignment.bottomRight,
                        child: Text('查看实例',style: TextStyle(color: Color(0xff555555)),),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20,right: 15,top: 10,bottom: 5),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text('署名加备注：“仅用户实名认证，不可用于其他任何用途'),
            ),

          )
        ],
      ),
    );
  }

  Widget buildImage(int index){
    List titleList = ['身份证正面图片','身份证反面图片','手持身份证图片'];
    Image image;
    if(index == 0){
      image = zmStr == null? Image(image: AssetImage('images/login/register_certi_add.png')):Image.network(zmStr,fit: BoxFit.cover,);
    }else if(index == 1){
      image = fmStr == null? Image(image: AssetImage('images/login/register_certi_add.png')):Image.network(fmStr,fit: BoxFit.cover,);
    }else{
      image = scStr == null? Image(image: AssetImage('images/login/register_certi_add.png')):Image.network(scStr,fit: BoxFit.cover,);
    }

    return Container(
      height: 250,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 20,
            right: 20,
            top: 10,
            bottom: 10,
            child: GestureDetector(
              onTap: (){
                print(index);
                alert(index);
              },
              child: Container(
                color: Colors.white,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: (MediaQuery.of(context).size.width - 120)/2,
                      top: 50,
                      width: 80,
                      height: 80,
                      child: image,
                    ),
                    Positioned(
                      left: 0,
                      bottom: 30,
                      right: 0,
                      child: Text(titleList[index],textAlign: TextAlign.center,style: TextStyle(fontSize: 17,color:Colors.grey),),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  alert(int index){
    print("666");

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
                _getImageFromCamera(index);
              },
            ),
            new SimpleDialogOption(
              child: new Text('相册',textAlign: TextAlign.center,style: TextStyle(

                  fontSize: 17
              ),),
              onPressed: () {
                Navigator.of(context).pop();
                _getImageFromGallery(index);
              },
            ),
          ],
        );
      },
    ).then((val) {
      print(val);
    });
  }

  //拍照
  Future _getImageFromCamera(int index) async {
    var image =
    await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 400);

    setState(() {
      _uploadImage(image, index);
    });
  }

  //相册选择
  Future _getImageFromGallery(int index) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _uploadImage(image, index);
    });
  }

  //上传图片到服务器
  _uploadImage(File file,int index) async {

    String path = file.path;
    var name1 = path.substring(path.lastIndexOf("/") + 1, path.length);
    FormData formData = FormData.fromMap({
      //"": "", //这里写其他需要传递的参数
//      "file": zmImage,_
      "file": await MultipartFile.fromFile(path,filename: name1),
    });

    Com_Service().POSTIMAGE(formData, "/site/upload-image", (response){

      print(response);
      if(index == 0){
        zmStr = response['url'];
      }else if(index == 1){
        fmStr = response['url'];
      }else{
        scStr = response['url'];
      }
      setState(() {

      });

    }, (fail){

    });
  }

  commit(){
    if(name == null){
      showToast('请输入真实姓名');
      return;
    }

    if(idCard== null){
      showToast('请输入身份证号码');
      return;
    }

    if(zmStr == null){
      showToast('请选择身份证正面图片');
      return;
    }

    if(fmStr == null){
      showToast('请选择身份证反面图片');
      return;
    }

    if(scStr == null){
      showToast('请选择手持身份证图片');
      return;
    }




    Map<String, dynamic> map = Map();

    print('3333');
    map.putIfAbsent("realname", () => name);
    map.putIfAbsent("id_card_num", () => idCard);
    map.putIfAbsent("id_card_head", () => zmStr);
    map.putIfAbsent("id_card_tail", () => fmStr);

    map.putIfAbsent("declaration", () => scStr);


    print(map);


    Com_Service().post(map, "/user/identity", (response) {

      print("提交成功");
      print(response);
      showToast('成功提交认证，请等待审核');
      widget.back();
      Navigator.pop(context);
//      Navigator.pop(context);
    }, (fail) {

      print("失败");

    });
  }


}