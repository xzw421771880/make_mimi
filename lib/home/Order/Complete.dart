import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:make_mimi/utils/CheckUrl.dart';
import 'package:make_mimi/utils/Help.dart';
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

  List checkUrlList = List();

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


      List items = orderInfo['union'];
      checkUrlList.clear();
      for (int i = 0;i<items.length+1;i++){
        checkUrlList.add("0");
      }



      setState(() {
        print("更新");
      });

      _initTimer();


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

    double sum = 0.00;
    bool checkAll = false;
    if (orderInfo !=null){

      sum += double.parse(orderInfo['goods_deal_price']) ;

      List items = orderInfo['union'];
      for (int i = 0;i<items.length;i++){
        sum += double.parse(items[i]['goods_deal_price']) * int.parse(items[i]['goods_count']);
      }
      checkAll = true;
      for(int i = 0;i<checkUrlList.length;i++){
        if(checkUrlList[i] == '0'){
          checkAll = false;
          break;
        }
      }
    }




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

                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(15),
                    child:
              Text('垫付任务请确认任务中本金是否与要购买的垫付任务商品的实际付款价格相同，如商品实际购买价格与任务的本金金额不一致，请取消订单或联系客服！',style: TextStyle(color: Colors.red),),
                  ),

                  buildTitle(0),
                  orderInfo == null?Container():
                  buildItem(),
                  buildTitle(1),
                  orderInfo == null?Container():buildDetail(['${orderInfo['shop_name']}(${orderMold[orderInfo['task_mold']]})','任务编号：${orderInfo['id']}','本金：${sum.toStringAsFixed(2)}元','佣金：${orderInfo['task_commission']}元']),

                  progress.length == 0?Container():
                  buildTitle(2),
                  buildProgress(),
                  requiresImage.length == 0?Container():
                  buildTitle(3),


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

                  if(checkAll == false){
                    showToast("请验证商品");
                    return;
                  }
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
    List titleList = ['商品验证','任务信息','完成进度','上传评价截图'];

    return Container(
      color: Helps().home,
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

  Widget buildItem() {
    print('union');
    print(orderInfo['union']);

    List items = orderInfo['union'];

    List<Padding> padList = List();

    padList.add(Padding(
      padding: EdgeInsets.all(0),
      child: Container(
        height: 120,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 15,
              top: 10,
              bottom: 10,
              width: 100,
              child: Image.network(
                orderInfo['goods_pic'], fit: BoxFit.cover,),
            ),
            Positioned(
                left: 120,
                right: 15,
                top: 10,
                child: Text('商品名称：${orderInfo['goods_name']}',maxLines: 1,style: TextStyle(fontSize: MediaQuery.of(context).size.width/414*15),)
            ),
            Positioned(
                left: 120,
                top: 60,
                child: Text('商品成交价格：${orderInfo['goods_deal_price']}元',style: TextStyle(fontSize: MediaQuery.of(context).size.width/414*14))
            ),
            Positioned(
                left: 120,
                top: 90,
                child: Text('每单商品数量：${orderInfo['goods_count']}件',style: TextStyle(fontSize: MediaQuery.of(context).size.width/414*14))
            ),
            Positioned(
                height: 25,
                width: 70,
                right: 15,
                bottom: 50,
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  color: Helps().home,
                  onPressed: (){
                    showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return Scaffold(
                            backgroundColor: Color(0x00000000),
                            body: GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: ListView(
                                children: <Widget>[
                                  Container(
                                    height: 300,
                                    color: Colors.transparent,
//                          ),
                                  ),

                                  buildSDetail(orderInfo),
//                      )
                                ],
                              ),
                            ),
                          );
                        }
                    );
                  },
                  child: Text('查看属性',),
                )
            ),
            Positioned(
                height: 25,
                width: 70,
                right: 15,
                bottom: 10,
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  color: Helps().home,
                  onPressed: (){

                    if(checkUrlList[0] == "0"){
                      showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return CheckUrl(orderInfo['goods_url'], (value){

                              if(value == '0'){
                                showToast("验证失败");
                              }
                              checkUrlList.replaceRange(0, 1, [value]);
                              setState(() {

                              });
                            });
                          }
                      );
                    }

                  },
                  child: Text(checkUrlList[0] == "1"?"验证通过" :'验证商品',),
                )
            ),
            Positioned(
              left: 15,
              right: 15,
              height: .5,
              bottom: 0,
              child: Container(
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    ));

    for(int i = 0;i<items.length;i++){
      padList.add(Padding(
          padding:EdgeInsets.all(0),
//        padding: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
          child: GestureDetector(
            onTap: (){

              print(i);
            },
            child: Container(
              height: 120,
              color: Colors.white,
              child:Stack(
                children: <Widget>[
                  Positioned(
                    left: 15,
                    top: 10,
                    bottom: 10,
                    width: 100,
                    child: Image.network(
                      items[i]['goods_pic'], fit: BoxFit.cover,),
                  ),
                  Positioned(
                      left: 120,
                      right: 15,
                      top: 10,
                      child: Text('商品名称：${items[i]['goods_name']}',maxLines: 3,style: TextStyle(fontSize: MediaQuery.of(context).size.width/414*15),)
                  ),
                  Positioned(
                      left: 120,
                      top: 60,
                      child: Text('商品成交价格：${items[i]['goods_deal_price']}元',style: TextStyle(fontSize: MediaQuery.of(context).size.width/414*14))
                  ),
                  Positioned(
                      left: 120,
                      top: 90,
                      child: Text('每单商品数量：${items[i]['goods_count']}件',style: TextStyle(fontSize: MediaQuery.of(context).size.width/414*14))
                  ),
                  Positioned(
                      height: 25,
                      width: 70,
                      right: 15,
                      bottom: 50,
                      child: FlatButton(
                        padding: EdgeInsets.all(0),
                        color: Helps().home,
                        onPressed: (){
                          showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return Scaffold(
                                  backgroundColor: Color(0x00000000),
                                  body: GestureDetector(
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                    child: ListView(
                                      children: <Widget>[
                                        Container(
                                          height: 300,
                                          color: Colors.transparent,
//                          ),
                                        ),

                                        buildSDetail(items[i]),
//                      )
                                      ],
                                    ),
                                  ),
                                );
                              }
                          );
                        },
                        child: Text('查看属性',),
                      )
                  ),
                  Positioned(
                      height: 25,
                      width: 70,
                      right: 15,
                      bottom: 10,
                      child: FlatButton(
                        padding: EdgeInsets.all(0),
                        color: Helps().home,
                        onPressed: (){

                          if(checkUrlList[i+1] == "0"){
                            showDialog(
                                context: context,
                                builder: (BuildContext context){
                                  return CheckUrl(items[i]['goods_url'], (value){

                                    if(value == '0'){
                                      showToast("验证失败");
                                    }
                                    checkUrlList.replaceRange(i+1, i+2, [value]);
                                    setState(() {

                                    });
                                  });
                                }
                            );
                          }

                        },
                        child: Text(checkUrlList[i+1] == "1"?"验证通过" :'验证商品',),
                      )
                  ),
                  Positioned(
                    left: 15,
                    right: 15,
                    height: .5,
                    bottom: 0,
                    child: Container(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),

          )


      ));
    }

    return Container(
      color: Colors.white,
      child: Column(
        children:padList,
      ),
    );
  }


  Widget buildSDetail(Map item){

    if(item['task_mold'] == '1'){
      return buildDetailSearch(item);
    }else if(item['task_mold'] == '2'){

      return buildDetailPaste(item);
    }else{

      return buildDetailCode(item);
    }

  }

  Widget buildDetailSearch(Map item){

    Map sorts = orderInfo['range']['find_sort'];

    String sort = sorts[item['find_sort']];

    List<Padding> padList = List();
    List titleList = ['搜索关键字：${item['order_keyword'] == null?'':item['order_keyword']}',
      '定位排序：${sort== null?'':sort}',
      '定位付款数量：${item['find_pay_conut'] == null?'':item['find_pay_conut']}',
      '定位价格区间：${item['find_price_min'] == null?'':item['find_price_min']} - ${item['find_price_max']== null?'':item['find_price_max']}',
      '定位发货区域：${item['find_send_area'] == null?'':item['find_send_area']}'];

    for(int i = 0;i<titleList.length;i++){
      padList.add(Padding(
        padding: EdgeInsets.only(left: 15,top: 0,bottom: 0),
        child: Container(
          alignment: Alignment.centerLeft,
          height: 40,
          child: Text(titleList[i]),
        ),
      ));
    }

    return Container(
      color: Colors.white,
      child: Column(
        children: padList,
      ),
    );
  }

  //淘口令
  Widget buildDetailPaste(Map item){

    //order_tpassword
    return Container(
//      height: 50,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20,top: 20,right: 20,bottom: 10),
            child: Container(
              alignment: Alignment.center,
              child: Text(item['order_tpassword']),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              height: 35,
              child: MaterialButton(
                color: Colors.grey,
                child: Text('复制口令',style: TextStyle(color: Colors.white),),
                onPressed: (){

                  ClipboardData data = new ClipboardData(
                      text: item['order_tpassword']);
                  Clipboard.setData(data);
                  showToast('复制成功',);
                },
              ),
            ),
          )
        ],
      ),
    );
  }


  //二维码
  Widget buildDetailCode(Map item){

    Image image = Image.network(item['order_qrcode']);

    return Container(
      height: 180,
      color: Colors.white,
//child: Text('esdsd'),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 10,
            left: 30,
            width: 150,
            height: 150,
            child: GestureDetector(
              child: image,
              onLongPress: (){
                print('长按---');
//                _testSaveImg(image);
              },
            ),
          ),
//          Positioned(
//            top: 40,
//            left: 200,
//            width: 70,
//            height: 50,
//            child: Container(
//              alignment: Alignment.centerLeft,
//              child: Text('长按二维码保存到相册'),
//            ),
//          )
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

    print("333");
    print(progress.length);
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
      widget.back();
      Navigator.pop(context);
    }, (fail){

    });

  }



}