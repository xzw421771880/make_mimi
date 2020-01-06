import 'package:flutter/material.dart';
import 'package:make_mimi/utils/Help.dart';
import 'package:make_mimi/utils/com_service.dart';


class TopupRecord extends StatefulWidget {


  @override
  _TopupRecordState createState() => _TopupRecordState();
}

class _TopupRecordState extends State<TopupRecord> {



  Map mydata = Map();
  List dataList = List();


  int totalSize = 0; //总条数
  String loadMoreText = "";
  TextStyle loadMoreTextStyle =
  new TextStyle(color: const Color(0xFF999999), fontSize: 14.0);
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    print("getuser --------------");
    Map<String, dynamic> map = Map();
    map.putIfAbsent("page", () => 1);
    map.putIfAbsent("pageSize", () => 20);
    map.putIfAbsent("type", () => 3);
    Com_Service().get(map, "/user/deposit", (response) {
      print("提现记录");
      print(response);

      mydata = response;
      dataList.addAll(response['list']);
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
        title: Text('充值记录', style: TextStyle(fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Color(0xff333333),),),
        leading: new IconButton(icon: Icon(Icons.arrow_back_ios),
            color: Color(0xff333333),
            onPressed: () {
              Navigator.pop(context);
            }),
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: dataList.length,
          itemBuilder: (BuildContext context,int index){
            return buildCell(index);
          }),
    );
  }

  Widget buildCell(int index){

    Map item = dataList[index];

    List statusList = ['处理中','通过','不通过','打款中','已打款'];



    return GestureDetector(
      onTap: (){
//        Route_all.push(context, ComplainDetail());
      },
      child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(0),
                child: Container(
                  height: 5,
                  color: Color(0x99eeeeee),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(0),
                child: Container(
                  height: 30,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 15,
                        width: 150,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text('佣金提现'),
                        ),
                      ),
                      Positioned(
                        right: 15,
                        width: 150,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(statusList[int.parse(item['status']) ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Container(
                  height: 30,
                  alignment: Alignment.centerLeft,
                  child: Text('开户人：${item['real_name']}'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Container(
                  height: 30,
                  alignment: Alignment.centerLeft,
                  child: Text('提现银行：${item['bank']}'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Container(
                  height: 30,
                  alignment: Alignment.centerLeft,
                  child: Text('银行账号：${item['card_num']}'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(0),
                child: Container(
                  height: 30,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 15,
                        width: 150,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text('提现金额：${item['amount']}'),
                        ),
                      ),
                      Positioned(
                        right: 15,
                        width: 150,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(Helps().strToDate(int.parse(item['created_at']) )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width - 85,right: 20,top: 10,bottom: 10),
                child: GestureDetector(
                  onTap: (){
                    print('删除');
                  },
                  child: Container(
                    height: 25,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      //设置填充颜色
                      color: Colors.grey,
                      // 圆角度
                      borderRadius: new BorderRadius.circular(6),
//                    border: Border.all(color: Colors.blue,width: .5),
                    ),
                    child: Text('删除',style: TextStyle(color: Colors.white,fontSize: 15),),
                  ),
                ),
              )
            ],
          )

      ),
    );
  }


}