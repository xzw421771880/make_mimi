

import 'package:flutter/material.dart';

typedef CurrentBack(int index);

class XjSelete extends StatelessWidget {

  List<String> titleList;
  CurrentBack currentBack;

  int currentIndex;
  XjSelete(this.titleList,this.currentBack,this.currentIndex);

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,
      child: Stack(
        children: getPositionList(context),
      ),
    );

  }
  List<Positioned> getPositionList(BuildContext context){


    List<Positioned> list = List<Positioned>();
    for(int i = 0;i<titleList.length;i++){
      list.add(buildSon(context, i, titleList[i], i==currentIndex?Colors.blue:Color(0xff333333)));
    }
    list.add(buildLine(context, currentIndex));
    return list;

  }
  Positioned buildLine(BuildContext context,int current){
    double titlewidth = MediaQuery.of(context).size.width/titleList.length;
    return Positioned(
      left: current *titlewidth + (titlewidth - 40)/2,
      height: 2,
      bottom: 0,
      width: 40,
      child: Container(
        color: Colors.blue,
      ),
    );
  }


  Positioned buildSon(BuildContext context, int index,String title,Color color){
    return Positioned(
      left: index *MediaQuery.of(context).size.width/titleList.length,
      top: 0,
      bottom: 0,
      width: MediaQuery.of(context).size.width/titleList.length,
      child:GestureDetector(
        onTap: (){
          currentBack(index);
        },
        child: Container(
          color: Colors.white,
          alignment: Alignment.center,
          constraints: BoxConstraints.expand(),
          child: Text(title,style: TextStyle(
            fontSize: 14,
            color: color,
          ),),
        ),
      )

    );
  }




}