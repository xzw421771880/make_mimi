
import 'package:flutter/material.dart';
import 'package:make_mimi/config/router_utils.dart';
import 'package:make_mimi/home/money/CommissionRecord.dart';
import 'package:make_mimi/utils/com_service.dart';


class InviteRecord extends StatefulWidget {


  @override
  _InviteRecordState createState() => _InviteRecordState();
}

class _InviteRecordState extends State<InviteRecord> {

  ScrollController _controller = new ScrollController();
  Map mydata = Map();
  List datalist = List();


  int totalSize = 0; //总条数
  String loadMoreText = "";
  TextStyle loadMoreTextStyle =
  new TextStyle(color: const Color(0xFF999999), fontSize: 14.0);
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    getData();

    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixel = _controller.position.pixels;
//      print(maxScroll);
//      print(pixel);
      if (maxScroll == pixel) {
        if (datalist.length < int.parse(mydata["count"])) {
          print("更多");
          setState(() {
            loadMoreText = "正在加载中...";
            loadMoreTextStyle =
            new TextStyle(color: const Color(0xFF4483f6), fontSize: 14.0);
          });
          loadMoreData();
        }
      } else {
        if (datalist.length == int.parse(mydata["count"])) {
          loadMoreText = "没有更多数据";
          loadMoreTextStyle =
          new TextStyle(color: const Color(0xFF999999), fontSize: 14.0);
          setState(() {

          });
        }
      }
    });
  }

  getData() {
    Map<String, dynamic> map = Map();

    map.putIfAbsent("page", () => currentPage);
    map.putIfAbsent("pageSize", () => 20);

    print(map);

    Com_Service().post(map, "/user/invite", (response) {

      print("邀请记录");
      print(response);
      mydata = response;
      if (currentPage == 1){
        datalist.clear();
      }
      datalist.addAll(response["list"]);
      print(datalist.length);
      setState(() {

      });
    }, (fail) {
      print("失败");

    });
  }

  //下拉
  Future _pullToRefresh() async {
    print("111");
    loadMoreText = "";
    currentPage = 1;
    getData();
    return null;
  }

  //加载列表数据
  loadMoreData() async {
    this.currentPage++;
    print("more");
    getData();
//    var start = (currentPage - 1) * pageSize;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
//        textTheme: TextTheme(subtitle: "充币"),
        backgroundColor: Colors.white,
        title: Text('邀请记录', style: TextStyle(fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Color(0xff333333),),),
        leading: new IconButton(icon: Icon(Icons.arrow_back_ios),
            color: Color(0xff333333),
            onPressed: () {
              Navigator.pop(context);
            }),
        elevation: 0,
      ),
      body: RefreshIndicator(
        child: ListView.builder(
            itemCount: datalist.length +3,
            itemBuilder: (BuildContext context,int index){

              if (index == 0){
                return buildTitle();
              }else if (index == datalist.length +2){
                return _buildProgressMoreIndicator();
              }else{
                return buildCells(index -1);
              }

            },
            controller: _controller,
        ),
        onRefresh: _pullToRefresh,
      ),
    );
  }

  Widget _buildProgressMoreIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(15.0),
      child: new Center(
        child: new Text(loadMoreText, style: loadMoreTextStyle),
      ),
    );
  }

  Widget buildTitle(){

    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(0),
            child: Container(
              height: 50,
              alignment: Alignment.center,
              child: Text('我的邀请',style: TextStyle(fontSize: 16),),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(0),
            child: Container(
              height: 150,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 20,
                    left: 60,
                    width: 100,
                    height: 100,
                    child: buildTitleSon(0),
                  ),
                  Positioned(
                    top: 20,
                    right: 50,
                    width: 100,
                    height: 100,
                    child: buildTitleSon(1),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(0),
            child: Container(
              color: Color(0xffeeeeee),
              height: 5,
            ),
          )
        ],
      ),
    );
  }

  Widget buildTitleSon(int index){

    List titleList = ['邀请人数','我的佣金'];
    List numberList = ['${mydata['count']}人',mydata['totalRevenue'].toString()];


    return GestureDetector(
      onTap: (){
        if (index == 1){
          Route_all.push(context, CommissionRecord("佣金记录",''));
        }
      },
      child: Container(

        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(.5,.5),
                spreadRadius: .3,
              )
            ]
        ),
        child: Stack(
          children: <Widget>[
            Positioned(

              left: 0,
              right: 0,
              top: 10,
              height: 40,
              child: Container(
                alignment: Alignment.center,
                child: Text(titleList[index]),
              ),
            ),
            Positioned(

              left: 0,
              right: 0,
              bottom: 10,
              height: 40,
              child: Container(
                alignment: Alignment.center,
                child: Text(numberList[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget buildCells(int index){


    List<String> listStr =[];
    if (index == 0){
      listStr = ['手机号','姓名','注册时间'];
    }else{
      Map user = datalist[index -1];

      String dataStr  = strToDate(int.parse(user["created_at"]));
      listStr = [user['mobile'].toString(),user['realname'] == null?'游客':user['realname'],dataStr];
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

  String strToDate(int dataStr){
    var date2 = DateTime.fromMillisecondsSinceEpoch(dataStr*1000);
    List<String> list  = date2.toString() .split('.');
//    print('------------------------时间戳转日期：${list[0]}');
    return list[0];
  }


  Positioned buildPosition(int index,String title){
    return Positioned(
      left:  5 +index *(MediaQuery.of(context).size.width - 10)/3,
      top: 0,
      bottom: 0,
      width: (MediaQuery.of(context).size.width - 10)/3,
      child:
      Container(

//        color: Colors.grey,
        alignment: Alignment.center,
        child: Text(title,maxLines: 1,style: TextStyle(
          fontSize: 13,
          color: Color(0xff555555),
        ),),
      ),
    );
  }



}