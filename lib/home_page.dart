import 'package:flutter/material.dart';

import 'chatPage.dart';
import 'my_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _selectIndex = 0;

  final _pages = <Widget>[
    const MyPage(),
    const ChatPage(),
  ];

  void _onTapItem(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            label: 'トーク',
          ),
        ],
        currentIndex: _selectIndex,
        onTap: _onTapItem,
      ),
    );
  }
}
