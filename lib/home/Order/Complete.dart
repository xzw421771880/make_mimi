import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:make_mimi/utils/com_service.dart';
import 'package:make_mimi/utils/loading.dart';
import 'package:make_mimi/utils/showtoast_util.dart';

typedef backBlock();
class Complete extends StatefulWidget {


  String orderId;
  backBlock back;
  Complete(this.orderId,this.back);


  @override
  _CompleteState createState() => _CompleteState();
}

class _CompleteState extends State<Complete> {


  List<File> images = List<File>();
  List<String> imageStrs = List<String>();

  Map orderInfo;
  Map orderMold = Map();
  List requires = List();
  List requiresImage = List();

  List progress = List();
  int progressed = 0;

  Timer timer;

  int count = 60;
  String butStr = '确认提交';
  int status = 0;//0可以提交 1倒计时 2下一步

  @override
  void initState() {
    super.initState();
    getOrderInfo();
  }


  void _initTimer() {
    count = int.parse(progress[progressed]['wait_second']) ;
    timer = new Timer.periodic(Duration(seconds: 1), (Timer timer) {
      count--;
      setState(() {
        if (count == 0) {
          timer.cancel(); //倒计时结束取消定时器
          progressed ++; //重置时间
          if (progressed >= progress.length){
            butStr = '确认提交';
            status = 0;
          }else{
            status = 2;
            butStr = '下一步';//更新文本内容
          }
           //重置按钮文本
        } else {
          status = 1;
          butStr = '下一步（还剩${count}s）';
        }
      });
    });
  }

  ///销毁计时器
  @override
  void dispose() {
    timer?.cancel(); //销毁计时器
    timer = null;
    super.dispose();
  }

  getOrderInfo() {
    Map<String, dynamic> map = Map();
    map.putIfAbsent("orderId", () => widget.orderId);
    Com_Service().post(map, "/task/order-info", (response) {
      print("订单详情");
      print(response);
      orderInfo = response;
      orderMold = response['range']['order_mold'];
      requires = response['requires'];
      print('requires');
      print(requires);

      for(int i = 0;i<requires.length;i++){
        if (requires[i]['is_require_snapshot'] == '1'){
          print(requires[i]);
          requiresImage.add(requires[i]);
          images.add(null);
        }

        if (requires[i]['is_screen_wait'] == '1'){
          print(requires[i]);
          progress.add(requires[i]);
        }


      }

      _initTimer();

      setState(() {
        print("更新");
      });
//      print(meModel.balanceUsdt);
    }, (fail) {

    });
  }


