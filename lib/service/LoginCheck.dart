import 'package:address_list/mapper/CalendarDataSynchronism.dart';
import 'package:address_list/mapper/ContactDataSynchronism.dart';
import 'package:flutter/material.dart';
import 'package:address_list/GlobalVariable.dart';

Future<int> LoginCheck(TextEditingController usr,TextEditingController psd) async{
  final table = 'user';
  //final columns = ['id','username', 'password'];
  final where = 'username = ${usr.text}';

  try{
    final results = await mysql.Select(
      table,
      //columns: columns,
      where: where,
    );
    if(results.isEmpty || results == null){
      return 0;
    }
    else if(results.map((row) => row.fields).toList()[0]['password'] == psd.text){
      userID = results.map((row) => row.fields).toList()[0]['id'];
      userPhoneNumber = results.map((row) => row.fields).toList()[0]['username'];
      SaveContactData();
      SaveCalendarData();
      return 1;
    }else{
      return 2;
    }
  }catch(e){
    print('Connection error: $e');
    mysql.ConnectToDatabase();
    return -1;
  }
}