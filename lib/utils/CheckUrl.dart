
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:make_mimi/utils/Help.dart';

typedef backSelete(String reason);

class CheckUrl extends StatefulWidget {

  backSelete back;
  String url;
  CheckUrl(this.url,this.back);
  @override
  _CheckUrlState createState() => _CheckUrlState();
}

class _CheckUrlState extends State<CheckUrl> {

  String input;

//  List data = ['快递一直未送达','商品破损/少件','商品与描述不符'];

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
                left: 20,
                right: 20,
                height: 250,
                bottom: 200,
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
                          color: Color(0xffeeeeee),
                          height: 50,
                          child: Text('请输入商品地址',textAlign: TextAlign.center,style: TextStyle(
                              fontSize: 17
                          ),),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        top: 80,
                        right:  20,
                        height: 50,
                        child: TextField(
//              style: TextStyle(textBaseline: TextBaseline.alphabetic),
                          cursorColor: Colors.grey,
                          keyboardType: TextInputType.visiblePassword,
                          decoration:  new InputDecoration(
                            hintText: "请输入或粘贴商品地址",
                            contentPadding: EdgeInsets.only(top: 14,bottom: 0),
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          onChanged: (value){

                            input = value;
                          },
                        ),
                      ),

                      Positioned(
                        left: 20,
                        top: 130,
                        right:  20,
                        height: .5,
                        child: Container(
                          color: Colors.grey,
                        ),
                      ),

                      Positioned(
                        left: 20,
                        top: 160,
                        right:  20,
                        height: 40,
                        child: FlatButton(
                          color: Helps().home,
                            onPressed: (){
                              print("验证");
                              if(input == widget.url){
                                widget.back("1");
                                print("1");
                              }else{
                                widget.back("0");
                                print("0");
                              }
                              Navigator.pop(context);
                            },
                            child: Text('确认')
                        ),
                      ),


                    ],
                  ),
                )
            )
          ],
        )
    );
  }

//  Widget buildCell(BuildContext context,int index){
//
//    String title = widget.data[index];
//
//
//    return GestureDetector(
//      onTap: (){
//        widget.back(title);
//        Navigator.pop(context);
//      },
//      child: Container(
//        height: 50,
//        alignment: Alignment.center,
//        color: Colors.white,
//        child: Text(title),
//      ),
//    );
//  }



}