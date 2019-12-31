
import 'package:flutter/material.dart';

typedef backSelete(String reason);

class RefundReason extends StatefulWidget {

  backSelete back;
  List data;
  RefundReason(this.data,this.back);
  @override
  _RefundReasonState createState() => _RefundReasonState();
}

class _RefundReasonState extends State<RefundReason> {

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
                  left: 0,
                  right: 0,
                  height: 400,
                  bottom: MediaQuery
                      .of(context)
                      .padding
                      .bottom,
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
                            alignment: Alignment.centerLeft,
                            color: Color(0xffeeeeee),
                            height: 50,
                            child: Text('      请选择',style: TextStyle(
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
                              itemCount: widget.data.length,
                              itemBuilder:(BuildContext context,int index){
                                return buildCell(context,index);
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

    String title = widget.data[index];


    return GestureDetector(
      onTap: (){
        widget.back(title);
        Navigator.pop(context);
      },
      child: Container(
        height: 50,
        alignment: Alignment.center,
        color: Colors.white,
        child: Text(title),
      ),
    );
  }



}