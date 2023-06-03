import 'package:flutter/material.dart';

var buttonItem = const <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Icon(Icons.phone),
    label: '通话',
    activeIcon: Icon(Icons.phone_in_talk)
  ),
  /*BottomNavigationBarItem(
    icon: Icon(Icons.messenger_outline),
    label: '消息',
    activeIcon: Icon(Icons.message)
  ),*/
  BottomNavigationBarItem(
    icon: Icon(Icons.calendar_today_outlined),
    label: '日程',
    activeIcon: Icon(Icons.calendar_month_outlined)
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.people_alt_outlined),
    label: '联系人',
    activeIcon: Icon(Icons.people_alt)
  ),
];

class BottomNavigationBarTool extends BottomNavigationBar{
  int cur;
  void Function(int)? onPress;
  BottomNavigationBarTool({super.key, required this.cur, this.onPress}) :super(
    items: buttonItem,
    currentIndex: cur,
    onTap: onPress,
    backgroundColor: Colors.grey[850],
    selectedItemColor: Colors.grey[300],
    unselectedItemColor: Colors.grey[600],
    type: BottomNavigationBarType.fixed,
  );
}