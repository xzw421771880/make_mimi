
import 'package:flutter/material.dart';
import 'package:make_mimi/utils/MeColor.dart';


class AlertGo extends StatefulWidget {

//  List data = ;
//  AlertGo(this.data);
  @override
  _AlertGoState createState() => _AlertGoState();
}

class _AlertGoState extends State<AlertGo> {

  List data = ['1：实名认证','2：绑定三方平台账号','3：领取任务'];
  List detailList = ['提交身份证正反面照片及手持身份证照片','输入第三方平台账号信息以及上传任务截图信息','按照任务类型及对应要求完成并提交任务'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }



//class Specifial extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0x00000000),
        body: Stack(
            children: <Widget>[
              Positioned(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
              Positioned(
                  left: 50,
                  right: 50,
                  height: 400,
                  top: (MediaQuery.of(context).size.height - 400)/2,
                  child: Container(
                    color: Colors.white,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 0,
                          top: 0,
                          right:  0,
                          height: 50,
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            child: Text('做任务分三步',style: TextStyle(
                                fontSize: 17
                            ),),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 50,
                          bottom: 0,
                          child: ListView.builder(
                              itemCount: data.length +1,
                              itemBuilder:(BuildContext context,int index){
                                if (index == data.length){

                                  return buildBut();
                                }else{
                                  return buildCell(context,index);
                                }

                              }
                          ),
                        )
                      ],
                    ),
                  )
              )
            ]
        )
    );
  }

  Widget buildCell(BuildContext context,int index){

    String title = data[index];
    String detail = detailList[index];


    return Container(
//        height: 50,
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 40,right: 20,bottom: 5,top: 5),
              child: Container(
                alignment: Alignment.centerLeft,
                height: 25,
                child: Text(title,style: TextStyle(fontWeight: FontWeight.bold),),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 45,right: 20,bottom: 5,top: 5),
              child: Container(
                alignment: Alignment.centerLeft,
//                height: 25,
                child: Text(detail,style: TextStyle(color: Colors.grey),),
              ),
            )
          ],
        ),
      );
  }

  Widget buildBut(){

    return Container(
      height: 100,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: (MediaQuery.of(context).size.width - 180)/2,
            width: 80,
            top: 30,
            height: 40,
            child: MaterialButton(

                padding: EdgeInsets.all(0),
                color: Colors.grey,
                child: Text('开始赚钱',style: TextStyle(color: Colors.white),),
                onPressed: (){

                  Navigator.pop(context);
                }

            ),


          )
        ],
      ),
    );
  }



}