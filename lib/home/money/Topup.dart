import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:image_picker/image_picker.dart';
import 'package:make_mimi/config/router_utils.dart';
import 'package:make_mimi/home/money/TopupRecord.dart';
import 'package:make_mimi/utils/RefundReason.dart';
import 'package:make_mimi/utils/com_service.dart';
import 'package:make_mimi/utils/showtoast_util.dart';


class Topup extends StatefulWidget {


  @override
  _TopupState createState() => _TopupState();
}

class _TopupState extends State<Topup> {

  String amount = '1000';
  String content = '';
  String pzStr;

  @override
  void initState() {
    super.initState();
    getAmount();
    getContent();
  }

  getAmount() {
    print("getuser --------------");
//    user_deposit
//    recharge-account
    Map<String, dynamic> map = Map();
    map.putIfAbsent("key", () => 'user_deposit');
    Com_Service().post(map, "/site/get-sys", (response) {
      print("详情");
      print(response);
      amount = response['value'];

      setState(() {
        print("更新");
      });
//      print(meModel.balanceUsdt);
    }, (fail) {

    });
  }

  getContent() {
    print("getuser --------------");
//    user_deposit
//    recharge-account
    Map<String, dynamic> map = Map();
    map.putIfAbsent("key", () => 'recharge-account');
    Com_Service().post(map, "/site/get-sys", (response) {
      print("详情");
      print(response);
      content = response['value'];

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
//      resizeToAvoidBottomPadding: false,
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
                  Html(padding: EdgeInsets.only(left: 15,top: 10,right: 15), data: content),
                  buildTitle(1),

                  buildMessage(0),
                  buildTitle(2),
                  buildImage(),
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
                  commit();
//                  Route_all.push(context, Login());
                },
              )
          )
        ],
      ),
    );
  }

  Widget buildTitle(int index){
    List titleList = ['平台收款账号','提交转账信息','上传凭证'];

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

    List list = ['转账金额（元）：${amount}元'];

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

  Widget buildImage(){

    Image image = pzStr == null? Image(image: AssetImage('images/login/register_certi_add.png')):Image.network(pzStr,fit: BoxFit.cover,);


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
                alert();
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
                      child: Text('请上传凭证',textAlign: TextAlign.center,style: TextStyle(fontSize: 17,color:Colors.grey),),
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

  alert(){
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

  //拍照
  Future _getImageFromCamera() async {
    var image =
    await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 400);

    setState(() {
      _uploadImage(image);
    });
  }

  //相册选择
  Future _getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _uploadImage(image);
    });
  }

  //上传图片到服务器
  _uploadImage(File file) async {

    String path = file.path;
    var name1 = path.substring(path.lastIndexOf("/") + 1, path.length);
    FormData formData = FormData.fromMap({
      //"": "", //这里写其他需要传递的参数
//      "file": zmImage,_
      "file": await MultipartFile.fromFile(path,filename: name1),
    });

    Com_Service().POSTIMAGE(formData, "/site/upload-image", (response){

      print(response);
      pzStr = response['url'];

      setState(() {

      });

    }, (fail){

    });
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

  commit(){





    if (amount == null){

      showToast('请输入提现金额');
      return;
    }

    if (pzStr == null){

      showToast('请上传凭证');
      return;
    }



    Map<String, dynamic> map = Map();

    print('3333');

    map.putIfAbsent("amount", () => amount);
    map.putIfAbsent("proof", () => pzStr);

    print(map);

    Com_Service().post(map, "/user/recharge", (response) {

      print("提现成功");
      print(response);
      showToast('提交成功');
      Navigator.pop(context);
    }, (fail) {
      print("失败");

    });
  }


}