import 'package:flutter/material.dart';


class OperationOrder extends StatefulWidget {


  @override
  _OperationOrderState createState() => _OperationOrderState();
}

class _OperationOrderState extends State<OperationOrder> {


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
        title: Text('操作任务', style: TextStyle(fontSize: 15,
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
            bottom: 60,
            child: ListView(
              children: <Widget>[
                buildItem(),
                buildTitle(0),
                buildWarn(),
                buildCell(0),
                buildCell(1),
                buildCell(2),
                buildCell(3),
                buildCellTitle(0),
                buildCellTitle(1),
                buildCellTitle(2),
                buildCellTitle(3),
                buildRequire(),
                buildTitle(1),
                buildAttention(),

                buildTitle(2),
                buildSteps()

              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).padding.bottom,
            height: 60,
            child: buildFoot(),

          )
        ],
      ),
    );
  }

  Widget buildItem(){

    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(0),
            child: Container(
              height: 60,
//              color: Colors.red,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 15,
                    top: 15,
                    child: Text('请注意核对店铺面'),
                  ),
                  Positioned(
                    right: 15,
                    top: 15,
                    child: Text('89分35秒内完成任务操作',textAlign: TextAlign.right,style: TextStyle(color: Color(0xFFEF5350)),),
                  ),
                  Positioned(
                    right: 15,
                    bottom: 5,
                    child: Text('20分35秒内完成链接核对',textAlign: TextAlign.right,style: TextStyle(color: Color(0xFFEF5350)),),
                  )
                ],
              ),
            ),

          ),
          Padding(
            padding: EdgeInsets.only(left: 15,top: 5,bottom: 5),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text('店铺名：**旗舰店',style: TextStyle(color: Color(0xFFEF5350)),),
            )
          ),
          Padding(
              padding: EdgeInsets.only(left: 15,top: 5,bottom: 5),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text('第一步：货比三家，找到店铺',style: TextStyle(color: Color(0xFF3699FF),fontSize: 20,fontWeight: FontWeight.bold),),
              )
          ),
          Padding(
              padding: EdgeInsets.only(left: 15,top: 5,bottom: 5),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text('目标商品',),
              )
          ),
          Padding(
            padding: EdgeInsets.all(0),
            child: Container(
              height: 120,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 15,
                    top: 0,
                    bottom: 20,
                    width: 100,
                    child: Container(
                      color: Colors.grey,
                    ),
                  ),
                  Positioned(
                    left: 120,
                    top: 5,
                    child: Text('搜索展示价格：1元')
                  ),
                  Positioned(
                      left: 120,
                      top: 30,
                      child: Text('商品成交价格：1元')
                  ),
                  Positioned(
                      left: 120,
                      top: 55,
                      child: Text('店铺销量：2181件')
                  )
                ],
              ),
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
            padding: EdgeInsets.only(left: 15,top: 5),
            child: Text('禁止通过淘宝客购买，商家很容易查到的，商家举报投诉的话，永久封号并且冻结资金',style: TextStyle(color: Color(0xffFF0000)),),
          )
        ],
      ),
    );
  }

  Widget buildRequire(){

    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 15,top: 5),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text('商家要求',style: TextStyle(fontSize: 15),),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 15,top: 5,bottom: 20),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text('一定要用关键系搜索，不领券199，接单后麻烦尽快付款',style: TextStyle(fontSize: 15,color: Colors.red),),
            ),
          ),
        ],
      ),
    );
  }


  Widget buildAttention(){

    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 15,top: 5),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text('与商家聊天过程切记不要出现“任务、刷单、做单”等词汇，按照正常购物流程和语气进行操作',style: TextStyle(fontSize: 15),),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 15,top: 5,bottom: 20),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text('1.商家全程不需要截图\n2.但是必须按照一样全程操作，平台会随机抽查，查到没按流程的封号处理',style: TextStyle(fontSize: 15,color: Colors.red),),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSteps(){

    return Container(
      child: Column(
        children: <Widget>[


          Padding(
            padding: EdgeInsets.only(left: 15,top: 5,bottom: 20),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text('·请确认使用哈哈哈账号登录\n·点击搜索框输入指定的关键词\n·按要求设置筛选价格区间、所在地、类目等搜索条件缩小查询范围，无需截图\n·任意点开一非目标商品，慢慢浏览至底部',style: TextStyle(fontSize: 15),),
            ),

          ),
          Padding(
            padding: EdgeInsets.only(left: 15,top: 5),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text('长按商品标题复制链接（如果验证有问题及时联系客服）',style: TextStyle(fontSize: 15,color: Colors.red),),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10,bottom: 20),
            child: Container(
              height: 45,
              color: Color(0xffeeeeee),
              child: TextField(
                textAlign: TextAlign.center,
//              style: TextStyle(textBaseline: TextBaseline.alphabetic),
                cursorColor: Colors.black,
                keyboardType: TextInputType.visiblePassword,
                decoration:  new InputDecoration(
                  hintText: '店铺名或链接或淘口令',
                  contentPadding: EdgeInsets.only(top: 12,bottom: 0),
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    fontSize: 16,
                  ),
                ),
                onChanged: (value){

                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 60,right: 60,top: 0,bottom: 15),
            child: Container(
              height: 35,
              child: MaterialButton(
                color: Colors.blue,
                padding: EdgeInsets.all(0),
                child: Text('校验',style: TextStyle(fontSize: 15),),
                textColor: Colors.white,
                onPressed: (){
                  print('校验');
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15,top: 5,bottom: 50),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text('由于部分店铺名称相似，请仔细核对，确保下单的店铺名和要求完全一致才能操作\n拍错店铺需自行承担损失\n（旗舰店≠专营店≠专卖店≠xx店）',style: TextStyle(fontSize: 15,color: Colors.red),),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTitle(int index){
    List titleList = ['任务要点','注意事项','任务步骤'];

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

  Widget buildCell(int index){
    List titleList = ['任务类型','搜索关键字','排序方式','所在地',];
    List detailList = ['手机淘宝任务无需截图','导入仪','综合','全国',];

    return Container(
      color: Colors.white,
      height: 50,
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
          Positioned(
            right: 15,
            width: 150,
            top: 0,
            bottom: 0,
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(detailList[index],),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            height: 1,
            bottom: 0,
            child: Container(
              color: Color(0xffdddddd),
            ),
          ),
        ],
      ),
    );
  }


  Widget buildCellTitle(int index){
    List titleList = ['不允许使用优惠券以及红包','允许使用花呗','允许使用信用卡','所在地不需要假聊'];
    return Container(
      color: Colors.white,
      height: 50,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 15,
            width: 200,
            top: 0,
            bottom: 0,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(titleList[index],),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            height: 1,
            bottom: 0,
            child: Container(
              color: Color(0xffdddddd),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFoot(){
    return Container(
      color: Colors.white,
//      color: Color(0xffeeeeee),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 20,
            width: 110,
            top: 10,
            height: 40,
            child: MaterialButton(
              color: Colors.blue,
              padding: EdgeInsets.all(0),
              child: Text('上一步',style: TextStyle(fontSize: 16),),
              textColor: Colors.white,
              onPressed: (){
                print('上一步');
              },
            ),
          ),
          Positioned(
            right: 20,
            width: 110,
            top: 10,
            height: 40,
            child: MaterialButton(
              color: Colors.blue,
              padding: EdgeInsets.all(0),
              child: Text('下一步',style: TextStyle(fontSize: 16),),
              textColor: Colors.white,
              onPressed: (){
                print('下一步');
              },
            ),
          )
        ],
      ),
    );
  }


}