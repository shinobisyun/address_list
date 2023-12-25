import 'package:address_list/GlobalVariable.dart';
import 'package:address_list/component/CustomFloatingButton.dart';
import 'package:address_list/view/calendar/AddSchedulePage.dart';
import 'package:flutter/material.dart';
import 'NavigationBar.dart';
import '../view/contactlist/ContactListPage.dart';
import '../view/calendar/CalendarPage.dart';
import '../view/callpage/CallPage.dart';
import '../view/MessagePage.dart';
import 'AppBar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int selectedIndex = 0;
  final List<Widget> pages = [
    CallPage(),
    //MessagePage(),
    CalendarPage(),
    AddressBookPage(),
  ];
  bool isFirst = true;
  BuildContext? ct;

  @override
  Widget build(BuildContext context) {
    if(isFirst){
      isFirst = false;
      ct = context;
      _initState();
    }
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBarTool(
        cur: selectedIndex,
        onPress: (index){
          if(index != selectedIndex){
            setState(() {
              selectedIndex = index;
            });
          }
        },
      ),
      floatingActionButton: CustomFloatingButton(context, selectedIndex)
    );
  }
  void _initState(){
    int? passedValue = ModalRoute.of(context)!.settings.arguments as int?;   //接受Navigator.push的传值
    if(passedValue != null){
      selectedIndex = passedValue;
    }
  }
}