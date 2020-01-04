

import 'package:flutter/material.dart';
import 'package:make_mimi/Task/Task.dart';
import 'package:make_mimi/home/Home.dart';

class Mimi extends StatefulWidget {

  @override
  _MimiState createState() => _MimiState();
}

class _MimiState extends State<Mimi> {


  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _list = List();


  @override
  void initState() {
//    print("river----init");
    super.initState();
    _list
      ..add(Home())
      ..add(Task());
  }

  void _onItemTapped(int index) {
    setState(() {
      print("river----${index}");
//      if (index == 1){
//        PropertyBus.fire("消息刷新");
//      }
//      if (index == 3){
//        MyBus.fire("消息刷新");
//      }
      if(index == 2){

      }
      _selectedIndex = index;

    });
  }

  @override
  Widget build(BuildContext context) {
//    print("river----init");
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _list,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('首页'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            title: Text('任务'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}