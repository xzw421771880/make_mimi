
import 'dart:io';

import 'package:city_pickers/city_pickers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:make_mimi/config/router_utils.dart';
import 'package:make_mimi/home/blind/TbCase.dart';
import 'package:make_mimi/utils/Help.dart';
import 'package:make_mimi/utils/RefundReason.dart';
import 'package:make_mimi/utils/com_service.dart';
import 'package:make_mimi/utils/showtoast_util.dart';


class BlindTb extends StatefulWidget {

  Map data;
  BlindTb(this.data);

  @override
  _BlindTbState createState() => _BlindTbState();
}

class _BlindTbState extends State<BlindTb> {


  String tb_name;
  String tb_level = '1';
  String tb_type = '心';
  String tb_sex = '男';
  String consignee;
  String consignee_num;
  String address;

//  File tbFile;
//  File zfbFile;
//  File xjFile;

  String tbStr;
  String zfbStr;
  String xjStr;
  String province;
  String city;
  String area;

  @override
  void initState() {
    super.initState();
    tb_name = widget.data['taobao_name'] == null?'':widget.data['taobao_name'];
    tb_level = widget.data['taobao_level'] == null?'1':widget.data['taobao_level'].toString();
    tb_type = widget.data['level_type'] == null?'心':['心','黄钻','黄冠','金冠'][int.parse(widget.data['level_type']) -1];
//
    tb_sex = widget.data['taobao_sex'] == null?'':widget.data['taobao_sex'];
    consignee = widget.data['consignee'] == null?'':widget.data['consignee'];
    consignee_num = widget.data['consignee_num'] == null?'':widget.data['consignee_num'];
    address = widget.data['detailed_address'] == null?'':widget.data['detailed_address'];
    province = widget.data['province'] == null?'':widget.data['province'];
    city = widget.data['city'] == null?'':widget.data['city'];
    area = widget.data['district'] == null?'':widget.data['district'];

    if(widget.data['taobao_info'] != null){
      List images = widget.data['taobao_info'].toString().split(',');
      tbStr = images[0];
      xjStr = images[1];
    }

    zfbStr = widget.data['alipay_info'] == null?null:widget.data['alipay_info'];



  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
//        textTheme: TextTheme(subtitle: "充币"),
        backgroundColor: Colors.white,
        title: Text('绑定淘宝', style: TextStyle(fontSize: 15,
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

                  buildWarn(),
                  buildText(0),
//                  buildText(1),
                  buildCell(0),
                  buildCell(1),
                  buildCell(2),
                  buildText(2),
                  buildText(3),
                  buildCell(3),
                  buildText(4),
                  buildImagetitle(),
                  buildImages(0),
                  buildImages(1),
                  buildImages(2),
                ],
              )
          ),widget. data['status'] == '0'||widget. data['status'] == '1'?Container():
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

