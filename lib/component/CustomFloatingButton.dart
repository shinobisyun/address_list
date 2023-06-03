import 'package:address_list/view/contactlist/AddContactPage.dart';
import 'package:flutter/material.dart';
import '../view/calendar/AddSchedulePage.dart';

Widget? CustomFloatingButton(BuildContext context, int selectedIndex){
  if(selectedIndex == 0){
    return null;
  }else if(selectedIndex == 1){
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.lightGreen,
      onPressed: () async {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddSchedulePage())
        );
      },
    );
  }else if(selectedIndex == 2){
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.indigo,
      onPressed: () async {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddContactPage())
        );
      },
    );
  }
}