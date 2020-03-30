
import 'package:flutter/material.dart';
import 'package:make_mimi/utils/Help.dart';
import 'package:make_mimi/utils/com_service.dart';


class CommissionRecord extends StatefulWidget {

  String title;
  String type;

  CommissionRecord(this.title,this.type);

  @override
  _CommissionRecordState createState() => _CommissionRecordState();
}

class _CommissionRecordState extends State<CommissionRecord> {

  Map mydata = Map();
  List dataList = List();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {

    //1充值, 2提现, 3充值保证金, 4提出保证金 5商品垫付金额 6任务费用 7用户返本金 8用户返佣 9返佣提成10佣金提现
    print("getuser --------------");
    Map<String, dynamic> map = Map();
    map.putIfAbsent("page", () => 1);
    map.putIfAbsent("pageSize", () => 20);
    map.putIfAbsent("type", () => widget.type);
    Com_Service().post(map, "/user/operatin", (response) {
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
          title: Text(widget.title, style: TextStyle(fontSize: 15,
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
            itemCount: dataList.length + 1,
            itemBuilder: (BuildContext context,int index){

              return buildCells(index);
            }
        ),
    );
  }


  Widget buildCells(int index){

    List<String> listStr =[];
    if (index == 0){
      listStr = ['订单号','类别','金额','日期'];
    }else{
      Map model = dataList[index - 1];
      Map type = mydata['range']['type'];
      String time = Helps().strToDate(int.parse(model['created_at']));
      print(time);
      print(model);
      listStr = [model['id'],type[model['type']],model['amount'],time];
    }

    List<Positioned>  list = getDataList(listStr);
    return Container(
      height: 40,
      color: Colors.white,
      child: Stack(
        children: list,
      ),
    );
  }

  List<Positioned> getDataList(List listStr){

//    String dataStr  = strToDate(int.parse(record["created_at"]));

//    List<String> listStr = [dataStr,record["currency_name"],record["amount"],record["fee"] ,statusList[int.parse(record["status"])]];

    List<Positioned>  list = new List<Positioned>();
    for(int i = 0;i< listStr.length;i++){
      list.add(buildPosition(i,listStr[i]));
    }
    return list;
  }



  Positioned buildPosition(int index,String title){
    return Positioned(
      left:  5 +index *(MediaQuery.of(context).size.width - 10)/4,
      top: 0,
      bottom: 0,
      width: (MediaQuery.of(context).size.width - 10)/4,
      child:
      Container(

//        color: Colors.grey,
        alignment: Alignment.center,
        child: Text(title,maxLines: 2,style: TextStyle(
          fontSize: 13,
          color: Color(0xff555555),
        ),),
      ),
    );
  }

}