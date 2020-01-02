import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:make_mimi/utils/com_service.dart';
import 'package:make_mimi/utils/loading.dart';
import 'package:make_mimi/utils/showtoast_util.dart';
class FeedBackVc extends StatefulWidget {
  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBackVc> {

//  UserService userService = UserService();
  String oldPass;
  String newPass;
  String againPass;

  String word;

  List<File> images = List<File>();
  List<String> imageStrs = List<String>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
//        textTheme: TextTheme(subtitle: "充币"),
        backgroundColor: Colors.white,
        title: Text('留言反馈', style: TextStyle(fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Color(0xff333333),),),
        leading: new IconButton(icon: Icon(Icons.arrow_back_ios),
            color: Color(0xff333333),
            onPressed: () {
              Navigator.pop(context);
            }),
        elevation: 0,
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
                top: 15,
                left: 15,
                width: MediaQuery
                    .of(context)
                    .size
                    .width - 30,
                height: 315,
                child: Container(
                  color: Color(0xffeeeeee),
                  child: TextField(
                    maxLines: 13,
                    maxLength: 300,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 15),
                    decoration: InputDecoration(
                      hintText: "请输入留言内容",
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15),
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
                )

            ),
            Positioned(
              top: 350,
              height: 70,
              left: 15,
              right: 15,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (BuildContext context, int index) {

                  return buildImage(context, index);

                },
              ),
            ),
            Positioned(
                top: 440,
                height: 55,
                left: 15,
                width: 55,
                child:GestureDetector(
                  onTap: alert,
                  child: Image(
                    image: AssetImage("images/home/leave_tjtp1_normal.png"),
                  ),
                )
            ),
            Positioned(

              left: 0,
              bottom: MediaQuery.of(context).padding.bottom,
              height: 50,
              right: 0,
              child: MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,

                child: new Text('提交', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),),
//            shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.all(Radius.circular(15)),
//            ),
                onPressed: () {
                  print("提交");

                  imageAllUpdate();
//                  commit();
                },
              ),
            )

          ],
        ),
      ),
    );
  }
  alert(){
    print("666");
    if(images.length >=5){
      showToast("最多上传5张");
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

  //拍照
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

  Widget buildImage(BuildContext, int index){
    return Container(
      width: 70,


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

  imageAllUpdate(){
    if(word == null||word.length == 0){
      showToast("请输入留言");
      return;
    }
    if(images.length > 0){
      imageStrs = List<String> ();
      showDialog<Null>(
          context: context,
          builder: (BuildContext context) {
            return  LoadingDialog(false,"上传中");
          }
      );
      for (int i = 0; i< images.length;i++){
        _uploadImage(images[i]);
      }
    }else{
      commit();
    }

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
      imageStrs.add(response["url"]);
      print("已添加");
      print(images.length);
      print(imageStrs.length);
      if(images.length == imageStrs.length){
        print("已加满");
        Navigator.pop(context);
        commit();
      }

//      if (file == zmImage){
//        zmStr = response["data"]["url"];
//      }else{
//        fmStr = response["data"]["url"];
//      }
//      setIdentity();

    }, (fail){

    });
  }

  commit(){


    print("999");
    String img = imageStrs.join(",");
    print(img);

    print("提交");
    Map<String, dynamic> map = Map();
    map.putIfAbsent("content", () => word);
    map.putIfAbsent("img", () => img);

    Com_Service().post(map, "/site/leave-message", (response){

      print("留言成功");
      print(response);
      showToast("留言成功！！！");
      Navigator.pop(context);
    }, (fail){

    });

  }

}