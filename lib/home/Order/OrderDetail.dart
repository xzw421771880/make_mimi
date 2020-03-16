import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:make_mimi/config/router_utils.dart';
import 'package:make_mimi/home/Complain/CommitComplain.dart';
import 'package:make_mimi/home/Order/Complete.dart';
import 'package:make_mimi/utils/Help.dart';
import 'package:make_mimi/utils/com_service.dart';
import 'package:make_mimi/utils/showtoast_util.dart';


class OrderDetail extends StatefulWidget {

  String orderId;
  OrderDetail(this.orderId);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {


  Map orderInfo;
  Map orderMold = Map();
  List requires = List();
  Map orderStatus = Map();

  @override
  void initState() {
    super.initState();
    getOrderInfo();
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
      orderStatus = response['range']['orderStatus'];
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
        title: Text('任务订单详情', style: TextStyle(fontSize: 15,
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

            child: Text('发起申诉', style: TextStyle(color: Color(0xff333333),),),
            onPressed: () {
              print("111");
              Route_all.push(context, CommitComplain(widget.orderId));
            },
          )

        ],
      ),
      body: ListView(

        children: <Widget>[

          buildTitle(0),
          buildDetail([
            orderInfo == null ? '**' : orderStatus[orderInfo['status']
                .toString()]
          ]),
          buildTitle(1),
          orderInfo == null ? Container() :
          buildItem(),
          orderInfo == null?Container():
          buildTypeTitle(),
          orderInfo == null?Container():
          buildSDetail(),
          buildTitle(2),
          orderInfo == null ? Container() :
          buildDetail([
            '${orderInfo['shop_name']}(${orderMold[orderInfo['task_mold']]})',
            '任务编号：${orderInfo['id']}',
            '本金：${orderInfo['goods_deal_price']}元',
            '佣金：${orderInfo['task_commission']}元',
            '派单时间：${Helps().strToDate(int.parse(orderInfo['updated_at']))}'
          ]),

          buildTitle(3),
          buildRequire(),

        ],
      ),
    );
  }

  Widget buildItem() {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
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
                      top: 10,
                      child: Text('商品名称：${orderInfo['goods_name']}')
                  ),
                  Positioned(
                      left: 120,
                      top: 40,
                      child: Text('商品成交价格：${orderInfo['goods_deal_price']}元')
                  ),
                  Positioned(
                      left: 120,
                      top: 70,
                      child: Text('每单商品数量：${orderInfo['goods_count']}件')
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildTitle(int index) {
    List titleList = ['任务状态', '商品信息', '任务信息', '任务要求'];

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

  Widget buildDetail(List list) {
    List <Padding> padList = [];
    for (int i = 0; i < list.length; i++) {
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

  Widget buildRequire() {
    List <Padding> padList = [];
    for (int i = 0; i < requires.length; i++) {
      padList.add(
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Container(
              alignment: Alignment.centerLeft,
              height: 40,
              color: Colors.white,
              child: Text(
                  '${requires[i]['task_require_name']}${requires[i]['item_order_require'] ==
                      null ? '' : '（${requires[i]['item_order_require']}）'}'),
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


  Widget buildTypeTitle(){
    Map molds = orderInfo['range']['task_mold'];

    String type = molds[orderInfo['task_mold']];


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
              child: Text('任务属性：${type}',),
            ),
          ),

        ],
      ),
    );
  }


  Widget buildSDetail(){

    if(orderInfo['task_mold'] == '1'){
      return buildDetailSearch();
    }else if(orderInfo['task_mold'] == '2'){

      return buildDetailPaste();
    }else{

      return buildDetailCode();
    }

  }

  Widget buildDetailSearch(){

    Map sorts = orderInfo['range']['find_sort'];

    String sort = sorts[orderInfo['find_sort']];

    List<Padding> padList = List();
    List titleList = ['搜索关键字：${orderInfo['order_keyword']}','定位排序：${sort}','定位付款数量：${orderInfo['find_pay_conut']}','定位价格区间：${orderInfo['find_price_min']} - ${orderInfo['find_price_max']}','定位发货区域：${orderInfo['find_send_area']}'];

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
  Widget buildDetailPaste(){

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
              child: Text(orderInfo['order_tpassword']),
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
                            text: orderInfo['order_tpassword']);
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
  Widget buildDetailCode(){

    Image image = Image.network(orderInfo['order_qrcode']);

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

  _testSaveImg (Image image) async {

    print('保存图片88888');
    print("_onImageSaveButtonPressed");

    // 这个图片的地址是本地的文件进行测试 要引入,import 'package:flutter/services.dart' show rootBundle;
    ByteData bytes = await rootBundle.load(orderInfo['order_qrcode']);
//    ByteData bytes = await rootBundle.l
    final result = await ImageGallerySaver.saveImage(bytes.buffer.asUint8List()); //这个是核心的保存图片的插件
    print(result);   //这个返回值 在保存成功后会返回true
    if(result){
      print('保存成功');

//    Fluttertoast.showToast(msg: '保存成功', fontSize: 14,gravity: ToastGravity.CENTER,timeInSecForIos: 1,textColor: Colors.white,);
    }else{
      print('保存失败');
//    Fluttertoast.showToast(msg: '保存失败', fontSize: 14,gravity: ToastGravity.CENTER,timeInSecForIos: 1,textColor: Colors.white,);
    }

  }


}