                  commit();
                  print('确认提交');
                },
              )
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
            padding: EdgeInsets.all(15),
            child: Text('淘宝号最少3心，会员名不是手机号，打开手机淘宝->我的淘宝->右上角设置，进入以后就能看到自己的淘宝会员名了',maxLines: 10,style: TextStyle(color: Color(0xffFD0000)),),
          ),
          Padding(
            padding: EdgeInsets.only(left: 50,right: 50,top: 5,bottom: 15),
            child: Container(
              height: 150,
              child: Image(image: AssetImage('images/home/home_blind_tbmess.png'),fit: BoxFit.cover,),
            ),
          )
        ],
      ),
    );
  }

  Widget buildCell(int index){

    List titleList = ['淘宝号心级','淘宝心级类型','淘宝号性别','收货省市'];
    List detailList = [tb_level,tb_type,tb_sex,province == null?'请选择':province+city+area];


    return GestureDetector(
      onTap: () async{

        if(index == 0){
          showDialog(
              context: context,
              builder: (BuildContext context){
                return RefundReason(['1','2','3','4','5'],(resonBack){

                  tb_level = resonBack;
                  setState(() {

                  });
                });
              }
          );
        }

        if(index == 1){
          showDialog(
              context: context,
              builder: (BuildContext context){
                return RefundReason(['心','黄钻','黄冠','金冠'],(resonBack){

                  tb_type = resonBack;
                  setState(() {

                  });
                });
              }
          );
        }
        if(index == 2){
          showDialog(
              context: context,
              builder: (BuildContext context){
                return RefundReason(['男','女'],(resonBack){

                  tb_sex = resonBack;
                  setState(() {

                  });
                });
              }
          );
        }

        if(index == 3){
          Result result = await CityPickers.showCityPicker(
              context: context, height: 300.0);
          print(result);
          this.setState(() {
            province = result.provinceName;
            city = result.cityName;
            area = result.areaName;
          });
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
              right: 45,
              top: 0,
              bottom: 0,
              width: 150,
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(detailList[index],style: TextStyle(fontWeight: FontWeight.bold),),
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
      ),
    );
  }

  Widget buildImagetitle(){


    return GestureDetector(
      onTap: (){

        print('查看示例');
        Route_all.push(context, TbCase());
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
                child: Text('上传淘宝截图'),
              ),
            ),
            Positioned(
              right: 15,
              top: 0,
              bottom: 0,
              width: 150,
              child: Container(
                alignment: Alignment.centerRight,
                child: Text('查看示例',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.grey),),
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
      ),
    );
  }

  Widget buildText(int index){

    List titleList = ['淘宝会员名','淘宝号心级','收货人','收货人手机','收货详细地址'];
    List hintList = ['请输入淘宝会员名','请输入心级','收货人姓名（必须与淘宝一致）','请输入收货人手机','详细地址'];

    List<TextInputType> inputList = [TextInputType.text,TextInputType.phone,TextInputType.text,TextInputType.phone,TextInputType.text];

    return Container(
      height: 50,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 15,
            width: 90,
            top: 0,
            bottom: 0,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(titleList[index]),
            ),
          ),
          Positioned(
            left: 110,
            right: 15,
            top: 0,
            bottom: 0,
            child: TextField(
//              style: TextStyle(textBaseline: TextBaseline.alphabetic),
              cursorColor: Colors.grey,
              keyboardType: inputList[index],
              decoration:  new InputDecoration(
                hintText: hintList[index],
                contentPadding: EdgeInsets.only(top: 14,bottom: 0),
                border: InputBorder.none,
                hintStyle: TextStyle(
                  fontSize: 14,
                ),
              ),
              controller: TextEditingController.fromValue(TextEditingValue(
                text: [tb_name,tb_level,consignee,consignee_num,address][index]
              )),

              onChanged: (value){

                if(index == 0) {

                  tb_name = value;
                }else if(index == 1) {
                  tb_level = value;
                }else if(index == 2) {
                  consignee = value;
                }else if(index == 3) {
                  consignee_num = value;
                }else {
                  address = value;
                }
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


  Widget buildImages(int index){

    Image image;


    if(index == 0){
      if(tbStr == null){
        image = Image(image: AssetImage('images/home/home_blind_tb.png'));
      }else{
        image = Image.network(tbStr,fit: BoxFit.cover,);
      }
    }else if(index == 1){
      if(zfbStr== null){
        image = Image(image: AssetImage('images/home/home_blind_zfb.png'));
      }else{
        image = Image.network(zfbStr,fit: BoxFit.cover,);
      }
    }else{
      if(xjStr == null){
        image = Image(image: AssetImage('images/home/home_blind_tbxj.png'));
      }else{
        image = Image.network(xjStr,fit: BoxFit.cover,);
      }
    }







    return Container(
      height:  190,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 50,
            top: 40,
            width: 100,
            height: 100,
            child: GestureDetector(
              onTap: (){
                alert(index);
              },
              child: image,
            ),
          ),
        ],
      ),
    );
  }

  alert(int index){
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

//    saveFile(image, index);
    _uploadImage(image, index);
  }

  //相册选择
  Future _getImageFromGallery(int index) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    _uploadImage(image, index);
//    saveFile(image, index);


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
      if (index == 0){
        tbStr = response['url'];
      }else if(index == 1){
        zfbStr = response['url'];
      }else{
        xjStr = response['url'];
      }
      setState(() {

      });


    }, (fail){

    });
  }


  commit(){

    if (tb_name == null){
      showToast('请输入淘宝名');
      return;
    }

    if (tb_level == null){
      showToast('请输入淘宝号心级');
      return;
    }

    if (consignee == null){
      showToast('请输入收货人');
      return;
    }

    if (consignee_num == null){
      showToast('请输入收货人手机号');
      return;
    }

    if (!Helps().isChinaPhoneLegal(consignee_num)){

      showToast('手机号码格式不正确');
      return;
    }



    if (province == null){
      showToast('请选择省市区');
      return;
    }

    if (address == null){
      showToast('请输入详细地址');
      return;
    }

    if(tbStr == null){
      showToast('请上传淘宝截图');
      return;
    }

    if(zfbStr == null){
      showToast('请上传支付宝截图');
      return;
    }

    Map<String, dynamic> map = Map();

    map.putIfAbsent("taobao_name", () => tb_name);
    map.putIfAbsent("taobao_level", () => tb_level);
    map.putIfAbsent("level_type", () => tb_type);
    map.putIfAbsent("taobao_sex", () => tb_sex);
    map.putIfAbsent("consignee", () => consignee);
    map.putIfAbsent("consignee_num", () => consignee_num);
    map.putIfAbsent("province", () => province);
    map.putIfAbsent("city", () => city);
    map.putIfAbsent("district", () => area);
    map.putIfAbsent("detailed_address", () => address);
    map.putIfAbsent("taobao_info", () => tbStr+','+xjStr);
    map.putIfAbsent("alipay_info", () => zfbStr);

    print(map);

    Com_Service().post(map, "/user/commit-check", (response) {

      print("登录成功");
      print(response);
      showToast('提交成功,审核中');
      Navigator.pop(context);
    }, (fail) {
      print("失败");

    });
  }



}