  warn(){
    showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return  AlertDialog(
          title:  Text('警告'),
          content:  SingleChildScrollView(
            child:  ListBody(
              children: <Widget>[
                Text('退出任务将中断，是否确认退出', style: TextStyle(
                  ///字体颜色
                  color: Colors.red,
                  ///字体的大小
                  fontSize: 16,
                )),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child:  Text('确定'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child:  Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
//        textTheme: TextTheme(subtitle: "充币"),
        backgroundColor: Colors.white,
        title: Text('确认完成订单', style: TextStyle(fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Color(0xff333333),),),
        leading: new IconButton(icon: Icon(Icons.arrow_back_ios),
            color: Color(0xff333333),
            onPressed: () {

              if(progress.length>0){
                warn();
              }else{
                Navigator.pop(context);
              }

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
                  orderInfo == null?Container():buildDetail(['${orderInfo['shop_name']}(${orderMold[orderInfo['task_mold']]})','任务编号：${orderInfo['id']}','本金：${orderInfo['goods_deal_price']}元','佣金：${orderInfo['task_commission']}元']),

                  buildTitle(1),
                  buildProgress(),
                  requiresImage.length == 0?Container():
                  buildTitle(2),


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
                color: status == 1?Colors.grey: Colors.blue,
                textColor: Colors.white,
                child: new Text(butStr, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),

                ),
                onPressed: () {

                  print('确认提交');
                  if (status == 0){
                    imageAllUpdate();
                  }

                  if (status == 2){
                    _initTimer();
                  }

//                  Route_all.push(context, Login());
                },
              )
          )
        ],
      ),
    );
  }

  Widget buildTitle(int index){
    List titleList = ['任务信息','完成进度','上传评价截图'];

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

    List <Padding> list = List();
    for (int i = 0;i < requiresImage.length;i++){
      print(requiresImage);
      print(requiresImage[i]);
      list.add(
          Padding(
            padding: EdgeInsets.all(0),
            child: Container(
              height: 160,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 15,
                    top: 0,
                    height: 40,
                    width: 250,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text('${requiresImage[i]['task_require_name']}（截图）'),
                    ),
                  ),
                  Positioned(
                    left: 15,
                    top: 40,
                    height: 100,
                    width: 100,
                    child: GestureDetector(
                      onTap: (){
                        print('点击选择');
                        alert(i);
                      },
                      child:images[i] == null? Container(
                        color: Color(0xffaaaaaa),
                        alignment: Alignment.center,
                        child: Text('点击选择图片'),
                      ):Image.file(images[i],fit: BoxFit.cover,),
                    ),
                  ),
                  Positioned(
                    left: 15,
                    right: 15,
                    height: 1,
                    bottom: 1,
                    child: Container(
                      color: Color(0xffcccccc),
                    ),
                  )
                ],
              ),
            ),
          ),
      );
    }

    return Container(
      color: Colors.white,
      child: Column(
        children: list,
      ),
    );
  }


  Widget buildProgress(){

    List <Padding> list = List();
    for (int i = 0;i < progress.length;i++){
//      print(requiresImage);
      print(progress[i]);
      list.add(
        Padding(
          padding: EdgeInsets.all(0),
          child: Container(
            height: 50,
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 15,
                  top: 10,
                  height: 30,
                  width: 250,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child:Text(progress[i]['task_require_name']+'（需等待' +progress[i]['wait_second']+'s）'+ (progressed >i ? '已完成':'未完成')),
//                    Text('${progress[i]['task_require_name']}（截图）'),
                  ),
                ),
//                Positioned(
//                  left: 15,
//                  top: 40,
//                  height: 100,
//                  width: 100,
//                  child: GestureDetector(
//                    onTap: (){
//                      print('点击选择');
//                      alert(i);
//                    },
//                    child:images[i] == null? Container(
//                      color: Color(0xffaaaaaa),
//                      alignment: Alignment.center,
//                      child: Text('点击选择图片'),
//                    ):Image.file(images[i],fit: BoxFit.cover,),
//                  ),
//                ),
                Positioned(
                  left: 15,
                  right: 15,
                  height: 1,
                  bottom: 1,
                  child: Container(
                    color: Color(0xffcccccc),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      color: Colors.white,
      child: Column(
        children: list,
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

  Future _getImageFromCamera(int index) async {
    var image =
    await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 400);

    setState(() {
      images.replaceRange(index, index +1, [image]);
    });
  }

  //相册选择
  Future _getImageFromGallery(int index) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      images.replaceRange(index, index +1, [image]);
    });
  }


  imageAllUpdate(){

    int index = -1;
    for (int i = 0; i< images.length;i++){
      if (images[i] == null){
        index = i;
        break;
      }
    }

    if (index != -1){
      showToast('请选择${requiresImage[index]['task_require_name']}（截图）');
      return;
    }

    if(requiresImage.length > 0){
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

    }, (fail){

    });
  }

  commit(){


    print("999");
    String img = imageStrs.join(",");
    print(img);

    print("提交");
    Map<String, dynamic> map = Map();
    map.putIfAbsent("orderId", () => widget.orderId);
    map.putIfAbsent("images", () => img);

    Com_Service().post(map, "/task/finish-order", (response){

      print("提交成功");
      print(response);
      showToast("提交成功！！！");
      Navigator.pop(context);
    }, (fail){

    });

  }



}